Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbSKQTQr>; Sun, 17 Nov 2002 14:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbSKQTQr>; Sun, 17 Nov 2002 14:16:47 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:32783 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267558AbSKQTQp>; Sun, 17 Nov 2002 14:16:45 -0500
Date: Sun, 17 Nov 2002 17:23:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Kernel Janitors Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] cpqarray/cciss: fixup after header files cleanups: add include <linux/interrupt.h>
Message-ID: <20021117192330.GP28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Janitors Project <kernel-janitor-discuss@lists.sourceforge.net>
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

	Now there are two outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.856, 2002-11-17 17:20:14-02:00, acme@conectiva.com.br
  o cpqarray/cciss: fixup after header files cleanups: add include <linux/interrupt.h>
  
  request_irq/free_irq are now in linux/interrupt.h


 cciss.c    |    1 +
 cpqarray.c |    1 +
 2 files changed, 2 insertions(+)


diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Sun Nov 17 17:21:27 2002
+++ b/drivers/block/cciss.c	Sun Nov 17 17:21:27 2002
@@ -22,6 +22,7 @@
 
 #include <linux/config.h>	/* CONFIG_PROC_FS */
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/version.h>
 #include <linux/types.h>
 #include <linux/pci.h>
diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Sun Nov 17 17:21:27 2002
+++ b/drivers/block/cpqarray.c	Sun Nov 17 17:21:27 2002
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/bio.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/delay.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.856
## Wrapped with gzip_uu ##


begin 664 bkpatch23294
M'XL(`#?LUST``^U6T6Z;,!1]CK_B2GV<`M<&`T%+E;6;MJF35G7JTS1-KG$&
M*L'4-FDC\?%UTC6KVH@NW=XVL`!QKZ^/[SD'<0#G5IE\).1"D0/XH*W+1U(W
M2KIJ*0*I%\&%\8$SK7T@+/5"A4<G8=7(NBN4';.`$Q\^%4Z6L%3&YB,:1-LW
M;M6J?'3V[OWYIS=GA$RG<%R*YH?ZHAQ,I\1ILQ1U86?"E;5N`F=$8Q?*;1;N
MMZD]0V3^Y#2-D"<]33!.>TD+2D5,58$LSI*8K/<P>XS]415*:4HG..%ICUE$
M&7D+-,AX`LA"2D.:`DUSACF-Q\AR1-A9%%XQ&",Y@K^[@6,B08-LKX0Q8A5*
M65F;P[RZZ5H0<Z<,E$H4_C:O:F5!UDHT7>M31%'`3TK@=5TUW8UGR.>;KG5!
M>>C+^F'45:>L^UZ9JW!NE%H_@#`*&GWM9\.3>>0$DIC%Y/07:62\YT$("B2'
MSS2J,-5:.^%%K>5E>-^`0#[H6XP8]RS-,MYG/)N(:#)/"YQ+5;#='`T7O=,!
M0TI[EO`TV1?BFIH=^"CG47_!*5>(D>(RXK%(?@_?@XH/P&&&'MS:.#O3GS?1
M'^`FIK-N-5M?I3;M!K?HOMZO]VUP!\@QBCE+>N11RC<V2_@3E]%AE]%_PV4;
MCC_#V%QOAG?-Z6ZZ7V"_CRP&2@Z&<.]0U]8L>PML3^^2967T;.$K!ZWM`E4,
MZ.N1@Y%-D'&_0L^B[+_$AB5V]Y$;UMBVOR^26?JLS.Y_"F2IY*7M%E,4G$\0
+!;D%)>.YY88(````
`
end
