Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTFJVdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTFJVCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:02:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30370 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263897AbTFJShP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:15 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270966103@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709663468@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1343, 2003/06/09 15:51:45-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/tc35815.c


 drivers/net/tc35815.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/net/tc35815.c b/drivers/net/tc35815.c
--- a/drivers/net/tc35815.c	Tue Jun 10 11:20:33 2003
+++ b/drivers/net/tc35815.c	Tue Jun 10 11:20:33 2003
@@ -488,9 +488,6 @@
 		return -ENODEV;
 	called++;
 
-	if (!pci_present())
-		return -ENODEV;
-
 	if (pdev) {
 		unsigned int pci_memaddr;
 		unsigned int pci_irq_line;

