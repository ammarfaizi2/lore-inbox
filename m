Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUFXVtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUFXVtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUFXVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:48:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:36278 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265770AbUFXVrX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:23 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135681238@kroah.com>
Date: Thu, 24 Jun 2004 14:46:08 -0700
Message-Id: <10881135682040@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1823.1.10, 2004/06/22 16:59:02-07:00, shemminger@osdl.org

[PATCH] PCI: add id's for sk98 driver

Redoing the sk98 driver to correct pci model.  These are (most of) the entries
it uses.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci_ids.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-06-24 13:49:32 -07:00
+++ b/include/linux/pci_ids.h	2004-06-24 13:49:32 -07:00
@@ -967,12 +967,14 @@
 
 #define PCI_VENDOR_ID_3COM		0x10b7
 #define PCI_DEVICE_ID_3COM_3C985	0x0001
+#define PCI_DEVICE_ID_3COM_3C940	0x1700
 #define PCI_DEVICE_ID_3COM_3C339	0x3390
 #define PCI_DEVICE_ID_3COM_3C359	0x3590
 #define PCI_DEVICE_ID_3COM_3C590	0x5900
 #define PCI_DEVICE_ID_3COM_3C595TX	0x5950
 #define PCI_DEVICE_ID_3COM_3C595T4	0x5951
 #define PCI_DEVICE_ID_3COM_3C595MII	0x5952
+#define PCI_DEVICE_ID_3COM_3C940B	0x80eb
 #define PCI_DEVICE_ID_3COM_3C900TPO	0x9000
 #define PCI_DEVICE_ID_3COM_3C900COMBO	0x9001
 #define PCI_DEVICE_ID_3COM_3C905TX	0x9050
@@ -1420,6 +1422,9 @@
 #define PCI_DEVICE_ID_RICOH_RL5C476	0x0476
 #define PCI_DEVICE_ID_RICOH_RL5C478	0x0478
 
+#define PCI_VENDOR_ID_DLINK		0x1186
+#define PCI_DEVICE_ID_DLINK_DGE510T	0x4c00
+
 #define PCI_VENDOR_ID_ARTOP		0x1191
 #define PCI_DEVICE_ID_ARTOP_ATP8400	0x0004
 #define PCI_DEVICE_ID_ARTOP_ATP850UF	0x0005
@@ -1735,6 +1740,9 @@
 #define PCI_VENDOR_ID_KAWASAKI		0x136b
 #define PCI_DEVICE_ID_MCHIP_KL5A72002	0xff01
 
+#define PCI_VENDOR_ID_CNET		0x1371
+#define PCI_DEVICE_ID_CNET_GIGACARD	0x434e
+
 #define PCI_VENDOR_ID_LMC		0x1376
 #define PCI_DEVICE_ID_LMC_HSSI		0x0003
 #define PCI_DEVICE_ID_LMC_DS3		0x0004
@@ -1918,6 +1926,10 @@
 #define PCI_DEVICE_ID_FARSITE_T4U       0x0640
 #define PCI_DEVICE_ID_FARSITE_TE1       0x1610
 #define PCI_DEVICE_ID_FARSITE_TE1C      0x1612
+
+#define PCI_VENDOR_ID_LINKSYS		0x1737
+#define PCI_DEVICE_ID_LINKSYS_EG1032	0x1032
+#define PCI_DEVICE_ID_LINKSYS_EG1064	0x1064
 
 #define PCI_VENDOR_ID_ALTIMA		0x173b
 #define PCI_DEVICE_ID_ALTIMA_AC1000	0x03e8

