Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSCRXFB>; Mon, 18 Mar 2002 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293224AbSCRXEw>; Mon, 18 Mar 2002 18:04:52 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:57844 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S293206AbSCRXEn>; Mon, 18 Mar 2002 18:04:43 -0500
Message-Id: <200203182304.RAA15098@austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [BK patch] JFS compile error on 2.5.7
Date: Mon, 18 Mar 2002 17:04:22 -0600
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.538, 2002-03-18 16:59:25-06:00, shaggy@kleikamp.austin.ibm.com
  JFS: must include completion.h


 jfs_logmgr.c |    1 +
 jfs_txnmgr.c |    1 +
 super.c      |    1 +
 3 files changed, 3 insertions(+)


diff -Nru a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
--- a/fs/jfs/jfs_logmgr.c	Mon Mar 18 17:00:37 2002
+++ b/fs/jfs/jfs_logmgr.c	Mon Mar 18 17:00:37 2002
@@ -66,6 +66,7 @@
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
+#include <linux/completion.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
diff -Nru a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
--- a/fs/jfs/jfs_txnmgr.c	Mon Mar 18 17:00:37 2002
+++ b/fs/jfs/jfs_txnmgr.c	Mon Mar 18 17:00:37 2002
@@ -47,6 +47,7 @@
 #include <linux/locks.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
+#include <linux/completion.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
diff -Nru a/fs/jfs/super.c b/fs/jfs/super.c
--- a/fs/jfs/super.c	Mon Mar 18 17:00:37 2002
+++ b/fs/jfs/super.c	Mon Mar 18 17:00:37 2002
@@ -22,6 +22,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/completion.h>
 #include <asm/uaccess.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"

===================================================================


This BitKeeper patch contains the following changesets:
1.538
## Wrapped with gzip_uu ##


begin 664 bkpatch16347
M'XL(`)5QECP``]56R6[;,!0\FU]!P,?"$E=1%.H@;;JE+5`C0<X%+=&6:BV&
MEC0!^/&E+#MN6KFQDN80+1>1',Z\T3QP#*\J70:C*E;+Y2T8PT]%50>C5:J3
ME<K6CFJJ.LF=9)XY89'9\8NBL.-N7&3:[1:Y\Y7[8U%-B,.!G3!3=1C#:UU6
MP0@[].Y+?;O6P>CB_<>KKV\N`)A.X5FL\J6^U#6<3D%=E-<JC:I35<=ID3MU
MJ?(JT[5J]S5W4PU!B-B;8T$1]PSV$!,FQ!'&BF$=(<)\C^W16I[_QJ+8QY+9
M=89Y/A'@'<0.ISY$Q$74Q3[$7L!E0/@$>0%"L!-]>J!"\!6%$P3>PO^KYPR$
M\/.'RP!F=C>8Y&':1!I:I'6JZ\3"Q^`+9#X5$LSV=063@1<`2"%P`M>M8X<D
MFD75^MV^W^N;/%N63KB500CF"'-B&)82&Q5Y"$LNJ59SJRMZH':'@:U'A'!I
M/:*<"#Z$85HL>QE223S?A(K,?23\N2WW8A'J`0SO`^\9<H&0.)9AU:QU#SD/
M<2X,7Q"Z4,C'OE!$>_,CR=W#W/-B0A"^R5V/B#:!SU32I^!*QK%G."-$;G))
M_THE.S*5^+E2>=Z?Q>XO^`8GY<_-8[,UZRO\(R)Z[EGU8+QK`J_3)&]NW-_W
M/_G3YEV:!MD\+-M/Q:6&$B:[]DM>C,U=.SIL\T[K8VQF<HC-V]0?[?"@S@.N
MD[(XS6PUG775.#IJ#C0;3%HH9!B3K/.2O1@ONP;9[^56YF-L).QA&W=GI##6
4X:IJLJG62(2*"_`+?.M-MZ`)````
`
end
