Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRGTO3g>; Fri, 20 Jul 2001 10:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbRGTO3R>; Fri, 20 Jul 2001 10:29:17 -0400
Received: from wiproecmx1.wipro.com ([164.164.31.5]:15354 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S266970AbRGTO3H>; Fri, 20 Jul 2001 10:29:07 -0400
From: "Manoj Sharma" <manoj.sharma@wipro.com>
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.4.3
X-Mailer: Netscape Messenger Express 3.5.2 [Mozilla/4.0 (compatible; MSIE 5.01; Windows NT; Aim Package version 1.07.8)]
Date: Fri, 20 Jul 2001 07:35:07 -0700
Message-ID: <GGS0IJ00.NFH@santa.mail.wipro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I am using 2.4.3 kernel and I am getting kernel panic.
It doesn't happen very regularly so may be difficult to simulate.
I connected my system to serial port and captured the log.
Please suggest a way so that I can track down the problem.
Will KGDB be of any help ?  
Please reply to me directly as I am not on the linux-kernel mailing
list.

Thanks,
Manoj

(manoj.sharma@wipro.com)

--------------------------------------------------------------------

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:	0
EIP:	0010:[<c0217900>]
EFLAGS: 00000086
eax: 00000000	ebx: cdfe4000	ecx: cdfe8db8	edx: c0101db8
esi: cdfe4000	edi: c0111654	ebp: cdfe5ba0	esp: cdfe5b90
ds: 0018   es: 0018   ss: 0018
Process test_hal (pid: 217, stackpage=cdfe5000)
Stack: cdfe4000 cdfe4000 c0111654 00000046 cdfe5c58 c011192c c0111e54
cdfe4000
       00000000 c0111654 c01072a4 cdfe5bc4 00000002 00000a78 cdfe4000
0000029e
       db937034 40014588 cdfe5c08 00000000 ce280018 00000018 ffffffff
c0214c0f
Call Trace: [<c0111654>] [<c011192c>] [<c0111e54>] [<c0111654>]
[<c01072a4>] [<db937034>] [<c0214c0f>]
       [<c01072a4>] [<c0214c0f>] [<c01072a4>] [<c0101db8>] [<db937000>]
[<c0111654>] [<c0111e54>] [<c0111654>]
       [<c011192c>] [<db9165b4>] [<c0111654>] [<db9165b4>] [<c01daf08>]
[<c01072a4>] [<db9165b4>] [<db9165b4>]
       [<c0108bb3>] [<db917408>] [<c0108db2>] [<c0107230>] [<c0112628>]
[<c01121f0>] [<db91a5a4>] [<c011211c>]
       [<c0112b76>] [<d0905400>] [<db91a580>] [<db91a5a8>] [<db91a5a8>]
[<db91a1a0>] [<d0905400>] [<db91a4b7>]
       [<db91a590>] [<db91a24b>] [<db91a580>] [<db937c0b>] [<c01310fa>]
[<c013102b>] [<c0140eec>] [<c014481e>]
       [<db937088>] [<c010716f>] [<c014481e>]

Code: 80 3d b0 56 27 c0 00 f3 90 7e f5 e9 2c a5 ef ff 80 3d 00 24
console shuts up ...

Program received signal SIGSEGV, Segmentation fault.
0xc0217900 in stext_lock () at af_packet.c:1864
1864 af_packet.c: No such file or directory.





begin 666 Wipro_Disclaimer.txt
M5&AE($EN9F]R;6%T:6]N(&-O;G1A:6YE9"!A;F0@=')A;G-M:71T960@8GD@
M=&AI<R!%+4U!24P@:7,@<')O<')I971A<GD@=&\@"E=I<')O($QI;6ET960@
M86YD(&ES(&EN=&5N9&5D(&9O<B @=7-E(&]N;'D@8GD@=&AE(&EN9&EV:61U
M86P@;W(@96YT:71Y('1O('=H:6-H( II="!I<R!A9&1R97-S960L(&%N9"!M
M87D@8V]N=&%I;B!I;F9O<FUA=&EO;B!T:&%T(&ES('!R:79I;&5G960L(&-O
M;F9I9&5N=&EA;"!O<B *97AE;7!T(&9R;VT@9&ES8VQO<W5R92!U;F1E<B!A
M<'!L:6-A8FQE(&QA=RX@268@=&AI<R!I<R!A(&9O<G=A<F1E9"!M97-S86=E
M+" *=&AE(&-O;G1E;G0@;V8@=&AI<R!%+4U!24P@;6%Y(&YO="!H879E(&)E
M96X@<V5N="!W:71H('1H92!A=71H;W)I='D@;V8@=&AE( I#;VUP86YY+B!)
M9B!Y;W4@87)E(&YO="!T:&4@:6YT96YD960@<F5C:7!I96YT+"!A;B!A9V5N
M="!O9B!T:&4@:6YT96YD960@"G)E8VEP:65N="!O<B!A("!P97)S;VX@<F5S
M<&]N<VEB;&4@9F]R(&1E;&EV97)I;F<@=&AE(&EN9F]R;6%T:6]N('1O('1H
M92!N86UE9" *<F5C:7!I96YT+" @>6]U(&%R92!N;W1I9FEE9"!T:&%T(&%N
M>2!U<V4L(&1I<W1R:6)U=&EO;BP@=')A;G-M:7-S:6]N+"!P<FEN=&EN9RP@
M"F-O<'EI;F<@;W(@9&ES<V5M:6YA=&EO;B!O9B!T:&ES(&EN9F]R;6%T:6]N
M(&EN(&%N>2!W87D@;W(@:6X@86YY(&UA;FYE<B!I<R *<W1R:6-T;'D@<')O
M:&EB:71E9"X@268@>6]U(&AA=F4@<F5C96EV960@=&AI<R!C;VUM=6YI8V%T
M:6]N(&EN(&5R<F]R+"!P;&5A<V4@"F1E;&5T92!T:&ES(&UA:6P@)B!N;W1I
L9GD@=7,@:6UM961I871E;'D@870@;6%I;&%D;6EN0'=I<')O+F-O;2 *#0H 
end

