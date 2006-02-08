Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWBHHLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWBHHLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWBHHLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:11421 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161052AbWBHHLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:08 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] synclink_gt is PCI-only
Cc: paulkf@microgate.com
Message-Id: <E1F6jTm-0002dN-2C@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138792035 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8ef9cf318152d864d6694b19e655cbefa1e85256
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 4c67727..05ba410 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -222,7 +222,7 @@ config SYNCLINKMP
 
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	help
 	  Support for SyncLink GT and SyncLink AC families of
 	  synchronous and asynchronous serial adapters
-- 
0.99.9.GIT

