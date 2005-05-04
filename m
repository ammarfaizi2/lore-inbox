Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVEDHIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVEDHIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVEDHG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:06:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:5349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262052AbVEDHCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:25 -0400
Cc: matthew@wil.cx
Subject: [PATCH] PCI: update PCI documentation for pci_get_slot() depreciation
In-Reply-To: <11151901361631@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:17 -0700
Message-Id: <11151901373923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: update PCI documentation for pci_get_slot() depreciation

pci_find_slot() doesn't work on multiple-domain boxes so pci_get_slot()
should be used instead.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a3ea7fbac12fdb2d70c90bb36f81afa3c66e18f4
tree be9655df6ea3a0cf2c53a0eb8ff8870962d46871
parent ceb43744cd48a20212e2179e0c7ff2f450a3c97e
author Matthew Wilcox <matthew@wil.cx> 1112119728 +0100
committer Greg KH <gregkh@suse.de> 1115189114 -0700

Index: Documentation/pci.txt
===================================================================
--- f9554643bc9d70fe761840a603adce393c0e9f08/Documentation/pci.txt  (mode:100644 sha1:67514bf87ccde2db27f138fc52348899bf8ec351)
+++ be9655df6ea3a0cf2c53a0eb8ff8870962d46871/Documentation/pci.txt  (mode:100644 sha1:62b1dc5d97e2e90523e8010b93054f81ef3ffe58)
@@ -279,6 +279,7 @@
 pci_for_each_bus()		Superseded by pci_find_next_bus()
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
+pci_find_slot()			Superseded by pci_get_slot()
 pcibios_find_class()		Superseded by pci_get_class()
 pci_find_class()		Superseded by pci_get_class()
 pci_(read|write)_*_nodev()	Superseded by pci_bus_(read|write)_*()

