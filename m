Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVBLD0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVBLD0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVBLD0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:26:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262381AbVBLD0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:01 -0500
Date: Fri, 11 Feb 2005 19:25:54 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032554.18524.15452.35627@tomahawk.engr.sgi.com>
In-Reply-To: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 3/7] mm: manual page migration -- cleanup 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a trivial error in include/linux/mmigrate.h

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.11-rc2-mm2/include/linux/mmigrate.h
===================================================================
--- linux-2.6.11-rc2-mm2.orig/include/linux/mmigrate.h	2005-02-11 10:08:10.000000000 -0800
+++ linux-2.6.11-rc2-mm2/include/linux/mmigrate.h	2005-02-11 11:22:34.000000000 -0800
@@ -1,5 +1,5 @@
-#ifndef _LINUX_MEMHOTPLUG_H
-#define _LINUX_MEMHOTPLUG_H
+#ifndef _LINUX_MMIGRATE_H
+#define _LINUX_MMIGRATE_H
 
 #include <linux/config.h>
 #include <linux/mm.h>
@@ -36,4 +36,4 @@ extern void arch_migrate_page(struct pag
 static inline void arch_migrate_page(struct page *page, struct page *newpage) {}
 #endif
 
-#endif /* _LINUX_MEMHOTPLUG_H */
+#endif /* _LINUX_MMIGRATE_H */

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
