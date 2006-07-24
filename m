Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWGXRWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWGXRWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWGXRWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:22:52 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:65258 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932243AbWGXRWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:22:50 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 1/2] GEODE: Update and fixup the PCI IDs for the CS5535
Date: Mon, 24 Jul 2006 10:53:20 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165320.18787.15444.stgit@cosmic.amd.com>
In-Reply-To: <20060724165046.18787.23690.stgit@cosmic.amd.com>
References: <20060724165046.18787.23690.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:49:18.0699 (UTC)
 FILETIME=[1AFA63B0:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA25840Y8101726-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Clean up redundant and poorly worded PCI IDs

Signed-off-by:  Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/gxfb_core.c |    2 +-
 include/linux/pci_ids.h         |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 0d3643f..a454dcb 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -380,7 +380,7 @@ static void gxfb_remove(struct pci_dev *
 }
 
 static struct pci_device_id gxfb_id_table[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_VIDEO,
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_GX_VIDEO,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
 	{ 0, }
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c09396d..ca1c50c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -390,7 +390,7 @@ #define PCI_DEVICE_ID_NS_CS5535_ISA	0x00
 #define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 #define PCI_DEVICE_ID_NS_CS5535_AUDIO	0x002e
 #define PCI_DEVICE_ID_NS_CS5535_USB	0x002f
-#define PCI_DEVICE_ID_NS_CS5535_VIDEO	0x0030
+#define PCI_DEVICE_ID_NS_GX_VIDEO	0x0030
 #define PCI_DEVICE_ID_NS_SATURN		0x0035
 #define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
 #define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
@@ -403,8 +403,7 @@ #define PCI_DEVICE_ID_NS_SC1100_SMI	0x05
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
-#define PCI_DEVICE_ID_NS_CS5535_HOST_BRIDGE  0x0028
-#define PCI_DEVICE_ID_NS_CS5535_ISA_BRIDGE   0x002b
+#define PCI_DEVICE_ID_NS_GX_HOST_BRIDGE  0x0028
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202


