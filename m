Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTIBMCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTIBMBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:01:01 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:32712 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP id S261322AbTIBL56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:57:58 -0400
Date: Tue, 2 Sep 2003 13:57:46 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Steve French <sfrench@samba.org>
Subject: [TRIVIAL PATCH] cifsfs.c needs kernel.h
Message-ID: <20030902115746.GA22832@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... because of the printk()s

Regards
	Erlend Aasland

diff -urN linux-2.6.0-test4/fs/cifs/cifsfs.c linux-2.6.0-test4-dirty/fs/cifs/cifsfs.c
--- linux-2.6.0-test4/fs/cifs/cifsfs.c	Sat Aug 23 01:56:30 2003
+++ linux-2.6.0-test4-dirty/fs/cifs/cifsfs.c	Tue Sep  2 13:53:59 2003
@@ -23,6 +23,7 @@
 
 /* Note that BB means BUGBUG (ie something to fix eventually) */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
... because of the printk()s

Regards
	Erlend Aasland

diff -urN linux-2.6.0-test4/fs/cifs/cifsfs.c linux-2.6.0-test4-dirty/fs/cifs/cifsfs.c
--- linux-2.6.0-test4/fs/cifs/cifsfs.c	Sat Aug 23 01:56:30 2003
+++ linux-2.6.0-test4-dirty/fs/cifs/cifsfs.c	Tue Sep  2 13:53:59 2003
@@ -23,6 +23,7 @@
 
 /* Note that BB means BUGBUG (ie something to fix eventually) */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
