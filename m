Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLaV7z>; Sun, 31 Dec 2000 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbQLaV7p>; Sun, 31 Dec 2000 16:59:45 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:23017 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129669AbQLaV7k>; Sun, 31 Dec 2000 16:59:40 -0500
Message-ID: <3A4FA521.404FAADA@haque.net>
Date: Sun, 31 Dec 2000 16:29:05 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.0-prerelease -- rcpci45 compile error
Content-Type: multipart/mixed;
 boundary="------------71FCCD8F9DED7901884242E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------71FCCD8F9DED7901884242E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------71FCCD8F9DED7901884242E0
Content-Type: text/plain; charset=us-ascii;
 name="rcpci45.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rcpci45.diff"

--- linux/drivers/net/rcpci45.c.orig	Sun Dec 31 15:58:05 2000
+++ linux/drivers/net/rcpci45.c	Sun Dec 31 16:27:04 2000
@@ -157,7 +157,7 @@
 	{ RC_PCI45_VENDOR_ID, RC_PCI45_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0, }
 };
-MODULE_DEVICE_TABLE(pci, rcpci_pci_table);
+MODULE_DEVICE_TABLE(pci, rcpci45_pci_table);
 
 static void rcpci45_remove_one(struct pci_dev *pdev)
 {

--------------71FCCD8F9DED7901884242E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
