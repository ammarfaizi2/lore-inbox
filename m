Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbSKOIOK>; Fri, 15 Nov 2002 03:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKOIM7>; Fri, 15 Nov 2002 03:12:59 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:63105 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266041AbSKOILn>;
	Fri, 15 Nov 2002 03:11:43 -0500
Date: Fri, 15 Nov 2002 09:18:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Add "PS/2 keyboard" to ATKBD help [13/13]
Message-ID: <20021115091814.L16779@ucw.cz>
References: <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz> <20021115091347.F16779@ucw.cz> <20021115091422.G16779@ucw.cz> <20021115091448.H16779@ucw.cz> <20021115091532.I16779@ucw.cz> <20021115091613.J16779@ucw.cz> <20021115091716.K16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091716.K16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:17:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.798.1.6, 2002-11-09 12:08:32+01:00, macro@ds2.pg.gda.pl
  Make it clearer that the atkbd.c driver is for PS/2 keyboards as well in the
  Kconfig help text.


 Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	Fri Nov 15 08:30:21 2002
+++ b/drivers/input/keyboard/Kconfig	Fri Nov 15 08:30:21 2002
@@ -15,11 +15,11 @@
 	tristate "AT keyboard support"
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
-	---help---
-	  Say Y here if you want to use the standard AT keyboard. Usually
-	  you'll need this, unless you have a different type keyboard (USB,
-	  ADB or other). This also works for AT keyboards connected over
-	  a PS/2 to serial converter.
+	help
+	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
+	  you'll need this, unless you have a different type keyboard (USB, ADB
+	  or other). This also works for AT and PS/2 keyboards connected over a
+	  PS/2 to serial converter.
 
 	  If unsure, say Y.
 

===================================================================

This BitKeeper patch contains the following changesets:
1.798.1.6
## Wrapped with gzip_uu ##


begin 664 bkpatch16234
M'XL(`(VBU#T``[U46V_3,!1^KG_%D?8`:*MC.TF35BKJ+@C00%2[/"#$@^NX
M34@:1['3KE-^/"?M5J0*C8&`)++D^)S/Y_)]YPANK:Y'O97YYK1*R1&\,]:-
M>K:QFJI[W%\9@WLO-4OM/5AYL]S+RJIQ!,^GTJD45KJVHQZG_OZ/VU1ZU+MZ
M\_;VP^D5(>,QG*>R7.AK[6`\)L[4*UDD=B)=6IB2NEJ6=JF=I,HLV[UI*Q@3
M^(8\\EDX:/F`!5&K>,*Y#+A.F`CB04"DGM63=88PC:9E<>#/.1MR%H0^^@=1
MZ),+X#0:QI33`3#A<>ZQ(7`Q8O'(%\>,CQB#I52UF216T&I!%XFD50'''/J,
MG,'?#?Z<*/@H<PV9`U5H6>L:7"H=+AJDRV<)59#4&=88,@MS4\/TVA.0Z\W,
MR#JQ("VL=5%`5G8^"'>I3#G/%I#JH@*G[QPEE\!#$0W)]$<?2/\W'T*89.0U
MW&=5I8M)D97-77\YB'-JZL67QZI\;7?!VAU)O,<XO8>H=CUA/F.!+T3<BM@/
M1#L<ZD`+)<-D$,F!X#]KP+.`NV9S%HNH]444LBWUGO;K^/@_4B*5M/EFTJ@U
M2NO9N;``.82Y,*1*1US_D+(B>HJR(?3#?T?9CJ)[DCVRMR/;KO:?H%^OMQ^2
M9_J+-OP!'2]X#"%Y+P2NO2X.T@.XEAOXC%'5J*@Y;$P#:UFBF@S@4`,)ULDR
MP7OA]`8.M41Q'C:R*#8=$+J^0%656B>8:&9/H"D+;>T6,Y6K#BS)YG.\J</'
M@;?'@9>WUV<G<'IQU@'A+08K5;^B<(,X(`MK8&WJ?*=FC`,C.A0U%J74RN'=
LIE.^[("V)I@(SNQ,%IT)'KFNXONYJU*M<MLLQW(^&\Z8FI'O0_50E^0%````
`
end
