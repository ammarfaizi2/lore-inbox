Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUEENcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUEENcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbUEENb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:31:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:13281 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264664AbUEENb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:31:57 -0400
Date: Wed, 5 May 2004 06:31:28 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 [delete-posix-...-unifix-message]
Message-Id: <20040505063128.010475a1.pj@sgi.com>
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The broken out patch:

  delete-posix-conformance-testing-by-unifix-message.patch

is empty, except for the comment.

The actual change is missing in:

 1) the ftp directory 2.6.6-rc3-mm2/broken-out
 2) the broken-out tarball 2.6.6-rc3-mm2-broken-out.tar.bz2
 3) the monolithich patch 2.6.6-rc3-mm2.bz2

Presumably something like the following patch is intended:

========================== begin snip ==========================
From: "Randy.Dunlap" <rddunlap@osdl.org>

There is a general desire to reduce the quantity of noisy and/or
outdated kernel boot-time messages...

Suggested by Andi Kleen.

Ulrich's (old) comments:
http://www.nsa.gov/selinux/list-archive/0107/0525.cfm

Certifying Linux (Linux Journal):
http://www.linuxjournal.com/article.php?sid=0131


Index: 2.6.6-rc3-mm2/init/main.c
===================================================================
--- 2.6.6-rc3-mm2.orig/init/main.c	2004-05-05 06:11:32.000000000 -0700
+++ 2.6.6-rc3-mm2/init/main.c	2004-05-05 06:27:12.000000000 -0700
@@ -521,7 +521,6 @@
 	proc_root_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
 
 	/* 
 	 *	We count on the initial thread going ok 
========================== end snip ==========================

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
