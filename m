Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWBHHMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWBHHMD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWBHHL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:1182 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161061AbWBHHL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] m32r_sio iomem annotations
Cc: rmk@arm.linx.org.uk
Message-Id: <E1F6jU6-0002hT-3K@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1139015752 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/serial/m32r_sio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6881761e63ac95fda3073443781ea928682fa600
diff --git a/drivers/serial/m32r_sio.h b/drivers/serial/m32r_sio.h
index 07d0dd8..7c3ec24 100644
--- a/drivers/serial/m32r_sio.h
+++ b/drivers/serial/m32r_sio.h
@@ -37,7 +37,7 @@ struct old_serial_port {
 	unsigned int irq;
 	unsigned int flags;
 	unsigned char io_type;
-	unsigned char *iomem_base;
+	unsigned char __iomem *iomem_base;
 	unsigned short iomem_reg_shift;
 };
 
-- 
0.99.9.GIT

