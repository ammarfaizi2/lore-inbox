Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWEZL4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWEZL4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEZLxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:30 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22491 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932459AbWEZLxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:15 -0400
Message-ID: <348644391.18947@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115316.925345724@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:36 +0800
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
