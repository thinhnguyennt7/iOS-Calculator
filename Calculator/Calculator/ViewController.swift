//
//  ViewController.swift
//  Calculator
//
//  Created by Thinh Nguyen on 1/14/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

// Creat modes of the operator
enum modes {
    case not_set
    case adddition
    case substraction
    case multiplication
    case division
    case percent
}

class ViewController: UIViewController {

//    THE LABEL TEXT UPDATE
    @IBOutlet weak var label: UILabel!
    
    
    //    INITIALIZE INSTANCE VARIABLES
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false
    
    
//    DEFINE FUNCTION VIEWDICLOAD()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    DEFINE FUNCTION MEMORRY()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    CONTROL NUMBERS BUTTON
    @IBAction func didPressNumber(_ sender: UIButton) {
        
        //Create a contant string Value
        let stringValue:String? = sender.titleLabel?.text
        
        // Go back to zero at the label text field when user hit any operator
        if (lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
       
        // Appending to keep concatenate the number next to it
        labelString = labelString.appending(stringValue!)
        
        //Update the text
        updateText()
        
    }
    
    //    CONTROL THE MINUS BUTTON
    @IBAction func didPressMinus(_ sender: AnyObject) {
        changeMode(newMode: .substraction)
    }
    
    //    CONTROL THE DIVIDE BUTTOM
    @IBAction func didPessDivide(_ sender: AnyObject) {
        changeMode(newMode: .division)
    }
    
    //    CONTROL THE MULTIPLY BUTTON
    @IBAction func didPressMultiply(_ sender: AnyObject) {
        changeMode(newMode: .multiplication)
    }
    
    //    CONTROL THE ADDITION
    @IBAction func didPressAddition(_ sender: AnyObject) {
        changeMode(newMode: .adddition)
    }
    
    //    CONTROL THE % BUTTON
    @IBAction func didPressPercent(_ sender: AnyObject) {
        changeMode(newMode: .percent)
    }
    
    //    CONTROL THE EQUAL BUTTON
    @IBAction func didPressEqual(_ sender: AnyObject) {
        
        // Convert string value to an int
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if (currentMode == .not_set || lastButtonWasMode ) {
            return
        }
        
        // Add mode
        if (currentMode == .adddition) {
            savedNum = savedNum + labelInt
        }
            
        // Substraction
        else if (currentMode == .substraction) {
            savedNum = savedNum - labelInt
        }
            
        // Multiplication
        else if (currentMode == .multiplication) {
            savedNum = savedNum * labelInt
        }
            
        // Division
        else if (currentMode == .division) {
            savedNum = savedNum / labelInt
        }
        
        // Percent
        else if (currentMode == .percent) {
            savedNum = savedNum / 100
            
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    //    CONTROL THE CLEAR BUTTON
    @IBAction func didPressClear(_ sender: AnyObject) {
        
        // Re-intilize the instance variable
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        
        // Set the text label become ZERO
        label.text = "0"
    }
    
    //    CONTROL THE MODE BUTTON
    @IBAction func didPressChangeMode(_ sender: AnyObject) {
    }
    

//    DEFINE FUNCTION UPDATETEXT()
    func updateText() {
        
        // Convert string value to an int
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if (currentMode == .not_set) {
            savedNum = labelInt
        }
        // Add the dot after three decimal
        let formmater:NumberFormatter = NumberFormatter()
        formmater.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        //Update the text
        label.text = formmater.string(from: num)
    }
    
//    let pasteBoard = UIPasteboard.general
    
    // CONTROL GET BUTTON, CLICK TO COPY VALUE
    @IBAction func didPressGet(_ sender: Any) {
        
        // Get the value
        UIPasteboard.general.string = label.text
        
        // Create the alert
        let alert = UIAlertController(title: "Calculator", message: "Value copied", preferredStyle: UIAlertControllerStyle.alert)
        
        // Show the alert
        self.present(alert, animated: true, completion: nil)
        
        // Set the time the alert will auto dismiss
        let when = DispatchTime.now() + 0.5 //0.5 is the time in second it will delay
        
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
        
    }
    
//    DEFINE FUNCTION CHANGEMODE()
    func changeMode(newMode:modes) {
        
        if (savedNum == 0) {
            return
        }
        
        // Change the current mode to any operators click
        currentMode = newMode
        lastButtonWasMode = true
        
    }
}

