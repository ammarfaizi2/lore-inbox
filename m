Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131786AbRAKLzs>; Thu, 11 Jan 2001 06:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131763AbRAKLzi>; Thu, 11 Jan 2001 06:55:38 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:11706 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131268AbRAKLz2>; Thu, 11 Jan 2001 06:55:28 -0500
Message-ID: <3A5D9F29.4274AD6B@sap.com>
Date: Thu, 11 Jan 2001 12:55:21 +0100
From: "Karsten Hopp (Red Hat)" <Karsten.Hopp@sap.com>
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-ac6: drivers/net/rcpci45.c typo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./drivers/net/rcpci45.c.orig        Thu Jan 11 12:49:19 2001
+++ ./drivers/net/rcpci45.c     Thu Jan 11 12:47:04 2001
@@ -120,7 +120,7 @@
        { RC_PCI45_VENDOR_ID, RC_PCI45_DEVICE_ID, PCI_ANY_ID,
PCI_ANY_ID, },
        { }
 };
-MODULE_DEVICE_TABLE(pci, rcpci_pci_table);
+MODULE_DEVICE_TABLE(pci, rcpci45_pci_table);
 
 static void __exit rcpci45_remove_one(struct pci_dev *pdev)
 {



--
 Karsten Hopp        | Karsten.Hopp@sap.com
 SAP-AG LinuxLab     | http://www.sap.com/linux/
 Neurottstrasse 16
 69190 Walldorf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
