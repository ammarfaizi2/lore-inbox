Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTFJT3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTFJSjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:39:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59776 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264085AbTFJShl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:41 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709683613@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709683321@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1365, 2003/06/09 16:09:16-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/sym53c8xx_2/sym_glue.c


 drivers/scsi/sym53c8xx_2/sym_glue.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c	Tue Jun 10 11:18:34 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c	Tue Jun 10 11:18:34 2003
@@ -2694,12 +2694,6 @@
 #endif
 
 	/*
-	 *  PCI is required.
-	 */
-	if (!pci_present())
-		return 0;
-
-	/*
 	 *    Initialize driver general stuff.
 	 */
 #ifdef SYM_LINUX_BOOT_COMMAND_LINE_SUPPORT

