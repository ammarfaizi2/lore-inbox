Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263023AbSJHNhN>; Tue, 8 Oct 2002 09:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263043AbSJHNhN>; Tue, 8 Oct 2002 09:37:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37780 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263023AbSJHNhK>;
	Tue, 8 Oct 2002 09:37:10 -0400
Date: Tue, 8 Oct 2002 15:42:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fix Logitech Desktop Pro wheel [5/23]
Message-ID: <20021008154246.D18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154132.C18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:41:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.34, 2002-09-24 19:33:58+02:00, khaho@koti.soon.fi
  Make Logitech Desktop Pro (wireless keyboard & mouse) work with all buttons and wheel.


 psmouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Tue Oct  8 15:27:11 2002
+++ b/drivers/input/mouse/psmouse.c	Tue Oct  8 15:27:11 2002
@@ -349,8 +349,8 @@
 	if (param[1]) {
 
 		int i;
-		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 73, 80, -1 };
-		static int logitech_wheel[] = { 75, 76, 80, 81, 83, 88, -1 };
+		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
+		static int logitech_wheel[] = { 52, 75, 76, 80, 81, 83, 88, -1 };
 		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
 							76, 80, 81, 83, 88, 96, 97, -1 };
 		psmouse->vendor = "Logitech";

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.34
## Wrapped with gzip_uu ##


begin 664 bkpatch18357
M'XL(`"_=HCT``\U4[VO40!#]?/M7#!1$:2_9G\E>Y*3:%A4K'I5^$I%-LFUB
M<MDCNW>A&O]W-[EK!6M+%063#)/=[#S>FWED#\ZM;I/)QGQV.BO0'KPRUB43
MN[8ZR+[X]9DQ?AT69JG#W:DPK<*R6:T=\M\7RF4%;'1KDPD)V,V.NUKI9')V
M\O+\]/D90O,Y'!6JN=3OM8/Y'#G3;E2=VT/EBMHT@6M58Y?:J2`SR_[F:$\Q
MIOX6)&981#V),(_[C.2$*$YTCBF7$4<[8H<[VC_7SR@G$9<"]QC'F*)C((&(
M6>#Y<L`TQ+.0<B"SA+%$R'U,$XRA*E1A#BOCRL`:S_"BA'T"4XQ>P-\E?X0R
M>*LJ#:?FLAQDP+&VE3,K6+0&'G=EJVMM+53Z*C6JS>$1+(T7^@0ZTU;0E:X`
M5=>0KITSC075Y-`56M<!>@,S3M#B1^O1]#<OA+#"Z!E<=]AU95U>%BY89]W0
MZ;PMA]EO_1".O,*5'7.0;1L08T88EISV6$8XZM,X387,F;S07%"M?]'IA\`.
M0XT9$[QG,9-BM-B]98/M_J&,6R9\H`9O3!YY#9C&HS$)NV5)?H\E*4SI_VA)
MCW"G*;<#>P?3MAL?;[/%_;/[`]\>,T&!HM=,,)\F$^N4*S,H&P?U3M4GGKKF
MPT>8PU<@]``X]D%\#._L`(3/L<_2[T\)?'MZ!\PH;(<SU@@?T;9.>CPY8,AK
:C)M?9%;HK++KY9Q?<.EM%*'OA^YG:H\%````
`
end
