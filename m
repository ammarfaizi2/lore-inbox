Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270424AbUJTTbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270424AbUJTTbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270423AbUJTT3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:29:03 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:524 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270270AbUJTTUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:20:37 -0400
Date: Wed, 20 Oct 2004 14:15:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [patch 2.6.9 2/11] e100: Add MODULE_VERSION
Message-ID: <20041020141552.E8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to e100 driver.

 drivers/net/e100.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/e100.c.orig
+++ linux-2.6.9/drivers/net/e100.c
@@ -166,6 +166,7 @@
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 static int debug = 3;
 module_param(debug, int, 0);
