Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUHSLgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUHSLgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUHSLgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:36:18 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:10624 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S265521AbUHSLgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:36:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2
Date: Thu, 19 Aug 2004 07:36:14 -0400
User-Agent: KMail/1.6.82
Cc: Andrew Morton <akpm@osdl.org>
References: <20040819014204.2d412e9b.akpm@osdl.org>
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408190736.14302.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 06:36:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 04:42, Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.
>1/2.6.8.1-mm2/

Unforch Andrew, the make bails out when nearly done:

In file included from include/asm/semaphore.h:41,
                 from include/linux/sched.h:18,
                 from include/linux/module.h:10,
                 from drivers/block/genhd.c:6:
include/linux/wait.h:279: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://bugzilla.redhat.com/bugzilla> for instructions.
  CC      fs/udf/truncate.o
The bug is not reproducible, so it is likely a hardware or OS problem.
make[2]: *** [drivers/block/genhd.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
  CC      fs/udf/symlink.o
  CC      fs/udf/fsync.o
  CC      fs/udf/crc.o
  CC      fs/udf/directory.o
  CC      fs/udf/misc.o
  CC      fs/udf/udftime.o
  CC      fs/udf/unicode.o
  CC      fs/vfat/namei.o
  LD      fs/udf/udf.o
  LD      fs/udf/built-in.o
  LD      fs/vfat/vfat.o
  LD      fs/vfat/built-in.o
  LD      fs/built-in.o

gcc:gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)

Comments?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
