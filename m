Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270296AbUJTWaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270296AbUJTWaD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUJTTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:49:17 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:13836 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S266196AbUJTTej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:34:39 -0400
Date: Wed, 20 Oct 2004 14:29:54 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       ctindel@users.sourceforge.net, fubar@us.ibm.com
Subject: [patch 2.6.9 10/11] bonding: Add MODULE_VERSION
Message-ID: <20041020142954.M8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, ctindel@users.sourceforge.net, fubar@us.ibm.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to bonding driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/bonding/bond_main.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/bonding/bond_main.c.orig
+++ linux-2.6.9/drivers/net/bonding/bond_main.c
@@ -4700,6 +4700,7 @@ static void __exit bonding_exit(void)
 module_init(bonding_init);
 module_exit(bonding_exit);
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION(DRV_DESCRIPTION ", v" DRV_VERSION);
 MODULE_AUTHOR("Thomas Davis, tadavis@lbl.gov and many others");
 MODULE_SUPPORTED_DEVICE("most ethernet devices");
