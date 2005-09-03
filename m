Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVICBZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVICBZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVICBZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:25:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34317 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751346AbVICBZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:25:54 -0400
Date: Sat, 3 Sep 2005 03:25:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/ipconfig.c should #include <linux/nfs_fs.h>
Message-ID: <20050903012543.GE3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions.

nfs_fs.h contains the prototype of root_nfs_parse_addr().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/net/ipv4/ipconfig.c.old	2005-09-03 02:18:06.000000000 +0200
+++ linux-2.6.13-mm1-full/net/ipv4/ipconfig.c	2005-09-03 02:18:27.000000000 +0200
@@ -54,6 +54,7 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/delay.h>
+#include <linux/nfs_fs.h>
 #include <net/arp.h>
 #include <net/ip.h>
 #include <net/ipconfig.h>

