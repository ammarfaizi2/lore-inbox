Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWIQItV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWIQItV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 04:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWIQItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 04:49:21 -0400
Received: from mx.melware.net ([217.91.97.190]:16402 "EHLO mx.melware.net")
	by vger.kernel.org with ESMTP id S932289AbWIQItU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 04:49:20 -0400
Date: Sun, 17 Sep 2006 10:48:58 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
X-X-Sender: armin@phoenix.one.melware.de
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, akpm@osdl.org,
       dhowells@redhat.com
Subject: Re: [PATCH 2 of 11] EICON ISDN: Removed unused definitions for
 OS_SEEK_*
In-Reply-To: <e90cdef08ec341a6aac1.1158455368@turing.ams.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609171046270.8411@phoenix.one.melware.de>
References: <e90cdef08ec341a6aac1.1158455368@turing.ams.sunysb.edu>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Agreed, these defines are not used in the linux kernel. They can be removed.

Armin

On Sat, 16 Sep 2006, Josef 'Jeff' Sipek wrote:
> EICON ISDN: Removed unused definitions for OS_SEEK_*

Acked-by: Armin Schindler <armin@melware.de> 
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--
 
diff -r 115dd6f4c050 -r e90cdef08ec3 drivers/isdn/hardware/eicon/dsp_defs.h
--- a/drivers/isdn/hardware/eicon/dsp_defs.h	Sat Sep 16 21:00:45 2006 -0400
+++ b/drivers/isdn/hardware/eicon/dsp_defs.h	Sat Sep 16 21:00:45 2006 -0400
@@ -34,9 +34,6 @@
  *
  * I/O functions returns -1 on error, 0 on EOF
  */
-#define OS_SEEK_SET 0
-#define OS_SEEK_CUR 1
-#define OS_SEEK_END 2
 struct _OsFileHandle_;
 typedef long (  * OsFileIo)  (struct _OsFileHandle_    *handle,
                                 void                     *buffer,


