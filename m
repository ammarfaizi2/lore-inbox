Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285191AbRLFVTe>; Thu, 6 Dec 2001 16:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285204AbRLFVTZ>; Thu, 6 Dec 2001 16:19:25 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:61125 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S285180AbRLFVTI>; Thu, 6 Dec 2001 16:19:08 -0500
Message-Id: <200112062124.OAA24459@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.17-pre5 Documentation/Changes e2fsprogs version
Date: Thu, 6 Dec 2001 14:14:49 -0700
X-Mailer: KMail [version 1.3.1]
Cc: sct@redhat.com, linux-kernel@vger.kernel.org, elenstev@mesatop.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Here is a patch to update the recommended version for e2fsprogs in Changes.

I believe that ext3 requires at least e2fsprogs 1.20 and according to the
changelog, e2fsprogs 1.25 includes some important fixes.

There didn't seem to be a source rpm for this version, so that reference is
deleted.

I'll also send a similar patch for 2.5.1-pre5 shortly.

Steven

--- linux/Documentation/Changes.pre5	Thu Dec  6 13:53:41 2001
+++ linux/Documentation/Changes	Thu Dec  6 13:56:29 2001
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: May 9, 2001
+Last updated: December 6, 2001
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -53,7 +53,7 @@
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  modutils               2.4.2                   # insmod -V
-o  e2fsprogs              1.19                    # tune2fs
+o  e2fsprogs              1.25                    # tune2fs
 o  reiserfsprogs          3.x.0j                  # reiserfsck 2>&1|grep reiserfsprogs
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
@@ -317,8 +317,7 @@
 
 E2fsprogs
 ---------
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19.tar.gz>
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19-0.src.rpm>
+o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.25.tar.gz>
 
 Reiserfsprogs
 -------------
