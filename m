Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270407AbUJUG0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270407AbUJUG0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270419AbUJTT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:28:31 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:62987 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270226AbUJTTT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:19:28 -0400
Date: Wed, 20 Oct 2004 14:14:40 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@davemloft.net
Subject: [patch 2.6.9 1/11] tg3: Add MODULE_VERSION
Message-ID: <20041020141440.D8775@tuxdriver.com>
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

Add MODULE_VERSION to tg3 driver.

 drivers/net/tg3.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/tg3.c.orig
+++ linux-2.6.9/drivers/net/tg3.c
@@ -143,6 +143,7 @@ MODULE_DESCRIPTION("Broadcom Tigon3 ethe
 MODULE_LICENSE("GPL");
 MODULE_PARM(tg3_debug, "i");
 MODULE_PARM_DESC(tg3_debug, "Tigon3 bitmapped debugging message enable value");
+MODULE_VERSION(DRV_MODULE_VERSION);
 
 static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
 
