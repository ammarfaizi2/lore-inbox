Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbSKQLgW>; Sun, 17 Nov 2002 06:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbSKQLgW>; Sun, 17 Nov 2002 06:36:22 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:33804 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267484AbSKQLgU>; Sun, 17 Nov 2002 06:36:20 -0500
Date: Sun, 17 Nov 2002 09:43:07 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] dquot: fix up header file cleanups
Message-ID: <20021117114307.GB28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
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

	In this tree there will be several similar changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.853, 2002-11-17 09:41:00-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  dquot that got it implicitly before.


 dquot.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Sun Nov 17 09:41:20 2002
+++ b/fs/dquot.c	Sun Nov 17 09:41:20 2002
@@ -55,6 +55,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/mm.h>
 #include <linux/time.h>
 #include <linux/types.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.853
## Wrapped with gzip_uu ##


begin 664 bkpatch3735
M'XL(`&"`UST``]U476^;,!1]CG_%E?(X`;[&!H)&E;7[5"<MRM2G:0^N,0$5
M,`.3M1(_?F[2-EU6J>JTI_G;OO;QN;Y'GL/%H/MT)E6CR1P^FL&F,V5:K6RU
ME;XRC7_9.\/:&&<(2M/HX/0\J%I5C[D>/.8+XLPK:54)6]T/Z0S]\&'%WG0Z
MG:W??;CX_&9-2);!62G;C?ZJ+609L:;?RCH?EM*6M6E]V\MV:+3=73P];)T8
MI<QE@7%(131A1'D\*<P1)4>=4\:3B)-;'Y;'W(]0$#%V=<$7$SJ0B+P%]!,1
M`F4!8H`QT$7*,:74H\RU\"0HO$+P*#F%?^O`&5'POKJ&L0-96-U#J67NNJ*J
M-:A:RW;LAA1DGL/KNFK'ZZ`Q8VO]\L01<6?S'Z.Q8$MI8>,&E2M-5U>JLO4-
M7.K"]-HGYX"4Q@E9'4)!O!<F0JBDY.09]XLAV#'RU6/_%V$R81B*<-*,N@F3
M,A&11!$]_=;',/L(<BKB2="$BYVJ#GN>E]5+:1%YU37+O-IH<WO^VSWZ]S^8
M40Q9*!+.)IZ(9*\MOOA=6C05\?\KK7U$OH#7_]P5)Y75H^#\A=`^B1B0S.\^
<G&-RA[]'E5I=#6.31:I0(F81^05+41]6VP0`````
`
end
