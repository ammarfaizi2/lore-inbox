Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWI2Ldz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWI2Ldz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 07:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWI2Ldz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 07:33:55 -0400
Received: from server6.greatnet.de ([83.133.96.26]:57280 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932239AbWI2Ldz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 07:33:55 -0400
Message-ID: <451D04C3.3020205@nachtwindheim.de>
Date: Fri, 29 Sep 2006 13:34:27 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata: kerneldoc fix
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an kerneldoc error.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6/drivers/ata/libata-core.c	2006-09-28 09:00:47.000000000 +0200
+++ linux-2.6.18-git11/drivers/ata/libata-core.c	2006-09-29 13:10:44.000000000 +0200
@@ -5740,7 +5740,7 @@
 
 /**
  *	ata_scsi_release - SCSI layer callback hook for host unload
- *	@host: libata host to be unloaded
+ *	@shost: libata host to be unloaded
  *
  *	Performs all duties necessary to shut down a libata port...
  *	Kill port kthread, disable port, and release resources.


