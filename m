Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWBLHME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWBLHME (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 02:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWBLHME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 02:12:04 -0500
Received: from [71.39.78.203] ([71.39.78.203]:29710 "EHLO qwest.net")
	by vger.kernel.org with ESMTP id S932305AbWBLHMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 02:12:02 -0500
Date: Sun, 12 Feb 2006 00:17:05 -0700
From: Jesse Allen <jesse@qwest.net>
To: proski@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] orinoco: support smc2532w
Message-ID: <20060212071705.GA25751@sm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Allen <the3dfxdude@gmail.com>

The orinoco wireless driver can support the SMC 2532W-B PC Card, so add the id
for it.

Signed-off-by: Jesse Allen <the3dfxdude@gmail.com>
---

--- linux/drivers/net/wireless/orinoco_cs.c	2006-02-11 18:28:26.000000000 -0700
+++ linux-mod/drivers/net/wireless/orinoco_cs.c	2006-02-11 18:30:24.000000000 -0700
@@ -590,6 +590,7 @@
 	PCMCIA_DEVICE_PROD_ID12("PROXIM", "LAN PC CARD HARMONY 80211B", 0xc6536a5e, 0x090c3cd9),
 	PCMCIA_DEVICE_PROD_ID12("PROXIM", "LAN PCI CARD HARMONY 80211B", 0xc6536a5e, 0x9f494e26),
 	PCMCIA_DEVICE_PROD_ID12("SAMSUNG", "11Mbps WLAN Card", 0x43d74cb4, 0x579bd91b),
+	PCMCIA_DEVICE_PROD_ID12("SMC", "SMC2532W-B EliteConnect Wireless Adapter", 0xc4f8b18b, 0x196bd757),
 	PCMCIA_DEVICE_PROD_ID12("SMC", "SMC2632W", 0xc4f8b18b, 0x474a1f2a),
 	PCMCIA_DEVICE_PROD_ID12("Symbol Technologies", "LA4111 Spectrum24 Wireless LAN PC Card", 0x3f02b4d6, 0x3663cb0e),
 	PCMCIA_DEVICE_PROD_ID123("The Linksys Group, Inc.", "Instant Wireless Network PC Card", "ISL37300P", 0xa5f472c2, 0x590eb502, 0xc9049a39),
