Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbSKQJia>; Sun, 17 Nov 2002 04:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbSKQJia>; Sun, 17 Nov 2002 04:38:30 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:24335 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267471AbSKQJi3>; Sun, 17 Nov 2002 04:38:29 -0500
Date: Sun, 17 Nov 2002 07:45:06 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] quota: fix up header file cleanups
Message-ID: <20021117094506.GA27699@conectiva.com.br>
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


ChangeSet@1.845, 2002-11-17 07:24:58-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  quota that got it implicitly before.


 quota_v2.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/quota_v2.c b/fs/quota_v2.c
--- a/fs/quota_v2.c	Sun Nov 17 07:26:47 2002
+++ b/fs/quota_v2.c	Sun Nov 17 07:26:47 2002
@@ -4,6 +4,7 @@
 
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/dqblk_v2.h>
 #include <linux/quotaio_v2.h>
 #include <linux/kernel.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.845
## Wrapped with gzip_uu ##


begin 664 bkpatch8612
M'XL(`-=@UST``]U438^;,!`]Q[]BI!RK@,?80%!9I;O]6FVE1JGV7#G&!+J`
M4VRRFXH?7T*J727*I1^GVB/9\HS'S_.>9@KW5K?)1*I:DRE\--8E$V4:K5RY
MDYXRM;=N!\?*F,'A%Z;6_O6=7S:JZC)M9\P39'`OI5,%['1KDPEZP?.)VV]U
M,EF]^W#_Z<V*D#2%FT(V&_U%.TA3XDR[DU5F%](5E6D\U\K&UMJ-#_?/H3VC
ME`U38!10$?884A[U"C-$R5%GE/$XY.2QK*K](M/K4C:>:3=G"1`QHIPQ3GMD
M8120MX!>S`50YB/Z&`&-$L83$<\H2RB%0TT6Y[6`5P@S2J[AWV*_(0K>ET_0
M;4'F3K=0:)D-2UY6&E2E9=-M;0(RR^!U53;=DU^;KG%><34`&>Y^[XR3X`KI
M8&,<E(/5VZI4I:OVL-:Y:;5'[@`#BG.R?&&!S'YS$$(E)5?P3:J'A>VL]M2/
M/K?^".#KCGGJ^&/!*(8!9U&/ATVOM(@C5#D3D60ZQ\O5O9!II&W.F.!]$$2A
M&%5T$G90TM_"(;*0TBX:;:S)W4CAA2QSC&G`.8O[``4-CPHZU0]+!/]_]7-D
MX#/,VL?1!CTL3\GX`T'=AH!D^JNEG,-[Z2ZJT.K!=G6:YP,):T')3S"91\Z]
#!```
`
end
