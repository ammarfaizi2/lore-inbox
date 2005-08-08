Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVHHXxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVHHXxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVHHXxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:53:33 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:32897 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932297AbVHHXxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:53:33 -0400
Date: Tue, 9 Aug 2005 01:53:18 +0200
Message-Id: <200508082353.j78NrIS0027718@wscnet.wsc.cz>
Subject: [PATCH] Removes documentation about non-existent functions
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: <42F72D5B.3090005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes very old functions from pci docs, which aren't no longer in the
kernel.

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt
+++ b/Documentation/pci.txt
@@ -266,20 +266,6 @@ port an old driver to the new PCI interf
 in the kernel as they aren't compatible with hotplug or PCI domains or
 having sane locking.
 
-pcibios_present() and		Since ages, you don't need to test presence
-pci_present()			of PCI subsystem when trying to talk to it.
-				If it's not there, the list of PCI devices
-				is empty and all functions for searching for
-				devices just return NULL.
-pcibios_(read|write)_*		Superseded by their pci_(read|write)_*
-				counterparts.
-pcibios_find_*			Superseded by their pci_get_* counterparts.
-pci_for_each_dev()		Superseded by pci_get_device()
-pci_for_each_dev_reverse()	Superseded by pci_find_device_reverse()
-pci_for_each_bus()		Superseded by pci_find_next_bus()
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
 pci_find_slot()			Superseded by pci_get_slot()
-pcibios_find_class()		Superseded by pci_get_class()
-pci_find_class()		Superseded by pci_get_class()
-pci_(read|write)_*_nodev()	Superseded by pci_bus_(read|write)_*()
