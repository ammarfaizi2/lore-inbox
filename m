Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUAFBJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUAFBJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:09:40 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:27226 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266053AbUAFBJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:09:36 -0500
Date: Mon, 5 Jan 2004 17:09:24 -0800
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] allow SGI IOC4 chipset support
Message-ID: <20040106010924.GA21747@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'depends' directive for SGI IOC4 support is too restrictive.  Just
kill it altogether.

Jesse


===== drivers/ide/Kconfig 1.33 vs edited =====
--- 1.33/drivers/ide/Kconfig	Mon Dec 29 13:37:48 2003
+++ edited/drivers/ide/Kconfig	Mon Jan  5 17:07:25 2004
@@ -747,7 +747,6 @@
 
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset support"
-	depends on IA64_SGI_SN2
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
