Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSGOCqZ>; Sun, 14 Jul 2002 22:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317280AbSGOCqY>; Sun, 14 Jul 2002 22:46:24 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:48350 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316571AbSGOCqW>; Sun, 14 Jul 2002 22:46:22 -0400
Subject: [BK-PATCH-2.5] Compile fix for current Linus bk tree
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 15 Jul 2002 03:49:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17TvvI-0001Ta-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This one liner is required to make your current repository on bkbits
compile for me.

Please apply. (Note, patch is both compile and boot tested.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 drivers/char/serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/15 1.632)
   drivers/char/serial.c compile fix


diff -Nru a/drivers/char/serial.c b/drivers/char/serial.c
--- a/drivers/char/serial.c	Mon Jul 15 03:46:39 2002
+++ b/drivers/char/serial.c	Mon Jul 15 03:46:39 2002
@@ -645,7 +645,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020715024538|03883
## Wrapped with gzip_uu ##


begin 664 bkpatch2179
M'XL(`)`W,CT``\64;XL3,1#&7V\^1>#>*'?=G4FR?V6E>A4]+%HJ?2UI-G>[
MN-VM27I:V`]OVH-6M/10#TS"ALPR#S._/.2"WDR*P/7F7K:5'4M7MWT7.B,[
MN]).AJI?#=>U[.[T)^T&!L#\C#'E$"<#)B#206&%*`7J"IC($D$NZ,)J4P2R
MD0S]Z5UO71$HV3FY##OM?&C>]SX4;:R)K%%1R^*13R'^STPZ5=-[;6P18,@/
M$;==ZR*8OWF[F+Z:$U*6]%`6+4ORM!T<U.I^I<]KI1@#HF#)`"+.<S*A&":<
M46`1I!'&%'@AXH)GEX`%`-U#&1]AT$ND(R"OZ=-V<$T4K4RSXQBI6GK,VC2R
M#17U:NNFU?2V^4[>4YYEG,R.+,GH#P<A((&\?*3\DZ7\U(H`$`-`G/(A99AK
MGMYBBM(C9;\1.R>VNPWFD_)!L`SXWB>G,3SJF7\HF9B-==OQ[JMZL][)A7)S
M3C%F7H)QS@;!,1=[%['T5Q.Q_)R)\+^9Z('U1SHRW_;+NV)V.O$O[#5)1$:1
MW#QL@1^^BZK5G^W6FJ_/5'U%C;ZS5_3#8CI]_N+XAJA:JR]VLRJ72QX+S(#\
)`/-U!;+M!```
`
end
