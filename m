Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUJTTwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUJTTwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270464AbUJTTtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:49:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:11788 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269182AbUJTTdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:33:43 -0400
Date: Wed, 20 Oct 2004 14:28:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       romieu@fr.zoreil.com
Subject: [patch 2.6.9 9/11] r8169: Add MODULE_VERSION
Message-ID: <20041020142858.L8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, romieu@fr.zoreil.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to r8169 driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/r8169.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/r8169.c.orig
+++ linux-2.6.9/drivers/net/r8169.c
@@ -362,6 +362,7 @@ MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(use_dac, "i");
 MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(RTL8169_VERSION);
 
 static int rtl8169_open(struct net_device *dev);
 static int rtl8169_start_xmit(struct sk_buff *skb, struct net_device *dev);
