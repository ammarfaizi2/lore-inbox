Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbTAANOW>; Wed, 1 Jan 2003 08:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTAANOW>; Wed, 1 Jan 2003 08:14:22 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:52926 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267233AbTAANOW>; Wed, 1 Jan 2003 08:14:22 -0500
Date: Wed, 1 Jan 2003 14:22:45 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] i810: get rid of a forgotten Rules.make include
Message-ID: <20030101132245.GB14184@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know how this managed to lurk in again, but it did so let's
go snipping.  Patch against bkcurrent.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/drivers/video/i810/Makefile b/drivers/video/i810/Makefile
--- a/drivers/video/i810/Makefile	2003-01-01 14:01:28.000000000 +0100
+++ b/drivers/video/i810/Makefile	2003-01-01 14:00:16.000000000 +0100
@@ -18,5 +18,3 @@
 else
 i810fb-objs                     += i810_dvt.o
 endif
-
-include $(TOPDIR)/Rules.make
