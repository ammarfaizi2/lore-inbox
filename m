Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSL0AYO>; Thu, 26 Dec 2002 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSL0AYO>; Thu, 26 Dec 2002 19:24:14 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:2820 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S264697AbSL0AYN>;
	Thu, 26 Dec 2002 19:24:13 -0500
Date: Thu, 26 Dec 2002 16:28:50 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TINY] Documentation/Changes for modutils
Message-ID: <20021227002850.GA913@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Since I haven't heard any feedback, I'm assuming this
patch is acceptable.  The current Documentation/Changes points
to the wrong toolset for module support, here's a small patch
to fix that.

	Linus, please apply.

-- DN
Daniel

--- Documentation/Changes.orig	Thu Dec 26 16:29:34 2002
+++ Documentation/Changes	Thu Dec 26 16:29:38 2002
@@ -52,7 +52,7 @@
 o  Gnu make               3.78                    # make --version
 o  binutils               2.9.5.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  modutils               2.4.2                   # insmod -V
+o  module-init-tools      0.9                     # insmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.0.14                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
@@ -141,14 +141,11 @@
 version of ksymoops to decode the report; see REPORTING-BUGS in the
 root of the Linux source for more information.
 
-Modutils
+Module-Init-Tools
 --------
 
-Upgrade to recent modutils to fix various outstanding bugs which are
-seen more frequently under 2.4.x, and to enable auto-loading of USB
-modules.  In addition, the layout of modules under
-/lib/modules/`uname -r`/ has been made more sane.  This change also
-requires that you upgrade to a recent modutils.
+A new module loader is now in the kernel that requires module-init-tools
+to use.  It is backward compatible with the 2.4.x series kernels.
 
 Mkinitrd
 --------
@@ -306,7 +303,7 @@
 
 Modutils
 --------
-o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/>
+o  <ftp://ftp.kernel.org/pub/linux/people/rusty/modules/>
 
 Mkinitrd
 --------
