Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSGDIOM>; Thu, 4 Jul 2002 04:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSGDIOL>; Thu, 4 Jul 2002 04:14:11 -0400
Received: from mail4.messagelabs.com ([212.125.75.12]:34834 "HELO
	mail4.messagelabs.com") by vger.kernel.org with SMTP
	id <S317365AbSGDIOK>; Thu, 4 Jul 2002 04:14:10 -0400
X-VirusChecked: Checked
Message-ID: <ABDA876D71F9D211B39D0090274EA8E20BC913EB@Floyd.logica.co.uk>
From: "Taylor, Neville" <TaylorNE@logica.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: /proc/pci
Date: Thu, 4 Jul 2002 09:16:36 +0100 
X-MS-TNEF-Correlator: <ABDA876D71F9D211B39D0090274EA8E20BC913EB@Floyd.logica.co.uk>
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Anyone got any ideas why all the devices in my /proc/pci file show the rev,
Latency, Min Gnt and Max Lat as 255.

eg.

> Bus 0, device 8, function 0:
> Class ffff: Adaptec AHA-294x / AIC- 7871 ( rev 255)
>     IRQ 11
>     Master Capable. Latency=255. Min Gnt=255.Max Lat=255
>     I/O at 0xfc00 [0xfcff]
>     Non-prefetchable 32 bit memory at 0x3efff000 [0x3effffff]


Is this usual? It's just because when I try and load the aoc7xxx module for
this card I get

/lib/modules/2.4.18-3/kernel/drivers/scsi/aic7xxx/aic7xxx.o: init_module: No
such device

/lib/modules/2.4.18-3/kernel/drivers/scsi/aic7xxx/aic7xxx.o: insmod
/lib/modules/2.4.18-3/kernel/drivers/scsi/aic7xxx/aic7xxx.o failed

/lib/modules/2.4.18-3/kernel/drivers/scsi/aic7xxx/aic7xxx.o: insmod aic7xxx
failed


begin 600 winmail.dat
M>)\^(B<(`0:0"``$```````!``$``0>0!@`(````Y`0```````#H``$(@`<`
M&````$E032Y-:6-R;W-O9G0@36%I;"Y.;W1E`#$(`0D`!``"``````````$(
M``4`!`````````````$%@`,`#@```-('!P`$``D`$``D``0`)0$!((`#``X`
M``#2!P<`!``)`!``)``$`"4!`0F``0`A````,$9!-S`W,S$S-$$W-C<T.3DX
M.4(U13(Q-$9".4$Q,#(`!`<!!(`!``P````@("]P<F]C+W!C:0".`P$-@`0`
M`@````(``@`!`Y`&`)P'```P`````P`!@`@@!@``````P````````$8`````
M4H4``#]Q`0`>``*`""`&``````#`````````1@````!4A0```0````0````Y
M+C``"P`#@`@@!@``````P````````$8`````!H4````````#``2`""`&````
M``#`````````1@`````!A0````````L`!8`((`8``````,````````!&````
M``.%````````"P`&@`@@!@``````P````````$8`````#H4````````#``>`
M""`&``````#`````````1@`````0A0````````,`"(`((`8``````,``````
M``!&`````!&%`````````P`)@`@@!@``````P````````$8`````&(4`````
M```"`0D0`0```)H"``"6`@``B00``$Q:1G7!/3^J`P`*`')C<&<Q,C7B,@-#
M=&5X!4$!`P'W_PJ``J0#Y`<3`H`/\P!0!%8_"%4'LA$E#E$#`0(`8VCA"L!S
M970R!@`&PQ$E]C,$1A.W,!(L$3,([PGWMCL8'PXP-1$B#&!C`%#S"PD!9#,V
M%E`+I@KC"H0C'3\=@4%N>0(@92",9V\%0`!P>2!I`0!R800@=V@?H`=``R!T
M=F@?(`$`=@W@!Y$+@"!2;1^@+W`#8&,AP&,8:2!F`Q`?('-H;P<'X""B&"!V
M+"!,85$.L&YC>2-P32%A1\L",!]Q9`7087@C@A]P2P0@&E$N';IE9R7+/F@@
M0G4$(#`C<"#D()(X(W!F=2/0=&D"(/4GT#HG)D,+8`01`2`!('(Z$,!D804P
M!9`0P$B@02TR.30E`"\0P`!)0RT@-S@W,6P@*",R)8(I)R8M@DEP4E$@,1KS
M+58DX'.[#K`%P$,JP`&@(H`N(X9^/262)!8P8R3E,&(M&R^F3Q]P!4`P>!/`
M,!905ELS8@$@72T:3@(@+9\AT`$0%"`3T2^A(#,40-QB:05`!X`$8'(@03-"
M_C,!$0$P,Z0W4RI!-$4XJJY)!"`@H`0`(">P=0=`TC\MP'0G!"!J)[`%0/IB
M!9!A)[`?("`@"?`MP&\@D#;2)+$7L&$DP""B8;DA\#=X/9`A@`1P=2*!OP(0
M!<`Y\SMP"R`\$6<4($$XJB]L:6(O/=1S`"\R+C0N,3@M"#,O:P2196PO9+T%
M$'8$D$#@!/``D"\+<',]<T+&+F\J@`N`-F!?WSW4*H`U$"*@&M!H(-4_?^]`
MCT&?0J]#M7,$82&P1H__1Y](KT-U(E`+<"*`"S%%WW]++TP_34]*&%(U3F\*
M@'T!58```!X`<``!````"@```"]P<F]C+W!C:0````(!<0`!````)0````'"
M(J94B7!L_`SQP$^6MAB])@G21S8```I+(```&*)@`"+\[T`````#`"X`````
M``L``@`!````"P`7#``````#`%U```````,`"5D!`````P#>/Z]O``!``#D`
MT%Q&'3,CP@$#`/$_"00``!X`,4`!````"0```%1!64Q/4DY%``````,`&D``
M````'@`P0`$````)````5$%93$]23D4``````P`90``````#`/T_Y`0```,`
M)@```````P`V```````#`(`0_____P(!1P`!````-0```&,]1T([83U!5%1-
M86EL.W`]3&]G:6-A.VP]1DQ/640M,#(P-S`T,#@Q-C,V6BTV,#4V.3$`````
M`@'Y/P$```!*`````````-RG0,C`0A`:M+D(`"LOX8(!`````````"]//4Q/
M1TE#02]/53U52R]#3CU%6$-(04Y'12!54T524R]#3CU405E,3U).10```!X`
M^#\!````$````%1A>6QO<BP@3F5V:6QL90`>`#A``0````D```!405E,3U).
M10`````"`?L_`0```$H`````````W*=`R,!"$!JTN0@`*R_A@@$`````````
M+T\]3$]'24-!+T]5/55++T-./4580TA!3D=%(%5315)3+T-./51!64Q/4DY%
M````'@#Z/P$````0````5&%Y;&]R+"!.979I;&QE`!X`.4`!````"0```%1!
M64Q/4DY%`````$``!S``9$K3,B/"`4``"#"V19`=,R/"`1X`/0`!`````0``
M```````>`!T.`0````P````@("]P<F]C+W!C:0`>`#40`0```#X````\04)$
M03@W-D0W,48Y1#(Q,4(S.40P,#DP,C<T14$X13(P0D,Y,3-%0D!&;&]Y9"YL
M;V=I8V$N8V\N=6L^````"P`I```````+`",```````,`!A#SC5/9`P`'$'`"
M```#`!`0``````,`$1``````'@`($`$```!E````04Y93TY%1T]404Y9241%
M05-72%E!3$Q42$5$159)0T5324Y-62]04D]#+U!#249)3$532$]75$A%4D56
M+$Q!5$5.0UDL34E.1TY404Y$34%83$%405,R-35%1T)54S`L1$5620`````"
M`7\``0```#X````\04)$03@W-D0W,48Y1#(Q,4(S.40P,#DP,C<T14$X13(P
@0D,Y,3-%0D!&;&]Y9"YL;V=I8V$N8V\N=6L^````-*0=
`
end

This e-mail and any attachment is for authorised use by the intended recipient(s) only.  It may contain proprietary material, confidential information and/or be subject to legal privilege.  It should not be copied, disclosed to, retained or used by, any other party.  If you are not an intended recipient then please promptly delete this e-mail and any attachment and all copies and inform the sender.  Thank you.
