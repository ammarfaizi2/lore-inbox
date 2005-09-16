Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbVIPRcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbVIPRcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVIPRcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:32:52 -0400
Received: from mail.suse.de ([195.135.220.2]:12780 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030587AbVIPRcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:32:52 -0400
Date: Fri, 16 Sep 2005 19:32:53 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [ISDN] Add PCI IDs for Sitecom DC-105
Message-ID: <20050916173253.GA25036@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sitecom DC-105 PCI work with hfc_pci HiSax driver

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/hfc_pci.c |    1 +
 include/linux/pci_ids.h      |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

17a9a36f2e43474b7ec59e72baae8f239a00a1b0
diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -61,6 +61,7 @@ static const PCI_ENTRY id_list[] =
 	{PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_DF_M_E,"Digi International", "Digi DataFire Micro V (Europe)"},
 	{PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_DF_M_IOM2_A,"Digi International", "Digi DataFire Micro V IOM2 (North America)"},
 	{PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_DF_M_A,"Digi International", "Digi DataFire Micro V (North America)"},
+	{PCI_VENDOR_ID_SITECOM, PCI_DEVICE_ID_SITECOM_DC105V2, "Sitecom Europe", "DC-105 ISDN PCI"},
 	{0, 0, NULL, NULL},
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2252,6 +2252,9 @@
 
 #define PCI_VENDOR_ID_INFINICON		0x1820
 
+#define PCI_VENDOR_ID_SITECOM		0x182d
+#define PCI_DEVICE_ID_SITECOM_DC105V2	0x3069
+        
 #define PCI_VENDOR_ID_TOPSPIN		0x1867
 
 #define PCI_VENDOR_ID_TDI               0x192E

-- 
Karsten Keil
SuSE Labs
ISDN development
