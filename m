Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWCTEkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWCTEkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWCTEkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:40:11 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:51471 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751468AbWCTEkB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:40:01 -0500
Date: Mon, 20 Mar 2006 04:39:44 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       netdev@vger.kernel.org
Subject: [PATCH 4/12] [NET] Improve description of MV643XX_ETH
Message-ID: <20060320043944.GD20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly improve the wording of the description of MV643XX_ETH
in Kconfig.  This difference was found between the mainline and
linux-mips kernel trees.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/net/Kconfig	2006-03-13 18:55:59.000000000 +0000
+++ mips.git/drivers/net/Kconfig	2006-03-13 18:43:52.000000000 +0000
@@ -2197,8 +2213,8 @@
 	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3 || PPC_MULTIPLATFORM
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
-	  chipset which is used in the Momenco Ocelot C and Jaguar ATX and
-	  Pegasos II, amongst other PPC and MIPS boards.
+	  chipset which is used in the Momenco Ocelot C Ocelot, Jaguar ATX
+	  and Pegasos II, amongst other PPC and MIPS boards.
 
 config MV643XX_ETH_0
 	bool "MV-643XX Port 0"

-- 
Martin Michlmayr
http://www.cyrius.com/
