Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUHUW1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUHUW1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbUHUW1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:27:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:35255 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267976AbUHUW1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:27:45 -0400
Date: Sun, 22 Aug 2004 00:27:45 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] remove obsolete htab-reclaim in Documentation/sysctl/kernel.txt
Message-ID: <20040821222745.GA18734@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This entry is long gone, even 2.4 doesnt have it anymore.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8.1.orig/Documentation/sysctl/kernel.txt linux-2.6.8.1.olh/Documentation/sysctl/kernel.txt
--- linux-2.6.8.1.orig/Documentation/sysctl/kernel.txt	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6.8.1.olh/Documentation/sysctl/kernel.txt	2004-08-22 00:22:11.808796175 +0200
@@ -23,7 +23,6 @@ show up in /proc/sys/kernel:
 - dentry-state
 - domainname
 - hostname
-- htab-reclaim                [ PPC only ]
 - hotplug
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
@@ -145,14 +144,6 @@ see the hostname(1) man page.
 
 ==============================================================
 
-htab-reclaim: (PPC only)
-
-Setting this to a non-zero value, the PowerPC htab
-(see Documentation/powerpc/ppc_htab.txt) is pruned
-each time the system hits the idle loop.
- 
-==============================================================
-
 hotplug:
 
 Path for the hotplug policy agent.
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
