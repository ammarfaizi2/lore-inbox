Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTFPVOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTFPVOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:14:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10897 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264304AbTFPVOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:14:20 -0400
Message-ID: <3EEE34E6.20709@us.ibm.com>
Date: Mon, 16 Jun 2003 14:21:42 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: [TRIVIAL][PATCH] Fix comment in include/linux/gfp.h
Content-Type: multipart/mixed;
 boundary="------------020005080100070905010203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005080100070905010203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
	Small fix for a comment in gfp.h.  A bit ago, a fix went in to make 
GFP_ZONEMASK accurate (was 0xf, now 0x3).  The patch fixed the 
definition of GFP_ZONEMASK in include/linux/mmzone.h, but didn't fix 
this comment.  It's just a comment fix, so please ignore as appropriate! ;)

Cheers!

-Matt

--------------020005080100070905010203
Content-Type: text/plain;
 name="GFP_ZONEMASK_comment_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GFP_ZONEMASK_comment_fix.patch"

--- linux-2.5.70-bk17/include/linux/gfp.h	Mon May 26 18:00:26 2003
+++ linux-2.5.70-bk17/include/linux/gfp.h.fixed	Mon Jun 16 11:48:03 2003
@@ -7,7 +7,7 @@
 /*
  * GFP bitmasks..
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low four bits) */
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
 #define __GFP_DMA	0x01
 #define __GFP_HIGHMEM	0x02
 

--------------020005080100070905010203--

