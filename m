Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWIDMdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWIDMdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWIDMdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:33:18 -0400
Received: from server6.greatnet.de ([83.133.96.26]:30167 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964853AbWIDMdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:33:18 -0400
Message-ID: <44FC1D37.5070305@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:33:59 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] kerneldoc error on ata_piix.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Fixes an kerneldoc error in ata_piix.c.
This patch is for mm only, since the move of the ata drivers.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc4-mm3/drivers/ata/ata_piix.c	2006-09-13 02:16:14.305171136 +0200
+++ linux/drivers/ata/ata_piix.c	2006-09-13 02:17:49.731664104 +0200
@@ -846,7 +846,7 @@
  *	@ap: Port whose timings we are configuring
  *	@adev: Drive in question
  *	@udma: udma mode, 0 - 6
- *	@is_ich: set if the chip is an ICH device
+ *	@isich: set if the chip is an ICH device
  *
  *	Set UDMA mode for device, in host controller PCI config space.
  *



-- 
VGER BF report: U 0.510942
