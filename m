Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753101AbWKFNdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbWKFNdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbWKFNdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:33:39 -0500
Received: from master.altlinux.org ([62.118.250.235]:1550 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1753097AbWKFNdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:33:38 -0500
From: Sergey Vlasov <vsu@altlinux.ru>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jan Mate <mate@fiit.stuba.sk>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] usb-storage: Remove duplicated unusual_devs.h entries for Sony Ericsson P990i
Date: Mon,  6 Nov 2006 16:33:07 +0300
Message-Id: <11628199871999-git-send-email-vsu@altlinux.ru>
X-Mailer: git-send-email 1.4.3.4.g08e35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason the unusual_devs.h entry for Sony Ericsson P990i had
three identical copies in a wrong place in the file in addition to the
correct entry.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 drivers/usb/storage/unusual_devs.h |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index bc1ac07..2ff1a72 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1299,27 +1299,6 @@ UNUSUAL_DEV(  0x0fce, 0xe031, 0x0000, 0x
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY ),
 
-/* Reported by Jan Mate <mate@fiit.stuba.sk> */
-UNUSUAL_DEV(  0x0fce, 0xe030, 0x0000, 0x0000,
-		"Sony Ericsson",
-		"P990i",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
-
-/* Reported by Jan Mate <mate@fiit.stuba.sk> */
-UNUSUAL_DEV(  0x0fce, 0xe030, 0x0000, 0x0000,
-		"Sony Ericsson",
-		"P990i",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
-
-/* Reported by Jan Mate <mate@fiit.stuba.sk> */
-UNUSUAL_DEV(  0x0fce, 0xe030, 0x0000, 0x0000,
-		"Sony Ericsson",
-		"P990i",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
-
 /* Reported by Kevin Cernekee <kpc-usbdev@gelato.uiuc.edu>
  * Tested on hardware version 1.10.
  * Entry is needed only for the initializer function override.
-- 
1.4.3.4.g08e35

