Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264592AbTCZDYo>; Tue, 25 Mar 2003 22:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264591AbTCZDYk>; Tue, 25 Mar 2003 22:24:40 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:57230 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264586AbTCZDX4>;
	Tue, 25 Mar 2003 22:23:56 -0500
Date: Tue, 25 Mar 2003 22:37:46 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030325223746.GI1083@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030325223319.GC1083@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325223319.GC1083@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1002  -> 1.1003 
#	  drivers/pnp/core.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/25	ambx1@neo.rr.com	1.1003
# Increment Version Number
# --------------------------------------------
#
diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Tue Mar 25 21:44:36 2003
+++ b/drivers/pnp/core.c	Tue Mar 25 21:44:36 2003
@@ -170,7 +170,7 @@
 
 static int __init pnp_init(void)
 {
-	printk(KERN_INFO "Linux Plug and Play Support v0.95 (c) Adam Belay\n");
+	printk(KERN_INFO "Linux Plug and Play Support v0.96 (c) Adam Belay\n");
 	return bus_register(&pnp_bus_type);
 }
 
