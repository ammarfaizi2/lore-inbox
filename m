Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269996AbUJUGin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269996AbUJUGin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270690AbUJUG2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:28:02 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:8716 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269170AbUJTT2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:28:42 -0400
Date: Wed, 20 Oct 2004 14:23:57 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch 2.6.9 7/11] 8139too: Add MODULE_VERSION
Message-ID: <20041020142357.J8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to 8139too driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/8139too.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/8139too.c.8139too
+++ linux-2.6.9/drivers/net/8139too.c
@@ -598,6 +598,7 @@ struct rtl8139_private {
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(MAX_UNITS) "i");
