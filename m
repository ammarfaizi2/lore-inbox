Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVJIUN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVJIUN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVJIUNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:13:25 -0400
Received: from waste.org ([216.27.176.166]:64413 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932281AbVJIUNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:13:25 -0400
Date: Sun, 9 Oct 2005 13:12:42 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-tiny@selenic.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.13.3-tiny1 for small systems
Message-ID: <20051009201241.GZ26160@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resync of the -tiny tree against 2.6.13.3. The latest patch
can be found at:

 http://selenic.com/tiny/2.6.13.3-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.13.3-tiny1-broken-out.tar.bz2

A Mercurial repository containing the latest broken out patches can be
found at:

 http://selenic.com/repo/tiny

There's a mailing list for linux-tiny development at:
 
 linux-tiny at selenic.com
 http://selenic.com/mailman/listinfo/linux-tiny

Webpage for your bookmarking pleasure:

 http://selenic.com/linux-tiny

Changes in this release:

+kbuild-fix-make-clean-damaging-hg-repos.patch

'make clean' damages Mercurial repositories by indiscriminately
deleting files starting with ".". Fixed in upstream.

-core-small.patch 
-pid-max.patch 
-user-hash.patch 
-futex-queues.patch 
-tvec_bases.patch 
-con_buf.patch 

Merged upstream

-06-crypto-sleep.patch 

No longer necessary

-kill-printk.patch 

Merged upstream

-nobug.patch 

Merged upstream

-no-kcore.patch 

Alternate version upstream

-semaphore-inline.patch 

Needs reworking

+kill-kmem_cache_name.patch

Fix a recent change that broke SLOB

-posix-timers.patch 

Needs reworking, may no longer be practical

-change-hz.patch 

Alternate version merged upstream

-inflate-killglobals.patch 
-inflate-initramfs.patch 
-inflate-initrd.patch 
-inflate-i386.patch 
-inflate-arm.patch 
-inflate-x86_64.patch 

This part of the inflate rework is refactored

+inflate-killmemzero.patch
+inflate-killdecls.patch
+inflate-killmarkrelease.patch
+inflate-makecrc.patch
+inflate-readbyte.patch
+inflate-flush.patch
+inflate-killsillytypes.patch
+inflate-error.patch
+inflate-tidyusers.patch
+inflate-killdebug.patch
+inflate-initdata.patch
+inflate-constdef.patch
+inflate-linkage.patch
+inflate-share-crc.patch

Extend the inflate changes to all architectures

-netpoll-timeout.patch 

Merged upstream

-- 
Mathematics is the supreme nostalgia of our time.
