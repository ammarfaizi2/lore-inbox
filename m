Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270252AbUJTBDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270252AbUJTBDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUJTBDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:03:45 -0400
Received: from palrel13.hp.com ([156.153.255.238]:10928 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S270258AbUJTBDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:03:09 -0400
Date: Tue, 19 Oct 2004 18:03:06 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrNET char dev alias
Message-ID: <20041020010306.GD12932@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir269_irnet_alias.diff :
~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Add module alias for IrNET char dev
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/net/irda/irnet/irnet_ppp.d0.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.d0.c	Mon Sep 20 17:46:04 2004
+++ linux/net/irda/irnet/irnet_ppp.c	Mon Sep 20 17:46:34 2004
@@ -1111,3 +1111,4 @@ module_exit(irnet_cleanup);
 MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("IrNET : Synchronous PPP over IrDA"); 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV(10, 187);
