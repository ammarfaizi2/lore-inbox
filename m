Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274723AbTHFC5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274815AbTHFCyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:54:33 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:22145 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S274723AbTHFCtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:49:52 -0400
Date: Tue, 5 Aug 2003 22:18:09 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.0-test2
Message-ID: <20030805221809.GH13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030805221415.GB13275@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805221415.GB13275@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/08/05	ambx1@neo.rr.com	1.1113
# [PNP] Increment Version Number
# --------------------------------------------
#
diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Tue Aug  5 21:24:34 2003
+++ b/drivers/pnp/core.c	Tue Aug  5 21:24:34 2003
@@ -169,7 +169,7 @@
 
 static int __init pnp_init(void)
 {
-	printk(KERN_INFO "Linux Plug and Play Support v0.96 (c) Adam Belay\n");
+	printk(KERN_INFO "Linux Plug and Play Support v0.97 (c) Adam Belay\n");
 	return bus_register(&pnp_bus_type);
 }
 
