Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSKOIMs>; Fri, 15 Nov 2002 03:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbSKOILy>; Fri, 15 Nov 2002 03:11:54 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:61057 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265982AbSKOIKa>;
	Fri, 15 Nov 2002 03:10:30 -0500
Date: Fri, 15 Nov 2002 09:17:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Add more descriptive comments to input/serio [12/13]
Message-ID: <20021115091716.K16779@ucw.cz>
References: <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz> <20021115091347.F16779@ucw.cz> <20021115091422.G16779@ucw.cz> <20021115091448.H16779@ucw.cz> <20021115091532.I16779@ucw.cz> <20021115091613.J16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091613.J16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:16:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.798.1.5, 2002-11-09 11:45:36+01:00, aebr@win.tue.nl
  Add 'needed for mouse and keyboard' comments to Kconfig to make
  configuration of mouse and keyboard support more obvious.


 Kconfig       |    2 +-
 serio/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/Kconfig b/drivers/input/Kconfig
--- a/drivers/input/Kconfig	Fri Nov 15 08:30:30 2002
+++ b/drivers/input/Kconfig	Fri Nov 15 08:30:30 2002
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate
+	tristate "Input devices (needed for keyboard, mouse, ...)"
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
diff -Nru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	Fri Nov 15 08:30:30 2002
+++ b/drivers/input/serio/Kconfig	Fri Nov 15 08:30:30 2002
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config SERIO
-	tristate "Serial i/o support"
+	tristate "Serial i/o support (needed for keyboard and mouse)"
 	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to

===================================================================

This BitKeeper patch contains the following changesets:
1.798.1.5
## Wrapped with gzip_uu ##


begin 664 bkpatch16263
M'XL(`):BU#T``\V574_;,!2&K^M?<007;((F_DS22)W*V+0A-@V!N)IVX3B&
M9FWBRG'*0/GQ<UKH*"L@T)"61%'\D9/C\SZOLPUGM;9I;VY^.JW&:!L^F]JE
MO;JI=:"N??O$&-\.QZ;4X<VL,)N$135K'/+CQ]*I,<RUK=,>"=BJQUW-=-H[
M^?CI[,O^"4+#(1R,976A3[6#X1`Y8^=RFM<CZ<934P7.RJHNM9.!,F6[FMI2
MC*D_!8D9%E%+(LSC5I&<$,F)SC'E2<313-:3JU&C+GW.]UXF!`\(YA3'+>$T
M3M`'($$\2`(2",`T)"3$`R`DY2)ET2XF*<8@=69'EX5/J]%!-85="GV,WL._
MS?H`*=C/<]BIM,YU#N?&0FE\Y4%6.4ST56:DS7?`QRYUY6K_>3A2ICHO+KK'
M4DZTC[#L:*QTA:G`G&\(`74SFQGK_)#58+)YX:<$Z`@(CP5#QW^D0?UG'@AA
MB=$[N"YF,ST=38NJ^=4OHV02&'OQ_;9>/]K<%ATC2V["FU4L!<(,8\XH35H:
M192W2F81S466<YPH&K/[:CP6:RFV8*05+.;DV8EY,Q3FP?0&$1ZT"2=)Q#)&
MXQA'"M,GTML0\4Z2@B9L88Z-:^J,\HJ%7;?-DU7U1+=\(!A;6(C]91[RD'D(
M],FKF.=KA[.::FE7'NFH7DK_#?KV<G%Y2H\W%_@%N'](@*##[M9SMJB==!JV
M#KN@D.MYH70-;^[X^=:">TM;[D$0!&^W-DB^QLGSA7\!N(_)_R"U'02"LL$2
M`OX?0["PUJ,0K"WR)2B(#@6QCL*I#RJG4(1FM>MNXF&Q/R^0Z&BX_6FJL5:3
3NBF'/!$)$RI'OP%T29M"H0<`````
`
end
