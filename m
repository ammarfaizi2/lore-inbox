Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267373AbUHXKLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267373AbUHXKLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUHXKLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:11:50 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26884 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267446AbUHXKK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:10:56 -0400
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 compile fix in ipv4/ip_conntrack_proto_tcp.c
Date: Tue, 24 Aug 2004 12:10:57 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xQxKBMpygBrn5eY"
Message-Id: <200408241210.57619.felipe_alfaro@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xQxKBMpygBrn5eY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_xQxKBMpygBrn5eY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ip_conntrack_proto_tcp-compile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ip_conntrack_proto_tcp-compile-fix.patch"

--- linux-2.6.9-rc1/net/ipv4/netfilter/ip_conntrack_proto_tcp.c.old	2004-08-24 12:08:04.381031819 +0200
+++ linux-2.6.9-rc1/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2004-08-24 12:06:11.101773489 +0200
@@ -33,6 +33,7 @@
 #include <net/tcp.h>
 
 #include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
 #include <linux/netfilter_ipv4/lockhelp.h>

--Boundary-00=_xQxKBMpygBrn5eY--
