Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSDYOyE>; Thu, 25 Apr 2002 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSDYOyD>; Thu, 25 Apr 2002 10:54:03 -0400
Received: from zeus.kernel.org ([204.152.189.113]:15089 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313181AbSDYOxv>;
	Thu, 25 Apr 2002 10:53:51 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove linux/bitops.h of fat  (5/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 25 Apr 2002 23:51:41 +0900
Message-ID: <87r8l3n85e.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, became unnecessary to include linux/bitops.h. 
This patch remove linux/bitops.h from fat/inode.c. 

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_cluster_flush_cleanup-2.5.9/fs/fat/inode.c fat_bitops-2.5.9/fs/fat/inode.c
--- fat_cluster_flush_cleanup-2.5.9/fs/fat/inode.c	Thu Apr 25 01:45:38 2002
+++ fat_bitops-2.5.9/fs/fat/inode.c	Thu Apr 25 01:49:19 2002
@@ -17,7 +17,6 @@
 #include <linux/smp_lock.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
-#include <linux/bitops.h>
 
 //#include <asm/uaccess.h>
 #include <asm/unaligned.h>
