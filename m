Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbSKQLP3>; Sun, 17 Nov 2002 06:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSKQLP3>; Sun, 17 Nov 2002 06:15:29 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:27404 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267409AbSKQLP1>; Sun, 17 Nov 2002 06:15:27 -0500
Date: Sun, 17 Nov 2002 09:22:13 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] smbfs: fix up header file cleanups
Message-ID: <20021117112213.GB28051@conectiva.com.br>
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


ChangeSet@1.852, 2002-11-17 09:19:49-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  smbfs that got it implicitly before.


 inode.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/smbfs/inode.c b/fs/smbfs/inode.c
--- a/fs/smbfs/inode.c	Sun Nov 17 09:20:34 2002
+++ b/fs/smbfs/inode.c	Sun Nov 17 09:20:34 2002
@@ -22,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/nls.h>
 #include <linux/seq_file.h>
+#include <linux/mount.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.852
## Wrapped with gzip_uu ##


begin 664 bkpatch19294
M'XL(`()[UST``]V4;VO;,!#&7T>?XB`O1VR=+#NQ64K6[B\M+&3T`\C2.3:U
MK6#+60O^\-6RM1UI1EG9J]D2!M_I])R>'YK"=4]=-E&Z(3:%S[9WV43;EK2K
M]BK0M@GRS@<VUOI`6-J&PO/+L&IU/1CJ9R*(F0^OE=,E[*GKLPD&T>,?=[>C
M;++Y\.GZZMV&L>42+DK5;ND;.5@NF;/=7M6F7RE7UK8-7*?:OB%WV'A\3!T%
MY\*_,<XC'B<C)ES.1XT&44DDPX5<))+]Z&%UK/VH"B+._4Q1CLAEG++W@,$B
M%L!%B!CB''B:89K)=,9%QCF<+`IO$&:<G<._;>"":?A8W<*P`U4XZJ`D9?RG
MJ&H"79-JAUV?@3(&WM95.]R&C1U:%Y1G7HA?VS=YT8,KE8.M=5#YT>SJ2E>N
MOH.<"MM1P"[!-SY/V/K)"C;[RX<QKC@[>Z']H@\/BCPMUE"@?S^%-%J,`B.Y
M&*DP>;$046HH+O*"3I_XZ6(/;DHY)C)*Y8&PX\R707N=4)9O/>]N92K3.C/H
MF\!VVS_HY-POC(6W/O'%X@-UD7P&G?Q_H?OISU>8==\/PT.T?F;5*T#\(B0@
?F_ZZD(XE/MU-NB1]TP_-$@N5)+%$=@_%$&*8^P0`````
`
end
