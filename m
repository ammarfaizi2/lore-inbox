Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWAFCec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWAFCec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWAFCec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:34:32 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:50655 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932587AbWAFCeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:34:31 -0500
Date: Fri, 6 Jan 2006 11:34:30 +0900
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] doc: refer to kdump in oops-tracing.txt
Message-ID: <20060106023429.GC18912@miraclelinux.com>
References: <20060106023306.GB18912@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106023306.GB18912@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kdump has been merged and supported on several architectures.
It is better to encourage to use kdump rather than non standard
kernel crash dump patches.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6/Documentation/oops-tracing.txt.orig	2006-01-06 10:55:53.000000000 +0900
+++ 2.6/Documentation/oops-tracing.txt	2006-01-06 10:58:30.000000000 +0900
@@ -41,11 +41,9 @@ the disk is not available then you have 
     run a null modem to a second machine and capture the output there
     using your favourite communication program.  Minicom works well.
 
-(3) Patch the kernel with one of the crash dump patches.  These save
-    data to a floppy disk or video rom or a swap partition.  None of
-    these are standard kernel patches so you have to find and apply
-    them yourself.  Search kernel archives for kmsgdump, lkcd and
-    oops+smram.
+(3) Use Kdump (see Documentation/kdump/kdump.txt),
+    extract the kernel ring buffer from old memory with using dmesg
+    gdbmacro in Documentation/kdump/gdbmacros.txt.
 
 
 Full Information
