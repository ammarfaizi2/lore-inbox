Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285206AbRLFV0d>; Thu, 6 Dec 2001 16:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285211AbRLFV0Y>; Thu, 6 Dec 2001 16:26:24 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:33739 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S285206AbRLFV0I>; Thu, 6 Dec 2001 16:26:08 -0500
Message-Id: <200112062131.OAA24481@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.1-pre5 Documentation/Changes e2fsprogs version
Date: Thu, 6 Dec 2001 14:21:53 -0700
X-Mailer: KMail [version 1.3.1]
Cc: sct@redhat.com, linux-kernel@vger.kernel.org, elenstev@mesatop.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to update the recommended version for e2fsprogs in Changes.

This patch is similar to the one I sent recently for 2.4.17-pre5, but this
is made against 2.5.1-pre5.

I believe that ext3 requires at least e2fsprogs 1.20 and according to the
changelog, e2fsprogs 1.25 includes some important fixes.

There didn't seem to be a source rpm for this version, so that reference is
deleted.

Steven

--- linux/Documentation/Changes.pre5	Thu Dec  6 13:28:22 2001
+++ linux/Documentation/Changes	Thu Dec  6 13:58:34 2001
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: November 29, 2001
+Last updated: December 6, 2001
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -53,7 +53,7 @@
 o  binutils               2.9.5.0.24              # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  modutils               2.4.2                   # insmod -V
-o  e2fsprogs              1.19                    # tune2fs
+o  e2fsprogs              1.25                    # tune2fs
 o  reiserfsprogs          3.x.0j                  # reiserfsck 2>&1|grep reiserfsprogs
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
@@ -304,8 +304,7 @@
 
 E2fsprogs
 ---------
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19.tar.gz>
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19-0.src.rpm>
+o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.25.tar.gz>
 
 Reiserfsprogs
 -------------
