Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316069AbSEZNWJ>; Sun, 26 May 2002 09:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316072AbSEZNWI>; Sun, 26 May 2002 09:22:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:44984 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316069AbSEZNWG>;
	Sun, 26 May 2002 09:22:06 -0400
Date: Sun, 26 May 2002 15:22:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: [patch] Trivial: move PCI ID definitions from ide-pci.c to pci_ids.h
Message-ID: <20020526152204.A18812@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.585, 2002-05-26 15:19:41+02:00, vojtech@twilight.ucw.cz
  This cset moves a PCI ID definition from ide-pci.c to
  pci_ids.h where it belongs.


 drivers/ide/ide-pci.c   |    6 +-----
 include/linux/pci_ids.h |    4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/ide/ide-pci.c b/drivers/ide/ide-pci.c
--- a/drivers/ide/ide-pci.c	Sun May 26 15:20:16 2002
+++ b/drivers/ide/ide-pci.c	Sun May 26 15:20:16 2002
@@ -27,10 +27,6 @@
 
 #include "pcihost.h"
 
-/* Missing PCI device IDs: */
-#define PCI_VENDOR_ID_HINT 0x3388
-#define PCI_DEVICE_ID_HINT 0x8013
-
 /*
  * This is the list of registered PCI chipset driver data structures.
  */
@@ -756,7 +752,7 @@
 	},
 	{
 		vendor: PCI_VENDOR_ID_HINT,
-		device: PCI_DEVICE_ID_HINT,
+		device: PCI_DEVICE_ID_HINT_VXPROII_IDE,
 		bootable: ON_BOARD
 	},
 	{
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sun May 26 15:20:16 2002
+++ b/include/linux/pci_ids.h	Sun May 26 15:20:16 2002
@@ -1787,3 +1787,7 @@
 #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
 #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
 #define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
+
+#define PCI_VENDOR_ID_HINT		0x3388
+#define PCI_DEVICE_ID_HINT_VXPROII_IDE	0x8013
+



-- 
Vojtech Pavlik
SuSE Labs
