Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRIHJki>; Sat, 8 Sep 2001 05:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRIHJk2>; Sat, 8 Sep 2001 05:40:28 -0400
Received: from HINux.hin.no ([158.39.26.220]:59316 "EHLO hinux.hin.no")
	by vger.kernel.org with ESMTP id <S268856AbRIHJkR> convert rfc822-to-8bit;
	Sat, 8 Sep 2001 05:40:17 -0400
Subject: [PATCH] 2.4.10-pre5 missing pci id
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<zole@jblinux.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Sep 2001 11:45:31 -0100
Message-Id: <999953131.30644.1.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again..

This patch adds a missing pci id required by the trident sound driver.

Best regards,
Ole André

---

--- linux/include/linux/pci_ids.h-orig	Sat Sep  8 11:41:13 2001
+++ linux/include/linux/pci_ids.h	Sat Sep  8 11:41:34 2001
@@ -852,6 +852,7 @@
 #define PCI_DEVICE_ID_INTERG_2000	0x2000
 #define PCI_DEVICE_ID_INTERG_2010	0x2010
 #define PCI_DEVICE_ID_INTERG_5000	0x5000
+#define PCI_DEVICE_ID_INTERG_5050	0x5050
 
 #define PCI_VENDOR_ID_REALTEK		0x10ec
 #define PCI_DEVICE_ID_REALTEK_8029	0x8029

