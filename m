Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSKRMwi>; Mon, 18 Nov 2002 07:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSKRMwh>; Mon, 18 Nov 2002 07:52:37 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:37380 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262446AbSKRMwe>; Mon, 18 Nov 2002 07:52:34 -0500
Date: Mon, 18 Nov 2002 10:59:32 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hotplug: fix up header cleanups: add include linux/interrupts.h
Message-ID: <20021118125931.GD2093@conectiva.com.br>
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

	Now there is only this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.891, 2002-11-18 10:39:14-02:00, acme@conectiva.com.br
  o hotplug: fix up header cleanups: add include linux/interrupts.h


 cpqphp_core.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Mon Nov 18 10:56:05 2002
+++ b/drivers/hotplug/cpqphp_core.c	Mon Nov 18 10:56:05 2002
@@ -36,7 +36,10 @@
 #include <linux/workqueue.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+
 #include <asm/uaccess.h>
+
 #include "cpqphp.h"
 #include "cpqphp_nvram.h"
 #include "../../arch/i386/pci/pci.h"	/* horrible hack showing how processor dependant we are... */

===================================================================


This BitKeeper patch contains the following changesets:
1.891
## Wrapped with gzip_uu ##


begin 664 bkpatch15229
M'XL(`&7CV#T``\U478L3,11];G[%A3Y*9W(S7YG!+G5W164%2V5?_$!B)FV&
MG4[&3*:[POQXTUHKU%)643`)!')O3NZYYY`QW';*%B,AUXJ,X:7I7#&2IE'2
M51L12+,./EL?6!CC`Z$V:Q5>WH15(^N^5-V$!0GQX;EP4L-&V:X881`=3MS7
M5A6CQ?,7MZ^?+0B93N%*BV:EWBH'TREQQFY$778SX71MFL!9T71KY78/#X?4
M@5'*_$PPBVB2#IC2.!LDEH@B1E52%O,T)EL.L^/:CU`0D2.+.,L&&D=Q3JX!
M`YXC4!8BAL@!:1'E!<83R@I*X20H/$&84'()?Y?`%9%@0!O7UOVJ@&7U`'T+
M6HE269"U$DW?=@6(LH2]`%!73?_@Y7#*VKYU7:#)#<0QIF3^L]5D\IN#$"HH
MN8!V*^)I;J6MMG*'^VI#V7YI=?M)&JL">>#+:.2;/5!/.!U4BA'G:;(4LE1)
M(D[W]A'(>Q%SQ"%!FN4[8YV]MC7;OR5#KD43O*N:NYENMYCO5U:M/CZ&#*4Y
M\]`1#C&/$KYS)+)?#(GG#1G]SX;\KM(;F-C[W?(.FY\7[`\L^RKBP,CX1R%/
ECRH)]`7YX)-R0+\??BBIE;SK^O4TS6*>T65&O@':BVR[$P4`````
`
end
