Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSKRCLU>; Sun, 17 Nov 2002 21:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSKRCLU>; Sun, 17 Nov 2002 21:11:20 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:40977 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261286AbSKRCLT>; Sun, 17 Nov 2002 21:11:19 -0500
Date: Mon, 18 Nov 2002 00:18:11 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtpav: fixup after header files cleanups: add include <linux/interrupt.h>
Message-ID: <20021118021811.GC32457@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there are just this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.886, 2002-11-17 23:48:17-02:00, acme@conectiva.com.br
  o mtpav: fix up header file cleanup: add include <linux/interrupt.h>


 mtpav.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
--- a/sound/drivers/mtpav.c	Mon Nov 18 00:16:12 2002
+++ b/sound/drivers/mtpav.c	Mon Nov 18 00:16:12 2002
@@ -51,8 +51,8 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
@@ -60,6 +60,8 @@
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
 #include <linux/delay.h>
+
+#include <asm/io.h>
 
 /*
  *      globals

===================================================================


This BitKeeper patch contains the following changesets:
1.886
## Wrapped with gzip_uu ##


begin 664 bkpatch29183
M'XL(`&Q-V#T``\V438_3,!"&S_6O&*E'E,3CV$D:T579702K1:(JVA-P<)WI
M)MI\*1^EH/QXG+!T`5650'O`L1PE,QJ_GO>1YW#74A//M"F(S>%MU7;QS%0E
MF2[;:]=4A;MM;&!353;@I55!WN6MEY4F[Q-J'>$J9L-KW9D4]M2T\0Q=__BG
M^UI3/-N\?G/W[M6&L>42KE)=WM,'ZF"Y9%W5['6>M"O=I7E5NEVCR[:@;MIX
M.*8.@G-A'X6ASU4P8,!E.!A,$+5$2KB042"?JHTJS]9"Q%`(H10.7$3A@ET#
MNE$4`!<>HH<A"#^648RAPT7,.8SM6?W9%GB!X'!V"<][C"MFH(*BJ_4^AEUV
M@+Z&E'1"C?W*"4Q.NNSK&'22P*,1\#+/ROY@?>FH:?JZ<],+=@M"+@1;/_6<
M.7\Y&..:LPNHJ:'#:EI=\VUHJ[Y,O*3)1L>]2:IK'H^'/BY\^QY$&(9J6&PC
M19$O:2=VBO!T)\\4M%9%'*7B?$`92#5!=#)]!.K9=#+]4!>K)+NG:M3X\:?%
MG\]+];GO*Y0#VMIRH@KQ=ZB4Q>D\5#XX^#]#]<.&]^`T7Z9I*5F?=N0?<+M6
M$I#=*&77^3D=-X$`P3[]DJ3;PLNJ,7:\?DQ*YJ'MBR62K]6.MNP[?TILP?`$
"````
`
end
