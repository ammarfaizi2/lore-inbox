Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTFJT4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFJTy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:54:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52130 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262547AbTFJSh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709681203@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709682643@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1358, 2003/06/09 16:05:08-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/inia100.c


 drivers/scsi/inia100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/scsi/inia100.c b/drivers/scsi/inia100.c
--- a/drivers/scsi/inia100.c	Tue Jun 10 11:19:09 2003
+++ b/drivers/scsi/inia100.c	Tue Jun 10 11:19:09 2003
@@ -218,7 +218,7 @@
 	/*
 	 * PCI-bus probe.
 	 */
-	if (pci_present()) {
+	{
 		/*
 		 * Note: I removed the struct pci_device_list stuff since this
 		 * driver only cares about one device ID.  If that changes in

