Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbSKUBBB>; Wed, 20 Nov 2002 20:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266246AbSKUBBB>; Wed, 20 Nov 2002 20:01:01 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:21775 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266243AbSKUBA7>; Wed, 20 Nov 2002 20:00:59 -0500
Date: Wed, 20 Nov 2002 23:07:53 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] input: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021121010753.GD28717@conectiva.com.br>
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

	Now there are two outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.923, 2002-11-20 23:04:41-02:00, wli@holomorphy.com
  input: fix up header cleanups: add <linux/interrupt.h>


 logibm.c   |    7 ++++---
 pc110pad.c |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Wed Nov 20 23:05:04 2002
+++ b/drivers/input/mouse/logibm.c	Wed Nov 20 23:05:04 2002
@@ -35,14 +35,15 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
-#include <asm/io.h>
-#include <asm/irq.h>
-
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Logitech busmouse driver");
diff -Nru a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
--- a/drivers/input/mouse/pc110pad.c	Wed Nov 20 23:05:04 2002
+++ b/drivers/input/mouse/pc110pad.c	Wed Nov 20 23:05:04 2002
@@ -37,6 +37,7 @@
 #include <linux/ioport.h>
 #include <linux/input.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.923
## Wrapped with gzip_uu ##


begin 664 bkpatch3903
M'XL(`$`QW#T``\V536^;0!"&S]Y?L5*.E6%F/P"C.G*35&V42K52Y=;+9MD$
M6F`I+'92\>,+-'(BIW7CM)4"7)B!EW=GGED.Z$5CZGBB=&'(`7UO&Q=/M"V-
M=ME*>=H6WF7=)\ZM[1-^:@OC'YWY6:GS-C'-E'F2].FE<CJE*U,W\00]OHFX
MV\K$D_.W[RX^O#DG9#ZGQZDJK\TGX^A\3IRM5RI/FH5R:6Y+S]6J;`KCQ@]W
MFT<[!L#Z4V+(008=!B#"3F."J`2:!)B(`D&&-2RVO6^I(#*$_D3>,<&D)"<4
MO1GC%)B/Z#.@C,<@8H%38#$`7>?9(K6Y+6Q=I;>#*'W%Z!3($?VW[H^)IEE9
MM2ZF5]D-;2N:&I68FNK<J+*MFIBJ)*&O\ZQL;_H&.%/7;>6\])"<429@QLGR
MOKIDNN=!""@@AW1EOSBCTX5;9WEVG3JOU6M/?^^2.AO:ZX\6_<*VC?%S>YU=
M%I[^N<(0.'*(!'8H)!/=U4R&.H+H*M!!,I3X<2G_K'K7+\&C_E;*<$^'E4:$
M2B6//7+.(^C"(%`\27IYI3BRX*D>MW0?N(291#F2OFMM`_S_K](;Z:9_]TF2
M"!!A3RB'#L-(!N-8A-M#P:,=0R'HE+^PH1B!^4BG]7J\>LB7.[ORC*$YX1'E
MY%1(*LC!W:[X2SN?'Z154_B9':);L?K;$/P=//?0[8O/OF/P=^),(LJ@YQ*"
M",6(DMP+)7QQ^^LXU$\@Z;X6SV#IE,\H[J9H\V/5J=%?F[:8@U`S(94F/P#[
'J_C&R@<`````
`
end
