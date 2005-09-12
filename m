Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVILO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVILO6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVILO6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:18 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:18695 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751146AbVILO6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:58:08 -0400
Date: Mon, 12 Sep 2005 10:49:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       cramerj@intel.com
Subject: [patch 2.6.13] e1000: whitespace cleanup in e1000_ethtool_ops
Message-ID: <09122005104900.729@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix-up some whitespace inconsistencies in e1000_ethtool_ops.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/e1000/e1000_ethtool.c |   44 +++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
--- a/drivers/net/e1000/e1000_ethtool.c
+++ b/drivers/net/e1000/e1000_ethtool.c
@@ -1705,22 +1705,22 @@ e1000_get_strings(struct net_device *net
 }
 
 struct ethtool_ops e1000_ethtool_ops = {
-	.get_settings           = e1000_get_settings,
-	.set_settings           = e1000_set_settings,
-	.get_drvinfo            = e1000_get_drvinfo,
-	.get_regs_len           = e1000_get_regs_len,
-	.get_regs               = e1000_get_regs,
-	.get_wol                = e1000_get_wol,
-	.set_wol                = e1000_set_wol,
-	.get_msglevel	        = e1000_get_msglevel,
-	.set_msglevel	        = e1000_set_msglevel,
-	.nway_reset             = e1000_nway_reset,
-	.get_link               = ethtool_op_get_link,
-	.get_eeprom_len         = e1000_get_eeprom_len,
-	.get_eeprom             = e1000_get_eeprom,
-	.set_eeprom             = e1000_set_eeprom,
-	.get_ringparam          = e1000_get_ringparam,
-	.set_ringparam          = e1000_set_ringparam,
+	.get_settings		= e1000_get_settings,
+	.set_settings		= e1000_set_settings,
+	.get_drvinfo		= e1000_get_drvinfo,
+	.get_regs_len		= e1000_get_regs_len,
+	.get_regs		= e1000_get_regs,
+	.get_wol		= e1000_get_wol,
+	.set_wol		= e1000_set_wol,
+	.get_msglevel		= e1000_get_msglevel,
+	.set_msglevel		= e1000_set_msglevel,
+	.nway_reset		= e1000_nway_reset,
+	.get_link		= ethtool_op_get_link,
+	.get_eeprom_len		= e1000_get_eeprom_len,
+	.get_eeprom		= e1000_get_eeprom,
+	.set_eeprom		= e1000_set_eeprom,
+	.get_ringparam		= e1000_get_ringparam,
+	.set_ringparam		= e1000_set_ringparam,
 	.get_pauseparam		= e1000_get_pauseparam,
 	.set_pauseparam		= e1000_set_pauseparam,
 	.get_rx_csum		= e1000_get_rx_csum,
@@ -1733,12 +1733,12 @@ struct ethtool_ops e1000_ethtool_ops = {
 	.get_tso		= ethtool_op_get_tso,
 	.set_tso		= e1000_set_tso,
 #endif
-	.self_test_count        = e1000_diag_test_count,
-	.self_test              = e1000_diag_test,
-	.get_strings            = e1000_get_strings,
-	.phys_id                = e1000_phys_id,
-	.get_stats_count        = e1000_get_stats_count,
-	.get_ethtool_stats      = e1000_get_ethtool_stats,
+	.self_test_count	= e1000_diag_test_count,
+	.self_test		= e1000_diag_test,
+	.get_strings		= e1000_get_strings,
+	.phys_id		= e1000_phys_id,
+	.get_stats_count	= e1000_get_stats_count,
+	.get_ethtool_stats	= e1000_get_ethtool_stats,
 	.get_perm_addr		= ethtool_op_get_perm_addr,
 };
 
