Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWIYS5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWIYS5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIYS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:57:47 -0400
Received: from server6.greatnet.de ([83.133.96.26]:5260 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751004AbWIYS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:57:46 -0400
Message-ID: <451826BE.2040201@nachtwindheim.de>
Date: Mon, 25 Sep 2006 20:58:06 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: jgarzik@pobox.com, Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heres a new version of the kerneldoc error in ata_piix.c
The old one which doesn't apply clean is in 2.6.18-mm1 and can be removed there if acked.

Greets,
Henne

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Fixes an error in kerneldoc of ata_piix.c.
This is the 2nd try, written for 2.6.18-git4
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

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


