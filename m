Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270397AbUJUG0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270397AbUJUG0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270407AbUJTT1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:27:19 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:3340 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270321AbUJTTWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:22:38 -0400
Date: Wed, 20 Oct 2004 14:17:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@davemloft.net
Subject: [patch 2.6.9 4/11] b44: Add MODULE_VERSION
Message-ID: <20041020141753.G8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, davem@davemloft.net
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to b44 driver.

 drivers/net/b44.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/b44.c.orig
+++ linux-2.6.9/drivers/net/b44.c
@@ -79,6 +79,7 @@ MODULE_DESCRIPTION("Broadcom 4400 10/100
 MODULE_LICENSE("GPL");
 MODULE_PARM(b44_debug, "i");
 MODULE_PARM_DESC(b44_debug, "B44 bitmapped debugging message enable value");
+MODULE_VERSION(DRV_MODULE_VERSION);
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
