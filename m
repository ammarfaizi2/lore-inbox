Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTABMsb>; Thu, 2 Jan 2003 07:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTABMsa>; Thu, 2 Jan 2003 07:48:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:32964 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261530AbTABMs3>;
	Thu, 2 Jan 2003 07:48:29 -0500
Message-ID: <3E143714.6C939689@digeo.com>
Date: Thu, 02 Jan 2003 04:56:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.54-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 12:56:52.0693 (UTC) FILETIME=[6BE98050:01C2B25E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm2/

A couple of crash fixes here.


Since 2.5.54-mm1:

+no-stem-compression.patch

 top(1) crashes for me.  Back out the stem compression code while
 it's being sorted out.

-quota-smp-locks.patch

 Merged

page_add_rmap-rework.patch

 Was causing an oops in X startup.   Fixed.

-teeny-mem-limits.patch
-smaller-head-arrays.patch
+#teeny-mem-limits.patch
+#smaller-head-arrays.patch

 Go back to the usual memory reserve levels.

+wli-11_pgd_ctor-update.patch

 Use pgds-from-slab and pmds-from-slab on non-PAE machines too.
