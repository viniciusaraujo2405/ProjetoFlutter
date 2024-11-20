import 'package:flutter/material.dart';
import 'dart:async'; // Para usar o Timer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto básico de Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 16, 0, 235)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Projeto Básico de Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Contador de cliques
  bool _isPlaying = false; // Indica se o teste está ativo
  int _timeLeft = 10; // Tempo restante em segundos
  String _message = 'Clique para começar!'; // Mensagem para o usuário
  Timer? _timer; // Referência ao Timer
  bool _isButtonDisabled = false; // Controle do estado do botão

  // Função para iniciar o jogo
  void _startGame() {
    setState(() {
      _counter = 0; // Reseta o contador
      _timeLeft = 15; // Define o tempo inicial
      _isPlaying = true; // Inicia o jogo
      _message = 'Tempo restante: $_counter segundos';
      _isButtonDisabled = false; // Habilita o botão para contar os cliques
    });

    // Timer para diminuir o tempo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        
        _message = 'Tempo restante: $_timeLeft segundos';
        
      });

      if (_timeLeft <= 0) {
        _endGame();
      }
    });
  }

  // Função para finalizar o jogo
  void _endGame() {
    setState(() {
      _isPlaying = false; // Finaliza o jogo
      _isButtonDisabled = true;
      if(_counter<50){
        _message = 'Péssimo, você só fez $_counter cliques!';
      }
      if(_counter>=50 && _counter<=100){
        _message = 'Mediano, você fez $_counter cliques!';// Desabilita o botão para impedir novos cliques
    }
      if(_counter>100){
        _message = 'Craque! você fez $_counter cliques!';
      }
      });
    

    _timer?.cancel(); // Para o Timer

    // Após 3 segundos, habilita o botão para iniciar um novo jogo
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isButtonDisabled = false; // Habilita o botão novamente
         // Mensagem para iniciar o jogo
      });
    });
  }

  // Função para incrementar o contador de cliques
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _message,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Cliques: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonDisabled ? null : (_isPlaying ? _incrementCounter : _startGame),
              child: Text(_isPlaying ? 'Clique!' : (_isButtonDisabled ? 'Aguarde...' : 'Iniciar')),
            ),
          ],
        ),
      ),
    );
  }
}
