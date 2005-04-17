Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVDQUBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVDQUBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVDQUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:01:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5651 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261461AbVDQUA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:00:57 -0400
Date: Sun, 17 Apr 2005 22:00:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James Chapman <jchapman@katalix.com>
Cc: greg@kroah.com, khali@linux-fr.org, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/i2c/chips/ds1337.c: #if 0 an unused function
Message-ID: <20050417200056.GG3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's an unused global function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/i2c/chips/ds1337.c.old	2005-04-17 18:32:54.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/i2c/chips/ds1337.c	2005-04-17 18:33:16.000000000 +0200
@@ -228,6 +228,7 @@
  * Public API for access to specific device. Useful for low-level
  * RTC access from kernel code.
  */
+#if 0
 int ds1337_do_command(int id, int cmd, void *arg)
 {
 	struct list_head *walk;
@@ -242,6 +243,7 @@
 
 	return -ENODEV;
 }
+#endif  /*  0  */
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter)
 {

