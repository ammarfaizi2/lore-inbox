Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFJTJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFJSmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:42:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26269 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264052AbTFJShd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:33 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709641345@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709643700@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318, 2003/06/09 15:29:58-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/atm/ambassador.c


 drivers/atm/ambassador.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
--- a/drivers/atm/ambassador.c	Tue Jun 10 11:22:32 2003
+++ b/drivers/atm/ambassador.c	Tue Jun 10 11:22:32 2003
@@ -2509,9 +2509,6 @@
   
   PRINTD (DBG_FLOW, "amb_probe");
   
-  if (!pci_present())
-    return 0;
-  
   devs = 0;
   pci_dev = NULL;
   while ((pci_dev = pci_find_device

