Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVILPED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVILPED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVILO6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:31 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:15111 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751321AbVILO55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:57:57 -0400
Date: Mon, 12 Sep 2005 10:48:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.13 3/3] 3c59x: fix some grammar in module parameter descriptions
Message-ID: <09122005104853.31652@bilbo.tuxdriver.com>
In-Reply-To: <09122005104853.31588@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct several (apparently cut & paste) grammatical typos in module
parameter descriptions. They seem to have originated as copies of
the description for "global_options".

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/3c59x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -943,18 +943,18 @@ MODULE_PARM_DESC(debug, "3c59x debug lev
 MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
 MODULE_PARM_DESC(global_options, "3c59x: same as options, but applies to all NICs if options is unset");
 MODULE_PARM_DESC(full_duplex, "3c59x full duplex setting(s) (1)");
-MODULE_PARM_DESC(global_full_duplex, "3c59x: same as full_duplex, but applies to all NICs if options is unset");
+MODULE_PARM_DESC(global_full_duplex, "3c59x: same as full_duplex, but applies to all NICs if full_duplex is unset");
 MODULE_PARM_DESC(hw_checksums, "3c59x Hardware checksum checking by adapter(s) (0-1)");
 MODULE_PARM_DESC(flow_ctrl, "3c59x 802.3x flow control usage (PAUSE only) (0-1)");
 MODULE_PARM_DESC(enable_wol, "3c59x: Turn on Wake-on-LAN for adapter(s) (0-1)");
-MODULE_PARM_DESC(global_enable_wol, "3c59x: same as enable_wol, but applies to all NICs if options is unset");
+MODULE_PARM_DESC(global_enable_wol, "3c59x: same as enable_wol, but applies to all NICs if enable_wol is unset");
 MODULE_PARM_DESC(rx_copybreak, "3c59x copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "3c59x maximum events handled per interrupt");
 MODULE_PARM_DESC(compaq_ioaddr, "3c59x PCI I/O base address (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(compaq_irq, "3c59x PCI IRQ number (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(compaq_device_id, "3c59x PCI device ID (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(watchdog, "3c59x transmit timeout in milliseconds");
-MODULE_PARM_DESC(global_use_mmio, "3c59x: same as use_mmio, but applies to all NICs if options is unset");
+MODULE_PARM_DESC(global_use_mmio, "3c59x: same as use_mmio, but applies to all NICs if use_mmio is unset");
 MODULE_PARM_DESC(use_mmio, "3c59x: use memory-mapped PCI I/O resource (0-1)");
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
