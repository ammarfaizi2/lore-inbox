Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUJTTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUJTTwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUJTTt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:49:28 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:11020 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270450AbUJTTcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:32:41 -0400
Date: Wed, 20 Oct 2004 14:27:56 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch 2.6.9 8/11] ns83820: Add MODULE_VERSION
Message-ID: <20041020142756.K8775@tuxdriver.com>
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

Add MODULE_VERSION to ns83820 driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/ns83820.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.9/drivers/net/ns83820.c.ns83820
+++ linux-2.6.9/drivers/net/ns83820.c
@@ -2106,6 +2106,7 @@ static void __exit ns83820_exit(void)
 MODULE_AUTHOR("Benjamin LaHaise <bcrl@redhat.com>");
 MODULE_DESCRIPTION("National Semiconductor DP83820 10/100/1000 driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
 
 MODULE_DEVICE_TABLE(pci, ns83820_pci_tbl);
 
