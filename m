Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVCGUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVCGUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVCGUwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:52:01 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:4530 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261803AbVCGUNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:31 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [2/many] acrypto: Makefile
In-Reply-To: <11102278531852@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <1110227853321@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/Makefile	2005-03-07 21:16:14.000000000 +0300
@@ -0,0 +1,12 @@
+obj-$(CONFIG_ACRYPTO)		+= acrypto.o 
+obj-$(CONFIG_SIMPLE_LB)		+= simple_lb.o 
+obj-$(CONFIG_ASYNC_PROVIDER)	+= async_provider.o
+
+acrypto-y			+= crypto_main.o 
+acrypto-y			+= crypto_lb.o 
+acrypto-y			+= crypto_dev.o 
+acrypto-y			+= crypto_conn.o 
+acrypto-y			+= crypto_stat.o 
+acrypto-y			+= crypto_user_direct.o 
+acrypto-y			+= crypto_user_ioctl.o 
+acrypto-y			+= crypto_user.o

