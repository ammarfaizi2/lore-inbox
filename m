Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVINThQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVINThQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVINThP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:37:15 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:43627 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932526AbVINThO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:37:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JL4jwVPbTV6X9RrThxIIIM67PVafPmy+IlRbvtg42B7RUBqJIMoNI1hfnMPu+Y48BAjSqG4B0SrK9qOEygcoldunvq9jOavRZ1lmyiFhQKTaSbq9YE5N6QqnV+rS8mv0Vr+EpjbuPDG76I7kyADjD1cqwe9NExA1x2ViiCaqZVM=
Date: Wed, 14 Sep 2005 23:47:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, James Nelson <james4765@gmail.com>
Subject: [PATCH] floppy: relocate devfs comment
Message-ID: <20050914194712.GF19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Nelson <james4765@gmail.com>

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/block/floppy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -98,6 +98,10 @@
  */
 
 /*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+/*
  * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
  * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
  * use of '0' for NULL.
@@ -158,10 +162,6 @@ static int print_unex = 1;
 #define FDPATCHES
 #include <linux/fdreg.h>
 
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
 

