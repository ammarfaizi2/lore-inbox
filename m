Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDRWvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDRWvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDRWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:51:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750785AbWDRWvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:51:19 -0400
Date: Wed, 19 Apr 2006 00:51:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: madler@alumni.caltech.edu, linux-kernel@vger.kernel.org
Subject: [RFC: patch] move acknowledgment for Mark Adler to CREDITS
Message-ID: <20060418225118.GA11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The place in the documentation of the Linux kernel to acknowledge 
contributions is the CREDITS file.

Give Mark Adler an entry there instead of including a string in the 
kernel image.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 CREDITS                     |    5 +++++
 lib/zlib_inflate/inftrees.c |    9 ---------
 2 files changed, 5 insertions(+), 9 deletions(-)

--- linux-2.6.17-rc1-mm3-full/lib/zlib_inflate/inftrees.c.old	2006-04-18 22:31:47.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/lib/zlib_inflate/inftrees.c	2006-04-18 22:33:25.000000000 +0200
@@ -8,15 +8,6 @@
 
 #define MAXBITS 15
 
-const char inflate_copyright[] =
-   " inflate 1.2.3 Copyright 1995-2005 Mark Adler ";
-/*
-  If you use the zlib library in a product, an acknowledgment is welcome
-  in the documentation of your product. If for some reason you cannot
-  include such an acknowledgment, I would appreciate that you keep this
-  copyright string in the executable of your product.
- */
-
 /*
    Build a set of tables to decode the provided canonical Huffman code.
    The code lengths are lens[0..codes-1].  The result starts at *table,
--- linux-2.6.17-rc1-mm3-full/CREDITS.old	2006-04-19 00:21:59.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/CREDITS	2006-04-19 00:27:54.000000000 +0200
@@ -24,6 +24,11 @@
 S: Iasi 6600
 S: Romania
 
+N: Mark Adler
+E: madler@alumni.caltech.edu
+W: http://alumnus.caltech.edu/~madler/
+D: zlib decompression
+
 N: Monalisa Agrawal
 E: magrawal@nortelnetworks.com
 D: Basic Interphase 5575 driver with UBR and ABR support.

