Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270351AbUJUGtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270351AbUJUGtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270686AbUJUG0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:26:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:7180 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270395AbUJTT0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:26:19 -0400
Date: Wed, 20 Oct 2004 14:21:32 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       akpm@osdl.org
Subject: [patch 2.6.9 6/11] 3c59x: Add MODULE_VERSION
Message-ID: <20041020142132.I8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, akpm@osdl.org
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to 3c59x driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/3c59x.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/3c59x.c.orig
+++ linux-2.6.9/drivers/net/3c59x.c
@@ -277,6 +277,7 @@ MODULE_AUTHOR("Donald Becker <becker@scy
 MODULE_DESCRIPTION("3Com 3c59x/3c9xx ethernet driver "
 					DRV_VERSION " " DRV_RELDATE);
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 MODULE_PARM(debug, "i");
 MODULE_PARM(global_options, "i");
