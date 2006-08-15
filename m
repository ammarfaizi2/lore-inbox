Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWHOI5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWHOI5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWHOI5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:57:48 -0400
Received: from server6.greatnet.de ([83.133.96.26]:14555 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932248AbWHOI5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:57:47 -0400
Message-ID: <44E18C6C.2080902@nachtwindheim.de>
Date: Tue, 15 Aug 2006 10:57:16 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       kernel-janitors@lists.osdl.org
Subject: [PATCH] kerneldoc correction in pci-driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Removes an unused kerneldoc entry from pci_match_device and
put the others into correct order.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc4/drivers/pci/pci-driver.c	2006-06-18 03:49:35.000000000 +0200
+++ linux/drivers/pci/pci-driver.c	2006-08-11 13:59:39.000000000 +0200
@@ -139,9 +139,8 @@
 /**
  * pci_match_device - Tell if a PCI device structure has a matching
  *                    PCI device id structure
- * @ids: array of PCI device id structures to search in
- * @dev: the PCI device structure to match against
  * @drv: the PCI driver to match against
+ * @dev: the PCI device structure to match against
  *
  * Used by a driver to check whether a PCI device present in the
  * system is in its list of supported devices.  Returns the matching


