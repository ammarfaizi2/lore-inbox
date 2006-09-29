Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWI2Lff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWI2Lff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 07:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWI2Lff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 07:35:35 -0400
Received: from server6.greatnet.de ([83.133.96.26]:62144 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932280AbWI2Lfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 07:35:34 -0400
Message-ID: <451D0525.80606@nachtwindheim.de>
Date: Fri, 29 Sep 2006 13:36:05 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata: fix kerneldoc in libata_scsi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an kerneldoc error.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6/drivers/ata/libata-scsi.c	2006-09-25 09:27:46.000000000 +0200
+++ linux-2.6.18-git11/drivers/ata/libata-scsi.c	2006-09-29 13:17:24.000000000 +0200
@@ -3174,7 +3174,7 @@
 
 /**
  *	ata_sas_port_alloc - Allocate port for a SAS attached SATA device
- *	@pdev: PCI device that the scsi device is attached to
+ *	@shost: ata_host device that the scsi device is attached to
  *	@port_info: Information from low-level host driver
  *	@shost: SCSI host that the scsi device is attached to
  *


