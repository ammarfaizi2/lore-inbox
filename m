Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272299AbTHDXfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272310AbTHDXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:35:50 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:31679 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272299AbTHDXfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:35:33 -0400
Date: Mon, 04 Aug 2003 19:35:23 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL][2.6] Bugzilla bug # 984 - 2.6 readme is still for 2.5
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308041935.23177.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The README still contains bunch of 2.5.x. Even though we are technically not
yet in 2.6, the file can (and should) be "fixed" now, so that we don't have to think
about such trivial things later.

Josef "Jeff" Sipek

--- linux-2.6.0-test2-vanilla/README	2003-07-27 13:08:22.000000000 -0400
+++ linux-2.6.0-test2-tmp/README	2003-07-27 15:14:20.000000000 -0400
@@ -1,12 +1,9 @@
-	Linux kernel release 2.5.xx
+	Linux kernel release 2.6.xx
 
-These are the release notes for Linux version 2.5.  Read them carefully,
+These are the release notes for Linux version 2.6.  Read them carefully,
 as they tell you what this is all about, explain how to install the
 kernel, and what to do if something goes wrong. 
 
-NOTE! As with all odd-numbered releases, 2.5.x is a development kernel. 
-For stable kernels, see the 2.4.x maintained by Marcelo Tosatti.
-
 WHAT IS LINUX?
 
   Linux is a Unix clone written from scratch by Linus Torvalds with
@@ -55,7 +52,7 @@
    directory where you have permissions (eg. your home directory) and
    unpack it:
 
-		gzip -cd linux-2.5.XX.tar.gz | tar xvf -
+		gzip -cd linux-2.6.XX.tar.gz | tar xvf -
 
    Replace "XX" with the version number of the latest kernel.
 
@@ -64,15 +61,15 @@
    files.  They should match the library, and not get messed up by
    whatever the kernel-du-jour happens to be.
 
- - You can also upgrade between 2.5.xx releases by patching.  Patches are
+ - You can also upgrade between 2.6.xx releases by patching.  Patches are
    distributed in the traditional gzip and the new bzip2 format.  To
    install by patching, get all the newer patch files, enter the
-   top level directory of the kernel source (linux-2.5.xx) and execute:
+   top level directory of the kernel source (linux-2.6.xx) and execute:
 
-		gzip -cd ../patch-2.5.xx.gz | patch -p1
+		gzip -cd ../patch-2.6.xx.gz | patch -p1
 
    or
-		bzip2 -dc ../patch-2.5.xx.bz2 | patch -p1
+		bzip2 -dc ../patch-2.6.xx.bz2 | patch -p1
 
    (repeat xx for all versions bigger than the version of your current
    source tree, _in_order_) and you should be ok.  You may want to remove
@@ -99,7 +96,7 @@
 
 SOFTWARE REQUIREMENTS
 
-   Compiling and running the 2.5.xx kernels requires up-to-date
+   Compiling and running the 2.6.xx kernels requires up-to-date
    versions of various software packages.  Consult
    ./Documentation/Changes for the minimum version numbers required
    and how to get updates for these packages.  Beware that using

