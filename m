Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263807AbTCUSv7>; Fri, 21 Mar 2003 13:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263810AbTCUSvr>; Fri, 21 Mar 2003 13:51:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27780
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263807AbTCUSum>; Fri, 21 Mar 2003 13:50:42 -0500
Date: Fri, 21 Mar 2003 20:05:55 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212005.h2LK5tOI026242@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: unless this is a backward spanish inquisition joke..
Cc: davem@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/net/ipv4/route.c linux-2.5.65-ac2/net/ipv4/route.c
--- linux-2.5.65/net/ipv4/route.c	2003-03-18 16:46:53.000000000 +0000
+++ linux-2.5.65-ac2/net/ipv4/route.c	2003-03-20 18:48:52.000000000 +0000
@@ -1854,7 +1854,7 @@
 			goto out;
 
 		/* I removed check for oif == dev_out->oif here.
-		   It was wrong by three reasons:
+		   It was wrong for two reasons:
 		   1. ip_dev_find(saddr) can return wrong iface, if saddr is
 		      assigned to multiple interfaces.
 		   2. Moreover, we are allowed to send packets with saddr
