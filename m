Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUJHUN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUJHUN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJHUN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:13:59 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:47116 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S264386AbUJHUNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:13:34 -0400
Date: Fri, 8 Oct 2004 15:11:09 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org
Subject: [patch 2.6.9-rc3] 3c59x: style change in vortex_ethtool_ops declaration
Message-ID: <20041008151109.J14378@tuxdriver.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org
References: <20041008121307.C14378@tuxdriver.com> <4166E501.4000708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4166E501.4000708@pobox.com>; from jgarzik@pobox.com on Fri, Oct 08, 2004 at 03:05:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Style change suggested during patch review.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Jeff Garzik suggested this style change while reviewing my patch to
backport the 3c59x driver from 2.6 to 2.4.

 drivers/net/3c59x.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6/drivers/net/3c59x.c.orig
+++ linux-2.6/drivers/net/3c59x.c
@@ -2888,7 +2888,7 @@ static void vortex_get_drvinfo(struct ne
 }
 
 static struct ethtool_ops vortex_ethtool_ops = {
-	.get_drvinfo =		vortex_get_drvinfo,
+	.get_drvinfo		= vortex_get_drvinfo,
 };
 
 #ifdef CONFIG_PCI
