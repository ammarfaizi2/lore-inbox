Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSL1Vvz>; Sat, 28 Dec 2002 16:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSL1Vvz>; Sat, 28 Dec 2002 16:51:55 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:11750 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265689AbSL1Vvw>; Sat, 28 Dec 2002 16:51:52 -0500
Date: Sat, 28 Dec 2002 14:52:40 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK input PATCHES]
Message-ID: <Pine.LNX.4.33.0212281451510.1725-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We don't need the following anymore in misc.c

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.867, 2002-12-10 11:44:59-08:00, jsimmons@kozmo.(none)
  Old PS/2 code removal.


 misc.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Tue Dec 10 11:57:03 2002
+++ b/drivers/char/misc.c	Tue Dec 10 11:57:03 2002
@@ -50,8 +50,6 @@
 #include <linux/tty.h>
 #include <linux/kmod.h>

-#include "busmouse.h"
-
 /*
  * Head entry for the doubly linked miscdevice list
  */
@@ -64,7 +62,6 @@
 #define DYNAMIC_MINORS 64 /* like dynamic majors */
 static unsigned char misc_minors[DYNAMIC_MINORS / 8];

-extern int psaux_init(void);
 #ifdef CONFIG_SGI_NEWPORT_GFX
 extern void gfx_register(void);
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch5229
M'XL(``]']CT``[V436L;,1"&S]:O&,BEI>SNC*3]!!>W<6FAA1B'G$H/BE;N
M;N)=!4EVF[`_ONN4?.(T-)1*<QJ-I)=W'ND`3KQQU>3,MUUG>\\.X)/UH9J<
MVZO.QJ]ZVYO78W)I[9A,-MXEWNEDW?:;GU';7VP"&U<7*N@&ML;Y:D*QN,V$
MRPM3398?/IY\>;=D;#J%PT;UW\VQ"3"=LF#=5JUK/U.A6=L^#D[UOC-!Q=IV
MPVWIP!'Y.%/*!:;90!G*?-!4$RE)ID8NBTRRK3T+1C<SO_$FUE>/]A,GQ%(@
MXB"RK"S9'"@NLAR0)S0&`E$E9966$185(MPX,KOO!+PAB)"]AW\K_9!I.%K7
ML#A..&A;&W"FL^,%,;#/(#(DP19WWK'H+P=CJ)"]?49U[=I="Q/=*)=TK=>Q
MOJ=?(LHA0Y&E0RY/\Y7B8E44I%>KT_U>/7G>KA54BI(78RN(BFLP]A0_C\B+
M%3/5*#4>VKI.M>NX-^'KS4W?GM9-6%#)*96#Q#S_C1#)!P2)LN+%GPE"B,1_
M)VAG\Q%$[L=UC$0L]CG^`K#FJ0#.YN-#HKN?0#=&G_M--TUWAAE5L%_#=QY*
$:`0`````
`
end

