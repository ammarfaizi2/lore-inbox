Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVARIBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVARIBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVARIBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:01:40 -0500
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:62337 "EHLO
	mail15.speakeasy.net") by vger.kernel.org with ESMTP
	id S261171AbVARIB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:01:28 -0500
Date: Tue, 18 Jan 2005 00:01:23 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in arch/x86_64/Kconfig
Message-ID: <Pine.LNX.4.58.0501172358520.5537@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a trivial patch to fix a typo in the arch/x86_64/Kconfig file.
Diffed against linux-2.6.11-rc1. Please apply.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2005-01-12 00:13:13.000000000 -0800
+++ b/arch/x86_64/Kconfig	2005-01-17 23:57:22.000000000 -0800
@@ -59,7 +59,7 @@
 	  This is useful for kernel debugging when your machine crashes very
 	  early before the console code is initialized. For normal operation
 	  it is not recommended because it looks ugly and doesn't cooperate
-	  with klogd/syslogd or the X server. You should normally N here,
+	  with klogd/syslogd or the X server. You should normally say N here,
 	  unless you want to debug such a crash.

 config HPET_TIMER
