Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUHXKmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUHXKmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUHXKmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:42:13 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:28164 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267449AbUHXKmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:42:00 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1: compile fix for ipv4/ip_conntrack_proto_icmp.c
Date: Tue, 24 Aug 2004 12:41:59 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3txKBB8Hh9F0SRQ"
Message-Id: <200408241241.59227.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3txKBB8Hh9F0SRQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_3txKBB8Hh9F0SRQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ip_conntrack_proto_icmp-compile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ip_conntrack_proto_icmp-compile-fix.patch"

--- linux-2.6.9-rc1/net/ipv4/netfilter/ip_conntrack_proto_icmp.c.old	2004-08-24 12:39:21.400067359 +0200
+++ linux-2.6.9-rc1/net/ipv4/netfilter/ip_conntrack_proto_icmp.c	2004-08-24 12:39:36.449605932 +0200
@@ -14,7 +14,7 @@
 #include <linux/icmp.h>
 #include <net/ip.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_core.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>

--Boundary-00=_3txKBB8Hh9F0SRQ--
