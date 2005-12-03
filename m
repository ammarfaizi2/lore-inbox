Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVLCTtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVLCTtl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVLCTtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:49:40 -0500
Received: from mail2.ameuro.de ([195.140.232.8]:54254 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id S1750824AbVLCTtk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:49:40 -0500
Date: Sat, 03 Dec 2005 19:49:17 +0000
From: Anders Larsen <al@alarsen.net>
Subject: [2.6 patch] fs/qnx4/bitmap.c: #if 0 qnx4_new_block()
To: trivial@rustcorp.com.au
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.3.6
Message-Id: <1133639357l.4269l.0l@oscar.alarsen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-AEV-Kundenmail-Information: AEV Virus and Spam Secure Mail System
X-AEV-Kundenmail-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

qnx4_new_block() is neither implemented nor used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Anders Larsen <al@alarsen.net>

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



