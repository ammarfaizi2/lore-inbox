Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBTVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBTVap (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 16:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVBTVap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 16:30:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:52139 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261189AbVBTVak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 16:30:40 -0500
Date: Sun, 20 Feb 2005 22:30:38 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] typo in include/linux/compiler.h
Message-ID: <20050220213038.GA21877@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


small nitpick, __KERNEL__ is the inner ifdef.


Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.11-rc4.orig/include/linux/compiler.h linux-2.6.11-rc4-klibc/include/linux/compiler.h
--- linux-2.6.11-rc4.orig/include/linux/compiler.h	2005-02-13 04:06:55.000000000 +0100
+++ linux-2.6.11-rc4-klibc/include/linux/compiler.h	2005-02-20 17:16:47.340324407 +0100
@@ -72,10 +72,10 @@ extern void __chk_io_ptr(void __iomem *)
     (typeof(ptr)) (__ptr + (off)); })
 #endif
 
-#endif /* __ASSEMBLY__ */
-
 #endif /* __KERNEL__ */
 
+#endif /* __ASSEMBLY__ */
+
 /*
  * Allow us to mark functions as 'deprecated' and have gcc emit a nice
  * warning for each use, in hopes of speeding the functions removal.
