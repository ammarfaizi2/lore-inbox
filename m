Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUGBVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUGBVmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbUGBVlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:41:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:31890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264997AbUGBVkc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:40:32 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <1088804352158@kroah.com>
Date: Fri, 2 Jul 2004 14:39:12 -0700
Message-Id: <10888043522340@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1789, 2004/07/02 13:53:00-07:00, buytenh@wantstofly.org

[PATCH] PCI: New PCI vendor/device ID for Radisys ENP-2611 board

Included is a patch for linux to add a PCI vendor/device ID for the
Radisys ENP-2611 board.  The ENP-2611 is a 64bit/66MHz PCI board which
hosts an Intel IXP2400 network processor, has three GigE interfaces,
runs linux and generally kicks ass.

(see http://www.radisys.com/oem_products/ds-page.cfm?productdatasheetsid=1147)


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.ids     |    1 +
 include/linux/pci_ids.h |    3 +++
 2 files changed, 4 insertions(+)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	2004-07-02 14:24:06 -07:00
+++ b/drivers/pci/pci.ids	2004-07-02 14:24:06 -07:00
@@ -5535,6 +5535,7 @@
 132d  Integrated Silicon Solution, Inc.
 1330  MMC Networks
 1331  Radisys Corp.
+	0030  ENP-2611
 	8200  82600 Host Bridge
 	8201  82600 IDE
 	8202  82600 USB
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-07-02 14:24:06 -07:00
+++ b/include/linux/pci_ids.h	2004-07-02 14:24:06 -07:00
@@ -1711,6 +1711,9 @@
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_650	0x2061
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_850	0x2062
 
+#define PCI_VENDOR_ID_RADISYS		0x1331
+#define PCI_DEVICE_ID_RADISYS_ENP2611	0x0030
+
 #define PCI_VENDOR_ID_DOMEX		0x134a
 #define PCI_DEVICE_ID_DOMEX_DMX3191D	0x0001
 

