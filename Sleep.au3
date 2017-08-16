#Region AutoIt3Wrapper directives section
#AutoIt3Wrapper_Icon=juno_okyo.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=Y
#AutoIt3Wrapper_Res_Comment=Developed by Juno_okyo
#AutoIt3Wrapper_Res_Description=Developed by Juno_okyo
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=Y
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=(C) 2017 Juno_okyo. All rights reserved.
#AutoIt3Wrapper_Res_Field=CompanyName|J2TeaM
#AutoIt3Wrapper_Res_Field=Website|https://junookyo.blogspot.com/
#EndRegion AutoIt3Wrapper directives section

#NoTrayIcon
#include <Misc.au3>
#include '_Startup.au3'

Opt('MustDeclareVars', 1)
Opt('WinTitleMatchMode', 2)

_Singleton(@ScriptName)
_StartupRegistry_Install()

Global $apps = ['Google Chrome', 'Sublime Text']
Global $processes = ['chrome.exe', 'sublime_text.exe']

While 1
	Sleep(60000)
	main()
WEnd

Func main()
	If checkTime() Then
		closeApps()
		Sleep(10000)
		closeProcesses()
		Sleep(5000)
		Shutdown(5) ; Shudown + Force
	EndIf
EndFunc   ;==>main

Func checkTime()
	Local $h = @HOUR
	Return $h > 0 And $h < 7
EndFunc   ;==>checkTime

Func _ProcessCloseEx($sPID) ; Author: rasim
	If IsString($sPID) Then $sPID = ProcessExists($sPID)
	If Not $sPID Then Return SetError(1, 0, 0)

	Return RunWait(@ComSpec & ' /c taskkill /F /PID ' & $sPID & ' /T', @SystemDir, @SW_HIDE)
EndFunc   ;==>_ProcessCloseEx

Func closeApps()
	For $app In $apps
		If WinExists($app) Then WinClose($app)
	Next
EndFunc   ;==>closeApps

Func closeProcesses()
	For $process In $processes
		_ProcessCloseEx($process)
	Next
EndFunc   ;==>closeProcesses
