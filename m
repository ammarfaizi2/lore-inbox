Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTBPCqF>; Sat, 15 Feb 2003 21:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbTBPCqF>; Sat, 15 Feb 2003 21:46:05 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:32261 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265675AbTBPCqC>; Sat, 15 Feb 2003 21:46:02 -0500
Subject: [PATCH] 2.5.61 Reduce the number of "nuber" by four.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 19:47:41 -0700
Message-Id: <1045363662.10680.72.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reduces the number of "nuber" by four and fixes the spelling
of necessary in one of those files.

Steven

diff -ur linux-2.5.61-1.1027-orig/drivers/net/shaper.c linux-2.5.61-1.1027/drivers/net/shaper.c
--- linux-2.5.61-1.1027-orig/drivers/net/shaper.c	Thu Jan 16 19:22:25 2003
+++ linux-2.5.61-1.1027/drivers/net/shaper.c	Sat Feb 15 19:32:47 2003
@@ -681,7 +681,7 @@
 #ifdef MODULE
 
 MODULE_PARM(shapers, "i");
-MODULE_PARM_DESC(shapers, "Traffic shaper: maximum nuber of shapers");
+MODULE_PARM_DESC(shapers, "Traffic shaper: maximum number of shapers");
 
 #else /* MODULE */
 
diff -ur linux-2.5.61-1.1027-orig/fs/befs/ChangeLog linux-2.5.61-1.1027/fs/befs/ChangeLog
--- linux-2.5.61-1.1027-orig/fs/befs/ChangeLog	Mon Feb 10 12:23:04 2003
+++ linux-2.5.61-1.1027/fs/befs/ChangeLog	Sat Feb 15 19:41:37 2003
@@ -102,7 +102,7 @@
 	The option is, simply enough, 'debug'. 
 	(super.c, debug.c) [WD]
 
-* Removed notion of btree handle from btree.c. It was unessisary, as the 
+* Removed notion of btree handle from btree.c. It was unnecessary, as the
 	linux VFS doesn't allow us to keep any state between calls. Updated 
 	dir.c, namei.c befs_fs.h to account for it. [WD]
 
@@ -312,9 +312,9 @@
 ==========
 * Fixed a misunderstanding of the inode fields. 
 	This fixed the problmem with wrong file sizes from du and others.
-	The i_blocks field of the inode struct is not the nuber of blocks for the 
+	The i_blocks field of the inode struct is not the number of blocks for the
 	inode, it is the number of blocks for the file.	Also, i_blksize is not
-	nessisarily the size of the inode, although in  practice it works out.
+	necessarily the size of the inode, although in  practice it works out.
 	Changed to blocksize of filesystem.
 	(fs/befs/inode.c)
 
diff -ur linux-2.5.61-1.1027-orig/include/linux/wireless.h linux-2.5.61-1.1027/include/linux/wireless.h
--- linux-2.5.61-1.1027-orig/include/linux/wireless.h	Thu Jan 16 19:22:22 2003
+++ linux-2.5.61-1.1027/include/linux/wireless.h	Sat Feb 15 19:33:03 2003
@@ -294,7 +294,7 @@
 #define IW_PRIV_TYPE_FLOAT	0x5000	/* struct iw_freq */
 #define IW_PRIV_TYPE_ADDR	0x6000	/* struct sockaddr */
 
-#define IW_PRIV_SIZE_FIXED	0x0800	/* Variable or fixed nuber of args */
+#define IW_PRIV_SIZE_FIXED	0x0800	/* Variable or fixed number of args */
 
 #define IW_PRIV_SIZE_MASK	0x07FF	/* Max number of those args */
 
diff -ur linux-2.5.61-1.1027-orig/sound/oss/trident.c linux-2.5.61-1.1027/sound/oss/trident.c
--- linux-2.5.61-1.1027-orig/sound/oss/trident.c	Mon Feb 10 12:23:10 2003
+++ linux-2.5.61-1.1027/sound/oss/trident.c	Sat Feb 15 19:42:10 2003
@@ -223,7 +223,7 @@
 
 #define NR_HW_CH		32
 
-/* maxinum nuber of AC97 codecs connected, AC97 2.0 defined 4, but 7018 and 4D-NX only
+/* maximum number of AC97 codecs connected, AC97 2.0 defined 4, but 7018 and 4D-NX only
    have 2 SDATA_IN lines (currently) */
 #define NR_AC97		2	
 



