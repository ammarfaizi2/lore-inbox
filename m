Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWCXAIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWCXAIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWCXAIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:08:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62480 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422770AbWCXAID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:08:03 -0500
Date: Fri, 24 Mar 2006 01:08:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jing Min Zhao <zhaojignmin@hotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: [2.6 patch] ip_conntrack_helper_h323.c: EXPORT_SYMBOL'ed functions shouldn't be static
Message-ID: <20060324000801.GM22727@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL'ed functions shouldn't be static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_conntrack_helper_h323.c.old	2006-03-23 19:29:58.000000000 +0100
+++ linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_conntrack_helper_h323.c	2006-03-23 19:30:39.000000000 +0100
@@ -639,8 +639,8 @@
 }
 
 /****************************************************************************/
-static int get_h225_addr(unsigned char *data, TransportAddress * addr,
-			 u_int32_t * ip, u_int16_t * port)
+int get_h225_addr(unsigned char *data, TransportAddress * addr,
+		  u_int32_t * ip, u_int16_t * port)
 {
 	unsigned char *p;
 

