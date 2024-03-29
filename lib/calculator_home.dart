import 'package:flutter/material.dart';

dynamic text = 0;

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Calculator',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        text.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnCalc('AC', Colors.grey, Colors.black),
                    btnCalc('+/-', Colors.grey, Colors.black),
                    btnCalc('%', Colors.grey, Colors.black),
                    btnCalc('/', Colors.amber.shade700, Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnCalc('7', Colors.grey, Colors.black),
                    btnCalc('8', Colors.grey, Colors.black),
                    btnCalc('9', Colors.grey, Colors.black),
                    btnCalc('x', Colors.amber.shade700, Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnCalc('4', Colors.grey, Colors.black),
                    btnCalc('5', Colors.grey, Colors.black),
                    btnCalc('6', Colors.grey, Colors.black),
                    btnCalc('-', Colors.amber.shade700, Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnCalc('3', Colors.grey, Colors.black),
                    btnCalc('2', Colors.grey, Colors.black),
                    btnCalc('1', Colors.grey, Colors.black),
                    btnCalc('+', Colors.amber.shade700, Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        calculation('0');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 100),
                        padding: const EdgeInsets.fromLTRB(34, 20, 150, 20),
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        '0',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    btnCalc('.', Colors.grey, Colors.white),
                    btnCalc('=', Colors.amber.shade700, Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  Widget btnCalc(String btntext, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntext);
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 100),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: btncolor),
      child: Text(
        btntext,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      if (numOne == 0) {
        numOne = btnText;
      }
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
