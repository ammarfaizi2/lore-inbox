Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWDMQWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWDMQWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDMQWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:22:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64016 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932079AbWDMQW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:22:26 -0400
Date: Thu, 13 Apr 2006 18:22:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/message/i2o/: remove unused exports
Message-ID: <20060413162225.GD4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following unused EXPORT_SYMBOL's:
- driver.c: i2o_driver_notify_controller_add_all
- driver.c: i2o_driver_notify_controller_remove_all
- driver.c: i2o_driver_notify_device_add_all
- driver.c: i2o_driver_notify_device_remove_all
- exec-osm.c: i2o_exec_lct_get

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/message/i2o/driver.c   |    4 ----
 drivers/message/i2o/exec-osm.c |    1 -
 2 files changed, 5 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/message/i2o/driver.c.old	2006-04-13 17:27:11.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/message/i2o/driver.c	2006-04-13 17:29:04.000000000 +0200
@@ -372,7 +372,3 @@
 
 EXPORT_SYMBOL(i2o_driver_register);
 EXPORT_SYMBOL(i2o_driver_unregister);
-EXPORT_SYMBOL(i2o_driver_notify_controller_add_all);
-EXPORT_SYMBOL(i2o_driver_notify_controller_remove_all);
-EXPORT_SYMBOL(i2o_driver_notify_device_add_all);
-EXPORT_SYMBOL(i2o_driver_notify_device_remove_all);
--- linux-2.6.17-rc1-mm2-full/drivers/message/i2o/exec-osm.c.old	2006-04-13 17:29:39.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/message/i2o/exec-osm.c	2006-04-13 17:29:46.000000000 +0200
@@ -583,4 +583,3 @@
 };
 
 EXPORT_SYMBOL(i2o_msg_post_wait_mem);
-EXPORT_SYMBOL(i2o_exec_lct_get);

