Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUHUWsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUHUWsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUHUWsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:48:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:2501 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267984AbUHUWsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:48:02 -0400
Date: Sun, 22 Aug 2004 00:48:01 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] remove obsolete zero-paged in Documentation/sysctl/kernel.txt
Message-ID: <20040821224801.GA18858@suse.de>
References: <20040821222745.GA18734@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040821222745.GA18734@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This entry was removed during 2.5 development.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8.1.orig/Documentation/sysctl/kernel.txt linux-2.6.8.1.olh/Documentation/sysctl/kernel.txt
--- linux-2.6.8.1.orig/Documentation/sysctl/kernel.txt	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6.8.1.olh/Documentation/sysctl/kernel.txt	2004-08-22 00:30:39.149139687 +0200
@@ -54,7 +53,6 @@ show up in /proc/sys/kernel:
 - tainted
 - threads-max
 - version
-- zero-paged                  [ PPC only ]
 
 ==============================================================
 
@@ -322,11 +312,3 @@ can be ORed together:
       Set by modutils >= 2.4.9 and module-init-tools.
   4 - Unsafe SMP processors: SMP with CPUs not designed for SMP.
 
-==============================================================
-
-zero-paged: (PPC only)
-
-When enabled (non-zero), Linux-PPC will pre-zero pages in
-the idle loop, possibly speeding up get_free_pages. Since
-this only affects what the idle loop is doing, you should
-enable this and see if anything changes.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
