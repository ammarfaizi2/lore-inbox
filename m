Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVIJMVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVIJMVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIJMVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:15 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:40839 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750779AbVIJMVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:13 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL92n017254@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 7/10] drivers/char: pci_find_device remove (drivers/char/sx.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 sx.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2434,7 +2434,7 @@ static int __init sx_init(void) 
 	}
 
 #ifdef CONFIG_PCI
-	while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
+	while ((pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX, 
 					PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
 					      pdev))) {
 		if (pci_enable_device(pdev))
