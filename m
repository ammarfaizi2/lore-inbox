Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQLaX2y>; Sun, 31 Dec 2000 18:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQLaX2o>; Sun, 31 Dec 2000 18:28:44 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:17140 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S129588AbQLaX2i>; Sun, 31 Dec 2000 18:28:38 -0500
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, mhaque@haque.net
Date: Sun, 31 Dec 2000 17:52:00 -0500
Subject: Re: [PATCH] 2.4.0-prerelease -- rcpci45 compile error
Message-ID: <20001231.175201.-277039.1.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0,2-5,7,9,11
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad,
  This appears to be a merge mismatch between Alan and Linus..This is
sent to Alan shortly after test13pre4-ac2 was released.
Regards,
Frank

--- linux/drivers/net/rcpci45.c.orig Sun Dec 31 15:58:05 2000 +++
linux/drivers/net/rcpci45.c Sun Dec 31 16:27:04 2000 @@ -157,7
+157,7 @@ { RC_PCI45_VENDOR_ID, RC_PCI45_DEVICE_ID, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0}, {0, } };
-MODULE_DEVICE_TABLE(pci, rcpci_pci_table); +MODULE_DEVICE_TABLE(pci,
rcpci45_pci_table); static void
rcpci45_remove_one(struct pci_dev *pdev) { 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
