Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUERB7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUERB7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUERB7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:59:33 -0400
Received: from adsl-67-65-232-1.dsl.lgvwtx.swbell.net ([67.65.232.1]:24961
	"HELO rooker.dyndns.org") by vger.kernel.org with SMTP
	id S262382AbUERB7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:59:22 -0400
Date: 17 May 2004 20:59:49 -0500
Message-ID: <20040518015949.28830.qmail@rooker.dyndns.org>
From: pixl@rooker.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: [patch] help for aacraid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.6/drivers/scsi/Kconfig.old        2004-05-17 20:51:21.395075352 -0500
+++ linux-2.6.6/drivers/scsi/Kconfig    2004-05-17 20:55:52.074925760 -0500
@@ -315,6 +315,13 @@
 config SCSI_AACRAID
        tristate "Adaptec AACRAID support (EXPERIMENTAL)"
        depends on EXPERIMENTAL && SCSI && PCI
+       ---help---
+         This driver supports the Dell PERC2, 2/Si, 3/Si, 3/Di,
+         HP NetRAID-4M SCSI and the Adaptec Advanced Raid Products
+         <http://www.adaptec.com/products/solutions/raid.html>
+
+         To compile this driver as a module, choose M here: the module
+         will be called aacraid.

 source "drivers/scsi/aic7xxx/Kconfig.aic7xxx"

