Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVBDHiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVBDHiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVBDHaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:30:23 -0500
Received: from [211.58.254.17] ([211.58.254.17]:45225 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263410AbVBDHNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:25 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 13/14] ide_pci: Removes unused SVWKS_DEBUG_DRIVE_INFO
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071319.7C6FA13264B@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


13_ide_pci_serverworks_cleanup.patch

	Removes unused SVWKS_DEBUG_DRIVE_INFO from ide/pci/serverworks
	driver.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/serverworks.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/serverworks.h	2005-02-04 16:07:36.334451568 +0900
+++ linux-idepci-export/drivers/ide/pci/serverworks.h	2005-02-04 16:08:26.831227410 +0900
@@ -6,8 +6,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#undef SVWKS_DEBUG_DRIVE_INFO
-
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
 
