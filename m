Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVAYHyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVAYHyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVAYHwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:52:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18183 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261861AbVAYHtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:49:09 -0500
Date: Tue, 25 Jan 2005 08:49:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, jeffpc@optonline.net
Subject: [2.6 patch] *-iosched.c: Use proper documentation path
Message-ID: <20050125074906.GE3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch by Josef "Jeff" Sipek <jeffpc@optonline.net> fixes two 
documentationn paths.

Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

diff -Nru a/drivers/block/as-iosched.c b/drivers/block/as-iosched.c
--- a/drivers/block/as-iosched.c	2004-12-02 19:45:45 -05:00
+++ b/drivers/block/as-iosched.c	2004-12-02 19:45:45 -05:00
@@ -25,7 +25,7 @@
 #define REQ_ASYNC	0
 
 /*
- * See Documentation/as-iosched.txt
+ * See Documentation/block/as-iosched.txt
  */
 
 /*
diff -Nru a/drivers/block/deadline-iosched.c b/drivers/block/deadline-iosched.c
--- a/drivers/block/deadline-iosched.c	2004-12-02 19:45:45 -05:00
+++ b/drivers/block/deadline-iosched.c	2004-12-02 19:45:45 -05:00
@@ -19,7 +19,7 @@
 #include <linux/rbtree.h>
 
 /*
- * See Documentation/deadline-iosched.txt
+ * See Documentation/block/deadline-iosched.txt
  */
 static int read_expire = HZ / 2;  /* max time before a read is submitted. */
 static int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */





