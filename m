Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbWJJVrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbWJJVrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWJJVrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:47:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25275 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030513AbWJJVqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:46:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] fix misannotation in ioc4.h
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPR1-0007N6-9w@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:46:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/ioc4.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ioc4.h b/include/linux/ioc4.h
index de73a32..51e2b9f 100644
--- a/include/linux/ioc4.h
+++ b/include/linux/ioc4.h
@@ -157,7 +157,7 @@ struct ioc4_driver_data {
 	unsigned long idd_bar0;
 	struct pci_dev *idd_pdev;
 	const struct pci_device_id *idd_pci_id;
-	struct __iomem ioc4_misc_regs *idd_misc_regs;
+	struct ioc4_misc_regs __iomem *idd_misc_regs;
 	unsigned long count_period;
 	void *idd_serial_data;
 	unsigned int idd_variant;
-- 
1.4.2.GIT


