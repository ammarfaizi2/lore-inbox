Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUESEZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUESEZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 00:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUESEZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 00:25:56 -0400
Received: from ozlabs.org ([203.10.76.45]:33489 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263786AbUESEZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 00:25:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16554.57796.25160.9562@cargo.ozlabs.ibm.com>
Date: Wed, 19 May 2004 14:25:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] put module license in swim3.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds module tags for the swim3 (macintosh floppy) driver.

Please apply.

Thanks,
Paul.
 
diff -urN linux-2.5/drivers/block/swim3.c pmac-2.5/drivers/block/swim3.c
--- linux-2.5/drivers/block/swim3.c	2004-02-23 12:05:12.000000000 +1100
+++ pmac-2.5/drivers/block/swim3.c	2004-03-11 17:09:58.000000000 +1100
@@ -1145,3 +1145,7 @@
 }
 
 module_init(swim3_init)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul Mackerras");
+MODULE_ALIAS_BLOCKDEV_MAJOR(FLOPPY_MAJOR);
