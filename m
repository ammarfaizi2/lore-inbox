Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTFJT5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFJT4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:56:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32128 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263980AbTFJShY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:24 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709671265@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709673929@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1353, 2003/06/09 16:02:30-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/atp870u.c


 drivers/scsi/atp870u.c |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
--- a/drivers/scsi/atp870u.c	Tue Jun 10 11:19:37 2003
+++ b/drivers/scsi/atp870u.c	Tue Jun 10 11:19:37 2003
@@ -2321,10 +2321,6 @@
 	};
 
 	printk(KERN_INFO "aec671x_detect: \n");
-	if (!pci_present()) {
-		printk(KERN_INFO "   NO PCI SUPPORT.\n");
-		return count;
-	}
 	tpnt->proc_name = "atp870u";
 
 	h = 0;

