Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbSKQKJI>; Sun, 17 Nov 2002 05:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbSKQKIl>; Sun, 17 Nov 2002 05:08:41 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:18700 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267482AbSKQKHx>; Sun, 17 Nov 2002 05:07:53 -0500
Date: Sun, 17 Nov 2002 08:14:41 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ntfs: fix up header file cleanups
Message-ID: <20021117101440.GF27924@conectiva.com.br>
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

Resending, my ISP relay is b0rked, sorry...

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	In this tree there will be several similar changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.850, 2002-11-17 07:50:35-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  ntfs that got it implicitly before.


 inode.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Sun Nov 17 07:50:52 2002
+++ b/fs/ntfs/inode.c	Sun Nov 17 07:50:52 2002
@@ -23,6 +23,7 @@
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
+#include <linux/mount.h>
 
 #include "ntfs.h"
 #include "dir.h"

===================================================================


This BitKeeper patch contains the following changesets:
1.850
## Wrapped with gzip_uu ##


begin 664 bkpatch12771
M'XL(`'QFUST``]U4WVO;,!!^COZ*@SR.V'>R9<=F*5VZGV30D-&GL0=%DFLS
MVPJVG+7@/WY*UC60=@\K>YI.(*0[W7VG[T-3N.E-ET^D:@R;PD?;NWRB;&N4
MJ_8R4+8)MIUW;*SUCK"TC0F7J[!J53UHT\]X()AWKZ53)>Q-U^<3"J+'$W>_
M,_ED\^[#S><W&\86"[@J97MKOA@'BP5SMMO+6O>7TI6U;0/7R;9OC#L6'A]#
M1X[(O0E*(Q3)2`G&Z:A($\F8C$8>SY.8'7JX/,=^EH6(4LRB-!8C$8^1O04*
MY@(!>4@44@J8Y@+S2,R0YXCP;%)X13!#MH1_V\`54_"^NH-A![)PIH/22.V7
MHJH-J-K(=MCU.4BMX75=M<-=V-BA=4%YX8'XNZTK>G"E='!K'51^-KNZ4I6K
M[V%K"MN9@*T@2S-BZQ,1;/:7@S&4R"Y@N1J+/CP4]7JPV@1JI"Q%)&\19B(;
MT6_B<:MT5,P3E<PUJBSES[_IDUPGN@1&?(R2.*:CA,X"#T)Z*136R+;HC/9H
M:ML50UU7A3D`^OJ;V6]_P(6"^T$X1C'-^5%&OM@3&?'_5D:_^+B&6??C.+TN
HUN?4O$!:G[@`8M.'#^8<X.FO4:51W_NA6?`X40)1LY^^[/P!RP0`````
`
end

----- End forwarded message -----
