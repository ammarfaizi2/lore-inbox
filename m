Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSJPSdw>; Wed, 16 Oct 2002 14:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSJPSdw>; Wed, 16 Oct 2002 14:33:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18448 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262783AbSJPSdv>;
	Wed, 16 Oct 2002 14:33:51 -0400
Date: Wed, 16 Oct 2002 19:39:49 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add PER_HPUX
Message-ID: <20021016193949.N15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allocate a personality number for HPUX binaries

diff -urpNX build-tools/dontdiff linus-2.5/include/linux/personality.h parisc-2.5/include/linux/personality.h
--- linus-2.5/include/linux/personality.h	Fri Aug 30 10:22:04 2002
+++ parisc-2.5/include/linux/personality.h	Fri Aug 30 14:00:40 2002
@@ -63,6 +63,7 @@ enum {
 	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
 	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
 	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
+	PER_HPUX =		0x0010,
 	PER_MASK =		0x00ff,
 };
 

-- 
Revolutions do not require corporate support.
