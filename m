Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVBQU6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVBQU6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVBQUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:55:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13837 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262294AbVBQUxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:53:41 -0500
Date: Thu, 17 Feb 2005 21:53:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/loopback.c: make a function static
Message-ID: <20050217205340.GH6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--

--- linux-2.6.11-rc3-mm2-full/drivers/net/loopback.c.old	2005-02-16 16:08:04.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/loopback.c	2005-02-16 16:08:14.000000000 +0100
@@ -184,7 +184,7 @@
 	return stats;
 }
 
-u32 loopback_get_link(struct net_device *dev)
+static u32 loopback_get_link(struct net_device *dev)
 {
 	return 1;
 }

