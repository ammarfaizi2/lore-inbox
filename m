Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVAJRi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVAJRi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVAJRiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:38:02 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:50131 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262341AbVAJRVA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:00 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776592895@kroah.com>
Date: Mon, 10 Jan 2005 09:20:59 -0800
Message-Id: <1105377659183@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.17, 2004/12/22 08:51:13-08:00, greg@kroah.com

PCI: fix typo on previous pci_set_power_state() patch for hte sis900 driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/net/sis900.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2005-01-10 08:59:53 -08:00
+++ b/drivers/net/sis900.c	2005-01-10 08:59:53 -08:00
@@ -2238,7 +2238,7 @@
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
-	pci_set_power_state(pci_dev, PCI_D3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 	pci_save_state(pci_dev);
 
 	return 0;

