Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVLCMTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVLCMTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVLCMTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:19:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57604 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751237AbVLCMTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:19:44 -0500
Date: Sat, 3 Dec 2005 13:19:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: al@alarsen.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/qnx4/bitmap.c: #if 0 qnx4_new_block()
Message-ID: <20051203121944.GC31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

qnx4_new_block() is neither implemented nor used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc3-mm1/fs/qnx4/bitmap.c.old	2005-12-03 11:32:46.000000000 +0100
+++ linux-2.6.15-rc3-mm1/fs/qnx4/bitmap.c	2005-12-03 11:33:07.000000000 +0100
@@ -23,10 +23,12 @@
 #include <linux/buffer_head.h>
 #include <linux/bitops.h>
 
+#if 0
 int qnx4_new_block(struct super_block *sb)
 {
 	return 0;
 }
+#endif  /*  0  */
 
 static void count_bits(register const char *bmPart, register int size,
 		       int *const tf)

