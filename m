Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268539AbUHRBeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268539AbUHRBeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268540AbUHRBeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:34:09 -0400
Received: from mail.yuco.com ([66.153.118.253]:57307 "EHLO mail.yuco.com")
	by vger.kernel.org with ESMTP id S268539AbUHRBeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:34:06 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B166ED58-F0B6-11D8-B13F-003065B218A6@yuco.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, torvalds@osdl.org
From: Robert Minsk <egbert@yuco.com>
Subject: [PATCH] ATTO pci card ids
Date: Tue, 17 Aug 2004 18:34:05 -0700
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of porting attotech's patches to the lsi mptlinux scsi 
drivers I noticed that the pci vendor id and devices where hardcoded 
into the patch.  Included are the defines for the ATTO Technologies 
UL4D and UL4S Ultra 320 PCI host adapter.

diff -u linux-2.6.8.1/include/linux/pci_ids.h 
linux-2.6.8.1.atto/include/linux/pci_ids.h

--- linux-2.6.8.1/include/linux/pci_ids.h	2004-08-14 03:56:26.000000000 
-0700
+++ linux-2.6.8.1.atto/include/linux/pci_ids.h	2004-08-17 
16:27:17.651679149 -0700
@@ -2311,3 +2311,10 @@
  #define PCI_DEVICE_ID_ARK_STING		0xa091
  #define PCI_DEVICE_ID_ARK_STINGARK	0xa099
  #define PCI_DEVICE_ID_ARK_2000MT	0xa0a1
+
+#define PCI_VENDOR_ID_ATTO		0x117c
+#define PCI_DEVICE_ID_ATTO_UL		0x0030
+#define PCI_SUBVENDOR_ID_ATTO		0x117c
+#define PCI_SUBDEVICE_ID_ATTO_UL4D	0x8013
+#define PCI_SUBDEVICE_ID_ATTO_UL4S	0x8014
+

