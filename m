Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbSKQEHj>; Sat, 16 Nov 2002 23:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbSKQEHj>; Sat, 16 Nov 2002 23:07:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47882 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267454AbSKQEHe>;
	Sat, 16 Nov 2002 23:07:34 -0500
Date: Sun, 17 Nov 2002 04:14:32 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from coda_linux.h
Message-ID: <20021117041432.F20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


coda_linux simply doesn't need sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/coda_linux.h linux-2.5.47-pci/include/linux/coda_linux.h
--- linux-2.5.47/include/linux/coda_linux.h	2002-10-15 09:32:41.000000000 -0400
+++ linux-2.5.47-pci/include/linux/coda_linux.h	2002-11-16 22:49:10.000000000 -0500
@@ -14,7 +14,6 @@
 
 #include <linux/kernel.h>
 #include <linux/param.h>
-#include <linux/sched.h> 
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>

-- 
Revolutions do not require corporate support.
