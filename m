Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTFJT4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFJTyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:54:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34176 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264009AbTFJSh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709673929@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270967992@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1352, 2003/06/09 16:02:02-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/aic7xxx_old.c


 drivers/scsi/aic7xxx_old.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c	Tue Jun 10 11:19:42 2003
+++ b/drivers/scsi/aic7xxx_old.c	Tue Jun 10 11:19:42 2003
@@ -9033,7 +9033,6 @@
   /*
    * PCI-bus probe.
    */
-  if (pci_present())
   {
     struct
     {
@@ -9692,7 +9691,7 @@
         }
       } /* while(pdev=....) */
     } /* for PCI_DEVICES */
-  } /* PCI BIOS present */
+  }
 #endif /* CONFIG_PCI */
 
 #if defined(__i386__) || defined(__alpha__)

