Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUIGUH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUIGUH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUIGT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:59:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:49813 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268534AbUIGT4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:56:40 -0400
Date: Tue, 7 Sep 2004 21:55:36 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix typos in Documentation/sysctl and Documentation/filesystems/proc.txt
Message-ID: <20040907195536.GA14276@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alpha is AXP.
hostname and domainname does not need redirection.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.9-rc1-bk14.orig/Documentation/filesystems/proc.txt linux-2.6.9-rc1-bk14/Documentation/filesystems/proc.txt
--- linux-2.6.9-rc1-bk14.orig/Documentation/filesystems/proc.txt	2004-09-07 21:08:39.000000000 +0200
+++ linux-2.6.9-rc1-bk14/Documentation/filesystems/proc.txt	2004-09-07 21:27:46.891576414 +0200
@@ -55,7 +55,7 @@ This work is  based on the 2.2.*  kernel
 afraid it's still far from complete, but we  hope it will be useful. As far as
 we know, it is the first 'all-in-one' document about the /proc file system. It
 is focused  on the Intel  x86 hardware,  so if you  are looking for  PPC, ARM,
-SPARC, APX, etc., features, you probably  won't find what you are looking for.
+SPARC, AXP, etc., features, you probably  won't find what you are looking for.
 It also only covers IPv4 networking, not IPv6 nor other protocols - sorry. But
 additions and patches  are welcome and will  be added to this  document if you
 mail them to Bodo.
diff -purN linux-2.6.9-rc1-bk14.orig/Documentation/sysctl/kernel.txt linux-2.6.9-rc1-bk14/Documentation/sysctl/kernel.txt
--- linux-2.6.9-rc1-bk14.orig/Documentation/sysctl/kernel.txt	2004-09-07 21:08:39.000000000 +0200
+++ linux-2.6.9-rc1-bk14/Documentation/sysctl/kernel.txt	2004-09-07 21:32:08.732081400 +0200
@@ -131,8 +142,8 @@ domainname and hostname, i.e.:
 # echo "darkstar" > /proc/sys/kernel/hostname
 # echo "mydomain" > /proc/sys/kernel/domainname
 has the same effect as
-# hostname "darkstar" > /proc/sys/kernel/hostname
-# domainname "mydomain" > /proc/sys/kernel/domainname
+# hostname "darkstar"
+# domainname "mydomain"
 
 Note, however, that the classic darkstar.frop.org has the
 hostname "darkstar" and DNS (Internet Domain Name Server)
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
