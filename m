Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUF1Vbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUF1Vbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUF1Vbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:31:51 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:1514 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S265219AbUF1Vbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:31:50 -0400
Date: Mon, 28 Jun 2004 14:31:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Add <linux/compiler.h> to <linux/fd.h>
Message-ID: <20040628213149.GC28128@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/fd.h> references __user which is defined in <linux/compiler.h>.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
 include/linux/fd.h |    1 +
 1 files changed, 1 insertion(+)
===== include/linux/fd.h 1.4 vs edited =====
--- 1.4/include/linux/fd.h	2004-06-03 21:18:16 -07:00
+++ edited/include/linux/fd.h	2004-06-28 14:30:33 -07:00
@@ -2,6 +2,7 @@
 #define _LINUX_FD_H
 
 #include <linux/ioctl.h>
+#include <linux/compiler.h>
 
 /* New file layout: Now the ioctl definitions immediately follow the
  * definitions of the structures that they use */

-- 
Tom Rini
http://gate.crashing.org/~trini/
