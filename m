Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUHRQCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUHRQCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 12:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUHRQCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 12:02:34 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:51461 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267251AbUHRQCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 12:02:31 -0400
Date: Wed, 18 Aug 2004 11:01:52 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: cciss fix for 2.6.8.1-mm1, V100 PCI ID fix again
Message-ID: <20040818160152.GA6080@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow I managed to get the wrong PCI ID in pci_ids.h.
3210 is the correct PCI ID, 3211 is the subsystem ID. Sorry.
Applies to 2.6.8.1-mm1. Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx2681-mm1.orig/include/linux/pci_ids.h lx2681-mm1/include/linux/pci_ids.h
--- lx2681-mm1.orig/include/linux/pci_ids.h	2004-08-17 13:40:35.000000000 -0500
+++ lx2681-mm1/include/linux/pci_ids.h	2004-08-18 10:49:27.788871640 -0500
@@ -676,7 +676,7 @@
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
-#define PCI_DEVICE_ID_HP_CISS		0x3211
+#define PCI_DEVICE_ID_HP_CISS		0x3210
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
 #define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
