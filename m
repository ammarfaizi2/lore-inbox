Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUKILQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUKILQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUKIKzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:55:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5272 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261497AbUKIKlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:41:52 -0500
Subject: [PATCH 10/11] oprofile: update sh for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-msEwVN8htwEnr778RP6F"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996897.1985.799.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:41:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-msEwVN8htwEnr778RP6F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-msEwVN8htwEnr778RP6F
Content-Disposition: attachment; filename=oprofile-callgraph-sh
Content-Type: text/plain; name=oprofile-callgraph-sh; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile sh arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 arch/sh/oprofile/op_model_null.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux/arch/sh/oprofile/op_model_null.c
===================================================================
--- linux.orig/arch/sh/oprofile/op_model_null.c	2004-10-19 07:53:46.%N +1000
+++ linux/arch/sh/oprofile/op_model_null.c	2004-11-06 01:26:59.%N +1100
@@ -12,9 +12,8 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 
-int __init oprofile_arch_init(struct oprofile_operations **ops)
+void __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-	return -ENODEV;
 }
 
 void oprofile_arch_exit(void)

--=-msEwVN8htwEnr778RP6F--

