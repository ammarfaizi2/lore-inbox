Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWIYUA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWIYUA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIYUA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:00:26 -0400
Received: from server6.greatnet.de ([83.133.96.26]:48590 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750743AbWIYUAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:00:25 -0400
Message-ID: <4518356E.8030108@nachtwindheim.de>
Date: Mon, 25 Sep 2006 22:00:46 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 3rd try] ata-piix: fixes kerneldoc error
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an error in kerneldoc of ata_piix.c.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---
Heres a new version of the kerneldoc error in ata_piix.c
This is the 3rd try, written for 2.6.18-git4.
The old one which doesn't apply clean is in 2.6.18-mm1 and can be removed there if acked.

Greets,
Henne

--- linux-2.6/drivers/ata/ata_piix.c	2006-09-25 09:27:46.000000000 +0200
+++ linux-2.6.18-git4/drivers/ata/ata_piix.c	2006-09-25 20:47:32.000000000 +0200
@@ -851,7 +851,7 @@
  *	@ap: Port whose timings we are configuring
  *	@adev: Drive in question
  *	@udma: udma mode, 0 - 6
- *	@is_ich: set if the chip is an ICH device
+ *	@isich: set if the chip is an ICH device
  *
  *	Set UDMA mode for device, in host controller PCI config space.
  *




