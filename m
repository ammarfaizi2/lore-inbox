Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbSKQJjU>; Sun, 17 Nov 2002 04:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbSKQJjU>; Sun, 17 Nov 2002 04:39:20 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:25871 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267472AbSKQJjP>; Sun, 17 Nov 2002 04:39:15 -0500
Date: Sun, 17 Nov 2002 07:46:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] cifsfs: fix up header file cleanups
Message-ID: <20021117094604.GB27699@conectiva.com.br>
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


ChangeSet@1.846, 2002-11-17 07:28:50-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  cifs that got it implicitly before.


 cifsfs.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c	Sun Nov 17 07:29:10 2002
+++ b/fs/cifs/cifsfs.c	Sun Nov 17 07:29:10 2002
@@ -25,6 +25,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/version.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.846
## Wrapped with gzip_uu ##


begin 664 bkpatch8721
M'XL(`&9AUST``]U4;6O;,!#^'/V*@WP<D>_DUYBE9.U>Z:`AHS]`D>7:S+:"
M)6<M^,=/<4<*:?MA8_LRW2&![O3H.=V#YG!K=9_/I&HUF\-G8UT^4Z;3RM4'
MR95I^:[W@:TQ/A!4IM7!Y750=ZH9"FT7@L?,AS?2J0H.NK?YC'AXVG$/>YW/
MMA\^W7Y]MV5LM8*K2G9W^IMVL%HQ9_J#;`J[EJYJ3,==+SO;:C==/)Y21X$H
MO,64AA@G(R48I:.B@DA&I`L4499$[%C#^IS[&0H1I;@449R-%"(MV7L@GD4)
MH`B(`DH!TUQD>8P+%#DBO`@*;P@6R"[A[Q9PQ11\K.]AV(,LG>ZATK+P2UDW
M&E2C93?L;0ZR*.!M4W?#?=":H7.\NO!$_%E5EQ9<)1W<&0>U]W;?U*IVS0/L
M=&EZS=DUD$@(V>:I$VSQFX,QE,@NP#I]T.7:MN51%\3E8%W=\;Z?JB]M<"0T
M3:7EZO']T=N2/(,Q3*-8C$(E6*A8:"I%J8KLY0=_!>RQF5D4CQACE$P".\\\
MZNQ?$#V!3HL3Q!NGK&QW\C7`D(2?,1U1I%DZ*2\ZUUT4_[>ZFSIT`XO^Q^1>
J1IMGS?H#*7X1*1";__J1S@D^?4ZJTNJ['=H5Z:Q,0DK83PF]-5#\!```
`
end
