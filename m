Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVC0TJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVC0TJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVC0TJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:09:33 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:38072 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261459AbVC0TJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:09:11 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] typo fix in drivers/scsi/sata_svw.c
Date: Sun, 27 Mar 2005 15:56:02 +0200
User-Agent: KMail/1.8
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271556.02600.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing brace.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11/drivers/scsi/sata_svw.c	2005-03-21 11:41:58.000000000 +0100
+++ linux-2.6.12-rc1/drivers/scsi/sata_svw.c	2005-03-27 15:50:38.000000000 +0200
@@ -395,7 +395,7 @@
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
-	 * set by the firmware on the machines I had access to
+	 * set by the firmware on the machines I had access to)
 	 */
 	writel(readl(mmio_base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
 	       mmio_base + K2_SATA_SICR1_OFFSET);
