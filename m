Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXDX5>; Thu, 23 Nov 2000 22:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129219AbQKXDXr>; Thu, 23 Nov 2000 22:23:47 -0500
Received: from [209.249.10.20] ([209.249.10.20]:65244 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129153AbQKXDXa>; Thu, 23 Nov 2000 22:23:30 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 23 Nov 2000 18:53:07 -0800
Message-Id: <200011240253.SAA07442@baldur.yggdrasil.com>
To: jsk@mojave.stanford.edu, ran@krazynet.com
Subject: imsttfb.c PCI ID's?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	In writing a pci_device_id table for
linux-2.4.0-test11/drivers/video/imsttfb.c, I see that that driver
theoretically attepts to bind to any PCI video display with
a vendor ID set to PCI_VENDOR_ID_IMS, although the code does
mention device ID's 0x9128 and 0x9135.  Does anybody know if
there are other device ID's besides 0x9128 and 0x9135 that
imsttfb.c is interested in, or is it OK to write the
pci_device_id table to just specify those two rather than all
PCI video cards made by IMS?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
