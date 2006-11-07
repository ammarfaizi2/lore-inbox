Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753565AbWKGNsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbWKGNsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbWKGNsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:48:04 -0500
Received: from mo32.po.2iij.net ([210.128.50.17]:16906 "EHLO mo32.po.2iij.net")
	by vger.kernel.org with ESMTP id S1753565AbWKGNsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:48:01 -0500
Date: Tue, 7 Nov 2006 22:47:12 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: herbert@gondor.apana.org.au
Cc: yoichi_yuasa@tripeaks.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: remove one too many semicolon in crypto.h
Message-Id: <20061107224712.5d73a4ec.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has removed one too many semicolon in crypto.h .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/include/linux/crypto.h generic/include/linux/crypto.h
--- generic-orig/include/linux/crypto.h	2006-11-07 18:34:00.024144750 +0900
+++ generic/include/linux/crypto.h	2006-11-07 18:30:58.852822250 +0900
@@ -245,7 +245,7 @@ int crypto_alg_available(const char *nam
 	__deprecated_for_modules;
 int crypto_has_alg(const char *name, u32 type, u32 mask);
 #else
-static int crypto_alg_available(const char *name, u32 flags);
+static int crypto_alg_available(const char *name, u32 flags)
 	__deprecated_for_modules;
 static inline int crypto_alg_available(const char *name, u32 flags)
 {
