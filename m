Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTHXKSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 06:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTHXKSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 06:18:42 -0400
Received: from [203.145.184.221] ([203.145.184.221]:38161 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261625AbTHXKRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 06:17:02 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [PATCH - 2.6.0-tes4-bk1] removing the extra tokens warning (drivers/char/pcxx.c)
Date: Sun, 24 Aug 2003 15:50:37 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241550.37773.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the warning:

drivers/char/pcxx.c:124:8: warning: extra tokens at end of #endif directive


Regards
KK

============================================
diffstat:
pcxx.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)
============================================
The following is the patch:

--- linux-2.6.0-test4-bk1/drivers/char/pcxx.orig.c	2003-08-24 15:45:57.000000000 +0530
+++ linux-2.6.0-test4-bk1/drivers/char/pcxx.c	2003-08-24 15:46:09.000000000 +0530
@@ -121,7 +121,7 @@
 MODULE_PARM(altpin,      "1-4i");
 MODULE_PARM(numports,    "1-4i");
 
-#endif MODULE
+#endif /* MODULE */
 
 static int numcards = 1;
 static int nbdevs = 0;

