Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270052AbUJSXBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270052AbUJSXBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270186AbUJSWy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:54:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:60809 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269963AbUJSWqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:20 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257332250@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <10982257332675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.13, 2004/10/06 11:49:31-07:00, hch@lst.de

[PATCH] PCI: mark proc_bus_pci_dir static

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/proc.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	2004-10-19 15:26:49 -07:00
+++ b/drivers/pci/proc.c	2004-10-19 15:26:49 -07:00
@@ -379,7 +379,7 @@
 	.show	= show_device
 };
 
-struct proc_dir_entry *proc_bus_pci_dir;
+static struct proc_dir_entry *proc_bus_pci_dir;
 
 int pci_proc_attach_device(struct pci_dev *dev)
 {
@@ -612,6 +612,5 @@
 EXPORT_SYMBOL(pci_proc_attach_device);
 EXPORT_SYMBOL(pci_proc_attach_bus);
 EXPORT_SYMBOL(pci_proc_detach_bus);
-EXPORT_SYMBOL(proc_bus_pci_dir);
 #endif
 

