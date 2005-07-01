Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263417AbVGASII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbVGASII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbVGASIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:08:07 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:18958 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S263417AbVGASHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:07:36 -0400
Date: Fri, 1 Jul 2005 14:07:28 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.13-rc1] pci: cleanup argument comments for pci_{save,restore}_state
Message-ID: <20050701180724.GA12653@tuxdriver.com>
Mail-Followup-To: linux-pci@atrey.karlin.mff.cuni.cz,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer arguments have been removed from pci_{save,restore}_state.
The comment blocks for those functions should reflect that.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/pci/pci.c |    6 ------
 1 files changed, 6 deletions(-)

--- ./drivers/pci/pci.c.orig	2005-06-27 17:20:48.000000000 -0400
+++ ./drivers/pci/pci.c	2005-06-27 17:21:13.000000000 -0400
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
-- 
John W. Linville
linville@tuxdriver.com
