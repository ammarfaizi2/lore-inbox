Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUDEVFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbUDEVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:05:06 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:32640 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262673AbUDEVE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:04:59 -0400
Date: Mon, 5 Apr 2004 23:04:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix #endif comment in linux/moduleparam.h
Message-ID: <20040405210450.GA3533@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If we are providing "helpfull" comment, it should better be
correct... Please apply,
							Pavel

--- tmp/linux/include/linux/moduleparam.h	2004-04-05 10:45:30.000000000 +0200
+++ linux/include/linux/moduleparam.h	2004-04-05 16:50:49.000000000 +0200
@@ -147,4 +147,4 @@
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
 		int *num);
-#endif /* _LINUX_MODULE_PARAM_TYPES_H */
+#endif /* _LINUX_MODULE_PARAMS_H */


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
