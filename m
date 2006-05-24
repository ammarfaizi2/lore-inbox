Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWEXLTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWEXLTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWEXLTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:35 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:28034 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932691AbWEXLTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:18 -0400
Message-ID: <348469550.21709@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111912.156646847@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 30/33] readahead: turn on by default
Content-Disposition: inline; filename=readahead-kconfig-option-default-on.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the adaptive readahead logic by default.

It helps collect more early testers, and is meant to be a -mm only patch.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm3.orig/mm/Kconfig
+++ linux-2.6.17-rc4-mm3/mm/Kconfig
@@ -152,7 +152,7 @@ config MIGRATION
 #
 config ADAPTIVE_READAHEAD
 	bool "Adaptive file readahead (EXPERIMENTAL)"
-	default n
+	default y
 	depends on EXPERIMENTAL
 	help
 	  Readahead is a technique employed by the kernel in an attempt

--
