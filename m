Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUF0AC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUF0AC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 20:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267239AbUF0AC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 20:02:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12284 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267237AbUF0AC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 20:02:26 -0400
Date: Sun, 27 Jun 2004 02:02:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove a superfluous #ifndef from net/ip.h
Message-ID: <20040627000222.GQ18303@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a superfluous #ifndef from net/ip.h (snmp.h is 
guarded by the same #ifndef).

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

Please apply
Adrian

--- linux-2.6.7-mm2-full/include/net/ip.h.old	2004-06-26 16:28:13.000000000 +0200
+++ linux-2.6.7-mm2-full/include/net/ip.h	2004-06-26 16:28:24.000000000 +0200
@@ -32,10 +32,7 @@
 #include <linux/in_route.h>
 #include <net/route.h>
 #include <net/arp.h>
-
-#ifndef _SNMP_H
 #include <net/snmp.h>
-#endif
 
 struct sock;
 


