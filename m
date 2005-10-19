Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVJSBeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVJSBeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVJSBeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:34:08 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:3844 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932453AbVJSBdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:49 -0400
Date: Tue, 18 Oct 2005 21:31:03 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       mallikarjuna.chilakala@intel.com
Subject: [patch 2.6.14-rc4] e1000: Driver version, white space, comments, device id & other
Message-ID: <10182005213103.13099@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mallikarjuna R Chilakala <mallikarjuna.chilakala@intel.com>

Driver version, white space, comments, device id & other

Originally posted on 8/31 (and perhaps before)...I think it has not
been committed because the patch from that posting was damaged.  I'm
reposting to make sure it gets in... :-)

Signed-off-by: Mallikarjuna R Chilakala <mallikarjuna.chilakala@intel.com>
Signed-off-by: Ganesh Venkatesan <ganesh.venkatesan@intel.com>
Signed-off-by: John Ronciak <john.ronciak@intel.com>

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/e1000/e1000_main.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -43,7 +43,7 @@ char e1000_driver_string[] = "Intel(R) P
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-#define DRV_VERSION		"6.0.60-k2"DRIVERNAPI
+#define DRV_VERSION "6.1.16-k2"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
 char e1000_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
 
@@ -80,6 +80,9 @@ static struct pci_device_id e1000_pci_tb
 	INTEL_E1000_ETHERNET_DEVICE(0x1026),
 	INTEL_E1000_ETHERNET_DEVICE(0x1027),
 	INTEL_E1000_ETHERNET_DEVICE(0x1028),
+	INTEL_E1000_ETHERNET_DEVICE(0x105E),
+	INTEL_E1000_ETHERNET_DEVICE(0x105F),
+	INTEL_E1000_ETHERNET_DEVICE(0x1060),
 	INTEL_E1000_ETHERNET_DEVICE(0x1075),
 	INTEL_E1000_ETHERNET_DEVICE(0x1076),
 	INTEL_E1000_ETHERNET_DEVICE(0x1077),
@@ -88,10 +91,13 @@ static struct pci_device_id e1000_pci_tb
 	INTEL_E1000_ETHERNET_DEVICE(0x107A),
 	INTEL_E1000_ETHERNET_DEVICE(0x107B),
 	INTEL_E1000_ETHERNET_DEVICE(0x107C),
+	INTEL_E1000_ETHERNET_DEVICE(0x107D),
+	INTEL_E1000_ETHERNET_DEVICE(0x107E),
+	INTEL_E1000_ETHERNET_DEVICE(0x107F),
 	INTEL_E1000_ETHERNET_DEVICE(0x108A),
 	INTEL_E1000_ETHERNET_DEVICE(0x108B),
 	INTEL_E1000_ETHERNET_DEVICE(0x108C),
-	INTEL_E1000_ETHERNET_DEVICE(0x1099),
+	INTEL_E1000_ETHERNET_DEVICE(0x109A),
 	/* required last entry */
 	{0,}
 };
@@ -366,8 +372,7 @@ e1000_down(struct e1000_adapter *adapter
 	e1000_clean_tx_ring(adapter);
 	e1000_clean_rx_ring(adapter);
 
-	/* If WoL is not enabled
-	 * and management mode is not IAMT
+	/* If WoL is not enabled and management mode is not IAMT
 	 * Power down the PHY so no link is implied when interface is down */
 	if(!adapter->wol && adapter->hw.mac_type >= e1000_82540 &&
 	   adapter->hw.media_type == e1000_media_type_copper &&
