Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424766AbWKQFl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424766AbWKQFl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162375AbWKQFl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:41:28 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:29566 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1162363AbWKQFl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:41:28 -0500
Date: Thu, 16 Nov 2006 21:34:00 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] debugfs: add header file
Message-Id: <20061116213400.a554f40c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

debugfs needs include/linux/kobject.h for <kernel_subsys>.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 fs/debugfs/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2619-rc5mm2.orig/fs/debugfs/inode.c
+++ linux-2619-rc5mm2/fs/debugfs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/namei.h>
 #include <linux/debugfs.h>
 


---
