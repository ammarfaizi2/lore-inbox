Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267929AbTBRTPP>; Tue, 18 Feb 2003 14:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTBRTPP>; Tue, 18 Feb 2003 14:15:15 -0500
Received: from dsl-hkigw4i29.dial.inet.fi ([80.222.56.41]:6139 "EHLO
	dsl-hkigw4e42.dial.inet.fi") by vger.kernel.org with ESMTP
	id <S267929AbTBRTPJ>; Tue, 18 Feb 2003 14:15:09 -0500
Date: Tue, 18 Feb 2003 21:25:09 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] README: patch -p1, remove make dep
Message-ID: <Pine.LNX.4.44.0302182044550.943-100000@dsl-hkigw4e42.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Either I am doing all wrong, but I think you need to use -p1 to apply 
patches. Make dep is unnecessary now.

Best regards,
Petri Koistinen

--- linux-2.5.62/README.orig	2003-02-18 20:27:00.000000000 +0200
+++ linux-2.5.62/README	2003-02-18 20:27:20.000000000 +0200
@@ -69,10 +69,10 @@
    install by patching, get all the newer patch files, enter the
    directory in which you unpacked the kernel source and execute:
 
-		gzip -cd patchXX.gz | patch -p0
+		gzip -cd patchXX.gz | patch -p1
 
    or
-		bzip2 -dc patchXX.bz2 | patch -p0
+		bzip2 -dc patchXX.bz2 | patch -p1
 
    (repeat xx for all versions bigger than the version of your current
    source tree, _in_order_) and you should be ok.  You may want to remove
@@ -149,8 +149,6 @@
  - Check the top Makefile for further site-dependent configuration
    (default SVGA mode etc). 
 
- - Finally, do a "make dep" to set up all the dependencies correctly. 
-
 COMPILING the kernel:
 
  - Make sure you have gcc 2.95.3 available.


