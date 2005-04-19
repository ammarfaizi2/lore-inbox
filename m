Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVDSCiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVDSCiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 22:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDSCix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 22:38:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54797 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261277AbVDSCio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 22:38:44 -0400
Date: Tue, 19 Apr 2005 04:38:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [2,6 patch] drivers/net/arcnet/capmode.c: make a struct static
Message-ID: <20050419023840.GT5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/net/arcnet/capmode.c.old	2005-04-19 03:03:23.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/arcnet/capmode.c	2005-04-19 03:03:53.000000000 +0200
@@ -48,7 +48,7 @@
 static int ack_tx(struct net_device *dev, int acked);
 
 
-struct ArcProto capmode_proto =
+static struct ArcProto capmode_proto =
 {
 	'r',
 	XMTU,

