Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWCBX3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWCBX3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbWCBX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:29:16 -0500
Received: from ns2.suse.de ([195.135.220.15]:27862 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750720AbWCBX3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:29:15 -0500
Date: Fri, 3 Mar 2006 00:29:09 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Bachem <info@colognechip.com>
Subject: [PATCH] Add new PCI IDs for HFC-S PCI
Message-ID: <20060302232909.GA17717@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Martin Bachem <info@colognechip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new PCI IDs for HFC-S PCI based ISDN TA 'Primux II S0' and 'Primux II S0'
from Gerdes AG

Signed-off-by: Martin Bachem <info@colognechip.com>
Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/config.c  |    2 ++
 drivers/isdn/hisax/hfc_pci.c |    2 ++
 include/linux/pci_ids.h      |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

2db3ff644c0d894fc56436a73e3ce724b84bd1e9
diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index 8159bce..df9d652 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -1929,6 +1929,8 @@ static struct pci_device_id hisax_pci_tb
 	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B00B,         PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B00C,         PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B100,         PCI_ANY_ID, PCI_ANY_ID},
+	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B700,         PCI_ANY_ID, PCI_ANY_ID},
+	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B701,         PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_ABOCOM,   PCI_DEVICE_ID_ABOCOM_2BD1,      PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_ASUSTEK,  PCI_DEVICE_ID_ASUSTEK_0675,     PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_BERKOM,   PCI_DEVICE_ID_BERKOM_T_CONCEPT, PCI_ANY_ID, PCI_ANY_ID},
diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 4866fc3..91d25ac 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -51,6 +51,8 @@ static const PCI_ENTRY id_list[] =
 	{PCI_VENDOR_ID_CCD, PCI_DEVICE_ID_CCD_B00B, "Billion", "B00B"},
 	{PCI_VENDOR_ID_CCD, PCI_DEVICE_ID_CCD_B00C, "Billion", "B00C"},
 	{PCI_VENDOR_ID_CCD, PCI_DEVICE_ID_CCD_B100, "Seyeon", "B100"},
+	{PCI_VENDOR_ID_CCD, PCI_DEVICE_ID_CCD_B700, "Primux II S0", "B700"},
+	{PCI_VENDOR_ID_CCD, PCI_DEVICE_ID_CCD_B701, "Primux II S0 NT", "B701"},
 	{PCI_VENDOR_ID_ABOCOM, PCI_DEVICE_ID_ABOCOM_2BD1, "Abocom/Magitek", "2BD1"},
 	{PCI_VENDOR_ID_ASUSTEK, PCI_DEVICE_ID_ASUSTEK_0675, "Asuscom/Askey", "675"},
 	{PCI_VENDOR_ID_BERKOM, PCI_DEVICE_ID_BERKOM_T_CONCEPT, "German telekom", "T-Concept"},
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 82b83da..1709b50 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1752,6 +1752,8 @@
 #define PCI_DEVICE_ID_CCD_B00B		0xb00b
 #define PCI_DEVICE_ID_CCD_B00C		0xb00c
 #define PCI_DEVICE_ID_CCD_B100		0xb100
+#define PCI_DEVICE_ID_CCD_B700		0xb700
+#define PCI_DEVICE_ID_CCD_B701		0xb701
 
 #define PCI_VENDOR_ID_EXAR		0x13a8
 #define PCI_DEVICE_ID_EXAR_XR17C152	0x0152
-- 
Karsten Keil
SuSE Labs
ISDN development
