Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWEJICj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWEJICj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWEJICi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:02:38 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:12743 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S932301AbWEJICh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:02:37 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe_Zeisberger@digi.com
X-Msg-Ref: server-16.tower-29.messagelabs.com!1147248156!26409210!1
X-StarScan-Version: 5.5.9.1; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Date: Wed, 10 May 2006 10:02:06 +0200
From: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Fleming <afleming@freescale.com>
Subject: [PATCH] Fix phy id for LXT971A/LXT972A
Message-ID: <20060510080205.GA10494@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA22B12D-5910-4EE9-A351-6AB770330AFC@freescale.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 10 May 2006 08:02:33.0881 (UTC) FILETIME=[180EA090:01C67408]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
Acked-by: Andy Fleming <afleming@freescale.com>

---

 drivers/net/phy/lxt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

4406e908ff6896400290bb4ae1337c8cfa589f15
diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index bef79e4..4c66fac 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -137,9 +137,9 @@ static struct phy_driver lxt970_driver =
 };
 
 static struct phy_driver lxt971_driver = {
-	.phy_id		= 0x0001378e,
+	.phy_id		= 0x001378e0,
 	.name		= "LXT971",
-	.phy_id_mask	= 0x0fffffff,
+	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_aneg	= genphy_config_aneg,
-- 
1.3.2.g25a9


-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com
