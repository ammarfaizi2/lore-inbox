Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263755AbTCUSiK>; Fri, 21 Mar 2003 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263742AbTCUSha>; Fri, 21 Mar 2003 13:37:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6532
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263743AbTCUSgC>; Fri, 21 Mar 2003 13:36:02 -0500
Date: Fri, 21 Mar 2003 19:51:17 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211951.h2LJpHFA026067@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: typo fix for expfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/exportfs/expfs.c linux-2.5.65-ac2/fs/exportfs/expfs.c
--- linux-2.5.65/fs/exportfs/expfs.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/exportfs/expfs.c	2003-03-20 18:47:27.000000000 +0000
@@ -447,7 +447,7 @@
  * @dentry:  the dentry to encode
  * @fh:      where to store the file handle fragment
  * @max_len: maximum length to store there
- * @connectable: whether to store parent infomation
+ * @connectable: whether to store parent information
  *
  * This default encode_fh function assumes that the 32 inode number
  * is suitable for locating an inode, and that the generation number
