Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263256AbVCDVXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbVCDVXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVCDVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:20:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:29089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263105AbVCDUyM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:12 -0500
Cc: benh@kernel.crashing.org
Subject: [PATCH] PCI: Apple PCI IDs update
In-Reply-To: <11099696382576@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:58 -0800
Message-Id: <11099696382976@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.24, 2005/02/25 14:36:10-08:00, benh@kernel.crashing.org

[PATCH] PCI: Apple PCI IDs update

please sent that to Andrew/Linus in your next batch for after 2.6.11,
those new IDs will be needed for support of the new iMac G5.

The changes to pci.ids match the changes already submitted to the web
database.

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/pci_ids.h |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-03-04 12:41:26 -08:00
+++ b/include/linux/pci_ids.h	2005-03-04 12:41:26 -08:00
@@ -862,6 +862,9 @@
 #define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
 #define PCI_DEVICE_ID_APPLE_K2_ATA100	0x0043
 #define PCI_DEVICE_ID_APPLE_K2_GMAC	0x004c
+#define PCI_DEVICE_ID_APPLE_SH_ATA      0x0050
+#define PCI_DEVICE_ID_APPLE_SH_SUNGEM   0x0051
+#define PCI_DEVICE_ID_APPLE_SH_FW       0x0052
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073

