Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSKOIFT>; Fri, 15 Nov 2002 03:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKOIEc>; Fri, 15 Nov 2002 03:04:32 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:44929 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265898AbSKOIDY>;
	Fri, 15 Nov 2002 03:03:24 -0500
Date: Fri, 15 Nov 2002 09:10:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Add a wheel to Logitech Wheel Mouse [3/13]
Message-ID: <20021115091011.B16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115090922.A16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:09:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.781.10.5, 2002-10-19 09:49:56+02:00, vojtech@suse.cz
  Add Logitech Wheel Mouse to the list of Logitech mice
  that have a wheel in mousedev.c


 psmouse.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Fri Nov 15 08:31:51 2002
+++ b/drivers/input/mouse/psmouse.c	Fri Nov 15 08:31:51 2002
@@ -348,7 +348,7 @@
 
 		int i;
 		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
-		static int logitech_wheel[] = { 52, 75, 76, 80, 81, 83, 88, -1 };
+		static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81, 83, 88, -1 };
 		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
 							76, 80, 81, 83, 88, 96, 97, -1 };
 		psmouse->vendor = "Logitech";

===================================================================

This BitKeeper patch contains the following changesets:
1.781.10.5
## Wrapped with gzip_uu ##


begin 664 bkpatch16525
M'XL(`.>BU#T``\V446_3,!#'G^-/<=(>UR;G.([=H*"-#0%BB*IHX@$AY#I>
M$Y8T5>*V`L)WQTVK5FJE:B"02&)9=NY\=__[)1=PWYHF\5;U5VMT3B[@==W:
MQ&N7K?'U=[>>U+5;!WE=F6!G%4P?@V*^6%KBWH^5U3FL3-,F'O79?L=^6YC$
MF[Q\=7]W/2$D3>$F5_.9^6`LI"FQ=;-29=9>*9N7]=RWC9JWE;'*UW75[4V[
M$#%T-Z>"(8\[&F,D.DTS2E5$389A)..([!*[VJ5]Y$^11BC"F&)'D0M&;H'Z
M0E*?HL\!PX!B0$>`HR0:)3R^Q#!!A*,SX9+"$,D+^+N9WQ`-UUD&=_6LV(2#
MC[DQ);RK7507"FQNH"Q:"_7#P:8JM'%^-E<6<K4RH&#=NQ5SJ#:>F5GYFKP%
M5ZYD9'R0G@Q_\R($%9+G>S7LNBB+66[]I5YOE,Z:8M/[+0]!'SQ8M/WLZZT&
M`AEE**.P0QECW$W%=,IEQN2#B7AHS+'23SC3=72$(AKQL&/,Z=KS==9MP]P_
MK.&$P*?4@-+UQQW;L5#&HJ>2BA,>PS,\TO^'QU,:?0?@MCOO8=BL^\<!-3[?
MJ#\@])9Q"I2\V4Z>UUIE"^T^!@OE+L4O?4:?/D,*/X"'`^!L`(*[$0]`HAO4
B#;<GY<#)"C^?'?YM.C?ZL5U6J:$B$GR*Y!=FEUWF-@4`````
`
end
