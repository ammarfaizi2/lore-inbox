Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVGAVD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVGAVD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVGAU7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:59:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:52961 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262765AbVGAUtl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:41 -0400
Cc: linville@tuxdriver.com
Subject: [PATCH] pci: cleanup argument comments for pci_{save,restore}_state
In-Reply-To: <11202509122830@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:32 -0700
Message-Id: <11202509123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pci: cleanup argument comments for pci_{save,restore}_state

The buffer arguments have been removed from pci_{save,restore}_state.
The comment blocks for those functions should reflect that.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5848f23d811acc1cb6c19a12e1341e0640a85d0e
tree 03281e4a15e538ffb18ab1f3f02a1b61736a8c84
parent c6e21e1683c2508a2b23588e1fc2e7bf6fc2549e
author John W. Linville <linville@tuxdriver.com> Fri, 01 Jul 2005 14:07:28 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:52 -0700

 drivers/pci/pci.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -334,10 +334,6 @@ EXPORT_SYMBOL(pci_choose_state);
 /**
  * pci_save_state - save the PCI configuration space of a device before suspending
  * @dev: - PCI device that we're dealing with
- * @buffer: - buffer to hold config space context
- *
- * @buffer must be large enough to hold the entire PCI 2.2 config space 
- * (>= 64 bytes).
  */
 int
 pci_save_state(struct pci_dev *dev)
@@ -352,8 +348,6 @@ pci_save_state(struct pci_dev *dev)
 /** 
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: - PCI device that we're dealing with
- * @buffer: - saved PCI config space
- *
  */
 int 
 pci_restore_state(struct pci_dev *dev)

