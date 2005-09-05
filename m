Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVIESdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVIESdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVIEScy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:32:54 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:54115 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932387AbVIEScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:52 -0400
Message-Id: <20050905183247.995734000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:18 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 09/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-remove-unused-includes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanup of includes meant for older implementation.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

diff -Nru a/drivers/net/plip.c b/drivers/net/plip.c
--- a/drivers/net/plip.c	2005-01-08 07:44:25 +02:00
+++ b/drivers/net/plip.c	2005-01-16 12:20:44 +02:00
@@ -98,7 +98,6 @@
 #include <linux/in.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
-#include <linux/lp.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -106,7 +105,6 @@
 #include <linux/skbuff.h>
 #include <linux/if_plip.h>
 #include <linux/workqueue.h>
-#include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/parport.h>
 #include <linux/bitops.h>

--
