Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTEVVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTEVVwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:52:03 -0400
Received: from granite.he.net ([216.218.226.66]:43275 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263319AbTEVVvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:51:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10536411603009@kroah.com>
Subject: Re: [PATCH] PCI changes for 2.5.69
In-Reply-To: <10536411604177@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:06:00 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1063.1.3, 2003/05/05 17:29:47-05:00, Matt_Domsch@dell.com

pci.h whitespace cleanups


 include/linux/pci.h |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu May 22 14:51:42 2003
+++ b/include/linux/pci.h	Thu May 22 14:51:42 2003
@@ -514,8 +514,6 @@
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
 
 
-
-
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -777,8 +775,6 @@
 	for(dev = NULL; 0; )
 
 #define	isa_bridge	((struct pci_dev *)NULL)
-
-
 
 #else
 

