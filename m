Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUBIX6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbUBIX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:56:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:61372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265431AbUBIXWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:37 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <1076368940408@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:20 -0800
Message-Id: <1076368940145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.13, 2004/02/03 16:49:05-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Coding style fixes for drivers/pci/hotplug.c


 drivers/pci/hotplug.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Mon Feb  9 14:58:56 2004
+++ b/drivers/pci/hotplug.c	Mon Feb  9 14:58:56 2004
@@ -116,7 +116,7 @@
 	}
 
 	bus = wrapped_dev->dev->subordinate;
-	if(bus) {
+	if (bus) {
 		memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
 		wrapped_bus.bus = bus;
 
@@ -130,8 +130,8 @@
  * Every bus and every function is presented to a custom
  * function that can act upon it.
  */
-int pci_visit_dev (struct pci_visit *fn, struct pci_dev_wrapped *wrapped_dev,
-		   struct pci_bus_wrapped *wrapped_parent)
+int pci_visit_dev(struct pci_visit *fn, struct pci_dev_wrapped *wrapped_dev,
+		  struct pci_bus_wrapped *wrapped_parent)
 {
 	struct pci_dev* dev = wrapped_dev ? wrapped_dev->dev : NULL;
 	int result = 0;

