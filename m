Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRC0CIA>; Mon, 26 Mar 2001 21:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRC0CHv>; Mon, 26 Mar 2001 21:07:51 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:35273 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S130434AbRC0CHn>; Mon, 26 Mar 2001 21:07:43 -0500
From: ianh@iahastie.clara.net (Ian Hastie)
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2001 02:06:20 +0000 (UTC)
Subject: [PATCH] Very small fix for 2.4.3-pre8 unresolved symbols
Organization: home using Linux
Message-ID: <slrn9bvtcs.1ci.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It just adds net_init.o to the definition of export-objs.

--- linux-2.4.3-pre8/drivers/net/Makefile.symbols	Tue Mar 27 00:30:58 2001
+++ linux-2.4.3-pre8/drivers/net/Makefile	Tue Mar 27 03:00:21 2001
@@ -16,7 +16,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o ppp_async.o \
-			ppp_generic.o slhc.o pppox.o auto_irq.o
+			ppp_generic.o slhc.o pppox.o auto_irq.o net_init.o
 
 ifeq ($(CONFIG_TULIP),y)
   obj-y += tulip/tulip.o

-- 
Ian.

I don't have a sig either!
