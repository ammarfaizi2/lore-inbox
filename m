Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbUKIK6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUKIK6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUKIK4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:56:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:53719 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261498AbUKIKmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:42:15 -0500
Subject: [PATCH 11/11] oprofile: update sparc64 for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-NP/PRKhQN1X2nzxcqKwi"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996920.1985.801.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:42:00 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NP/PRKhQN1X2nzxcqKwi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-NP/PRKhQN1X2nzxcqKwi
Content-Disposition: attachment; filename=oprofile-callgraph-sparc64
Content-Type: text/plain; name=oprofile-callgraph-sparc64; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile sparc64 arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/sparc64/oprofile/init.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux/arch/sparc64/oprofile/init.c
===================================================================
--- linux.orig/arch/sparc64/oprofile/init.c	2004-10-19 07:54:37.%N +1000
+++ linux/arch/sparc64/oprofile/init.c	2004-11-06 01:26:59.%N +1100
@@ -12,11 +12,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
  
-extern void timer_init(struct oprofile_operations ** ops);
-
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
+void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
-	return -ENODEV;
 }
 
 

--=-NP/PRKhQN1X2nzxcqKwi--

