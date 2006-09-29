Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWI2Mk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWI2Mk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWI2Mk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:40:58 -0400
Received: from server6.greatnet.de ([83.133.96.26]:62880 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964876AbWI2Mk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:40:57 -0400
Message-ID: <451D1476.2080506@nachtwindheim.de>
Date: Fri, 29 Sep 2006 14:41:26 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2nd try] libata: fix kerneldoc in libata_scsi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an kerneldoc error.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---
Sorry! :)
--- linux-2.6/drivers/ata/libata-scsi.c	2006-09-25 09:27:46.000000000 +0200
+++ linux-2.6.18-git11/drivers/ata/libata-scsi.c	2006-09-29 13:17:24.000000000 +0200
@@ -3174,7 +3174,7 @@
 
 /**
  *	ata_sas_port_alloc - Allocate port for a SAS attached SATA device
- *	@pdev: PCI device that the scsi device is attached to
+ *	@host: ata_host device that the scsi device is attached to
  *	@port_info: Information from low-level host driver
  *	@shost: SCSI host that the scsi device is attached to
  *



