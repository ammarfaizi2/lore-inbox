Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUFXWLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUFXWLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUFXWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:08:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:42678 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265768AbUFXVrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:36 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <1088113568457@kroah.com>
Date: Thu, 24 Jun 2004 14:46:08 -0700
Message-Id: <10881135681238@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1823.1.9, 2004/06/22 16:58:27-07:00, shemminger@osdl.org

[PATCH] PCI: fix out of order entry in pci_ids.h

The last entry in pci_ids.h is out of order, someone wasn't reading the comment
to keep it sorted.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci_ids.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-06-24 13:49:47 -07:00
+++ b/include/linux/pci_ids.h	2004-06-24 13:49:47 -07:00
@@ -1769,6 +1769,12 @@
 #define PCI_DEVICE_ID_CCD_B00C		0xb00c
 #define PCI_DEVICE_ID_CCD_B100		0xb100
 
+#define PCI_VENDOR_ID_MICROGATE		0x13c0
+#define PCI_DEVICE_ID_MICROGATE_USC	0x0010
+#define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
+#define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
+#define PCI_DEVICE_ID_MICROGATE_USC2	0x0210
+
 #define PCI_VENDOR_ID_3WARE		0x13C1
 #define PCI_DEVICE_ID_3WARE_1000	0x1000
 #define PCI_DEVICE_ID_3WARE_7000	0x1001
@@ -2266,9 +2272,3 @@
 #define PCI_DEVICE_ID_ARK_STING		0xa091
 #define PCI_DEVICE_ID_ARK_STINGARK	0xa099
 #define PCI_DEVICE_ID_ARK_2000MT	0xa0a1
-
-#define PCI_VENDOR_ID_MICROGATE		0x13c0
-#define PCI_DEVICE_ID_MICROGATE_USC	0x0010
-#define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
-#define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
-#define PCI_DEVICE_ID_MICROGATE_USC2	0x0210

