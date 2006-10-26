Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWJZCTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWJZCTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWJZCTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:07 -0400
Received: from isilmar.linta.de ([213.239.214.66]:29407 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965280AbWJZCTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:04 -0400
Date: Wed, 25 Oct 2006 22:17:09 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, noodles@earth.li
Subject: [RFC PATCH 9/11] Export soc_common_drv_pcmcia_remove to allow modular PCMCIA
Message-ID: <20061026021709.GJ20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, noodles@earth.li
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan McDowell <noodles@earth.li>
Date: Fri, 20 Oct 2006 14:44:19 -0700
Subject: [PATCH] Export soc_common_drv_pcmcia_remove to allow modular PCMCIA.

Allow a modular sa1100_cs.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/soc_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 3627e52..e433704 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -824,3 +824,4 @@ int soc_common_drv_pcmcia_remove(struct 
 
 	return 0;
 }
+EXPORT_SYMBOL(soc_common_drv_pcmcia_remove);
-- 
1.4.3

