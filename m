Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUJUGcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUJUGcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJUG2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:28:21 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:18700 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270470AbUJTTj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:39:29 -0400
Date: Wed, 20 Oct 2004 14:34:44 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [patch 2.6.9 2/11] e100: Add MODULE_VERSION
Message-ID: <20041020143444.P8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com
References: <20041020141146.C8775@tuxdriver.com> <20041020141552.E8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141552.E8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:15:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to e100 driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/e100.c |    1 +
 1 files changed, 1 insertion(+)

Re-send -- forgot Signed-off-by line...

--- linux-2.6.9/drivers/net/e100.c.orig
+++ linux-2.6.9/drivers/net/e100.c
@@ -166,6 +166,7 @@
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 static int debug = 3;
 module_param(debug, int, 0);
