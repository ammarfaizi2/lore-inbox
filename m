Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTDDFXp (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTDDFCZ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:02:25 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:21893 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262932AbTDDE4d (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:56:33 -0500
Date: Fri, 4 Apr 2003 00:11:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404001138.GH11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030404000731.GB11574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404000731.GB11574@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Thu Apr  3 23:40:52 2003
+++ b/drivers/pnp/core.c	Thu Apr  3 23:40:52 2003
@@ -170,7 +170,7 @@
 
 static int __init pnp_init(void)
 {
-	printk(KERN_INFO "Linux Plug and Play Support v0.95 (c) Adam Belay\n");
+	printk(KERN_INFO "Linux Plug and Play Support v0.96 (c) Adam Belay\n");
 	return bus_register(&pnp_bus_type);
 }
 
