Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUKIKmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUKIKmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUKIKmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:42:00 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20438 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261490AbUKIKku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:40:50 -0500
Subject: [PATCH 8/11] oprofile: update parisc for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-5sEjcslegF7gJtXz3Fed"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996840.1985.795.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:40:40 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5sEjcslegF7gJtXz3Fed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-5sEjcslegF7gJtXz3Fed
Content-Disposition: attachment; filename=oprofile-callgraph-parisc
Content-Type: text/plain; name=oprofile-callgraph-parisc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile parisc arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/parisc/oprofile/init.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux/arch/parisc/oprofile/init.c
===================================================================
--- linux.orig/arch/parisc/oprofile/init.c	2004-10-19 07:54:08.%N +1000
+++ linux/arch/parisc/oprofile/init.c	2004-11-07 17:22:20.%N +1100
@@ -12,11 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/oprofile.h>
 
-extern void timer_init(struct oprofile_operations ** ops);
-
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
+void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
-	return -ENODEV;
 }
 
 

--=-5sEjcslegF7gJtXz3Fed--

