Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWCDMOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWCDMOy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWCDMOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20496 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751808AbWCDMOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:32 -0500
Date: Sat, 4 Mar 2006 13:14:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: yi.zhu@intel.com, jketreno@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/ipw2200.c: make ipw_qos_current_mode() static
Message-ID: <20060304121431.GN9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global function ipw_qos_current_mode() 
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/drivers/net/wireless/ipw2200.c.old	2006-03-03 17:49:37.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/net/wireless/ipw2200.c	2006-03-03 17:50:00.000000000 +0100
@@ -6566,7 +6566,7 @@
 * get the modulation type of the current network or
 * the card current mode
 */
-u8 ipw_qos_current_mode(struct ipw_priv * priv)
+static u8 ipw_qos_current_mode(struct ipw_priv * priv)
 {
 	u8 mode = 0;
 

