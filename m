Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936116AbWLAOdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936116AbWLAOdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936308AbWLAOdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:33:31 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:47120 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936116AbWLAOda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:33:30 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] ide serverworks parenthesis fix
Date: Fri, 1 Dec 2006 15:33:04 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011533.05100.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This code is '#if 0'ed but hell ... while I'm at it I can fix it :-]

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/ide/pci/serverworks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/ide/pci/serverworks.c	2004-08-08 01:26:04.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/ide/pci/serverworks.c	2006-12-01 12:26:09.000000000 +0100
@@ -775,7 +775,7 @@ static void __init init_setup_csb6 (stru
 			return;
 	}
 #if 0
-	if ((IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB6) &&
+	if (IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB6) &&
              (!(PCI_FUNC(dev->devfn) & 1)))
 		d->autodma = AUTODMA;
 #endif


-- 
Regards,

	Mariusz Kozlowski
