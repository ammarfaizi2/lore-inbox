Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUEKRGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUEKRGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUEKREz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:04:55 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:2497 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264881AbUEKREH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:04:07 -0400
Date: Tue, 11 May 2004 19:04:06 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/2 :-] Support for VIA PadLock crypto engine
In-Reply-To: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0405111859190.10474@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ehm, one small patch was missing in the previous posting. Please apply
regardless on the rest. Thanks!

Michal Ludvig

diff -urp linux-2.6.5/include/asm-i386/cpufeature.h linux-2.6.5.patched/include/asm-i386/cpufeature.h
--- linux-2.6.5/include/asm-i386/cpufeature.h	2004-04-04 05:37:37.000000000 +0200
+++ linux-2.6.5.patched/include/asm-i386/cpufeature.h	2004-05-11 16:41:17.543714496 +0200
@@ -104,7 +104,9 @@
 #define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
 #define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
 #define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
+#define cpu_has_xstore_enabled	boot_cpu_has(X86_FEATURE_XSTORE_EN)
 #define cpu_has_xcrypt		boot_cpu_has(X86_FEATURE_XCRYPT)
+#define cpu_has_xcrypt_enabled	boot_cpu_has(X86_FEATURE_XCRYPT_EN)

 #endif /* __ASM_I386_CPUFEATURE_H */

