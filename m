Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVDBAvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVDBAvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVDBAEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:04:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:31452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262930AbVDAXsO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:14 -0500
Cc: willy@parisc-linux.org
Subject: [PATCH] PCI: 80 column lines
In-Reply-To: <11123992711809@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:51 -0800
Message-Id: <11123992711877@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.11, 2005/03/17 14:31:08-08:00, willy@parisc-linux.org

[PATCH] PCI: 80 column lines

PCI 80-column lines

A couple of lines are >80 columns

Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/quirks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-04-01 15:36:44 -08:00
+++ b/drivers/pci/quirks.c	2005-04-01 15:36:44 -08:00
@@ -541,7 +541,7 @@
 		return;
 	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy );
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_cardbus_legacy);
 
 /*
  * Following the PCI ordering rules is optional on the AMD762. I'm not
@@ -659,7 +659,7 @@
        printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
               first_bar, last_bar, pci_name(dev));
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,             PCI_ANY_ID,                     quirk_ide_bases );
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_ide_bases);
 
 /*
  *	Ensure C0 rev restreaming is off. This is normally done by

