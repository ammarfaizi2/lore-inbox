Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261775AbSJDSnN>; Fri, 4 Oct 2002 14:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbSJDSmE>; Fri, 4 Oct 2002 14:42:04 -0400
Received: from 3512-780200-170.dialup.surnet.ru ([212.57.170.170]:50958 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S262040AbSJDSlq>;
	Fri, 4 Oct 2002 14:41:46 -0400
Date: Fri, 4 Oct 2002 22:50:51 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] 2.5.40 de2104x: a lots of timer messages
Message-ID: <20021004225051.B346@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a lots of annoying timer messages for this ethernet
adapter.  Please, apply it.


--- drivers/net/tulip/de2104x.c.orig	Sun Aug 18 02:56:40 2002
+++ drivers/net/tulip/de2104x.c	Fri Oct  4 00:18:02 2002
@@ -77,7 +77,6 @@
 #define DE_DEF_MSG_ENABLE	(NETIF_MSG_DRV		| \
 				 NETIF_MSG_PROBE 	| \
 				 NETIF_MSG_LINK		| \
-				 NETIF_MSG_TIMER	| \
 				 NETIF_MSG_IFDOWN	| \
 				 NETIF_MSG_IFUP		| \
 				 NETIF_MSG_RX_ERR	| \
