Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTBXSKG>; Mon, 24 Feb 2003 13:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTBXSKG>; Mon, 24 Feb 2003 13:10:06 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:26091 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S261689AbTBXSKF> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:05 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390: update for 2.5.62.
Date: Mon, 24 Feb 2003 19:18:58 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200302241905.26377.schwidefsky@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
I put together another patch set for s/390. It is based on todays
2003/02/24 bitkeeper tree (2.5.62 + tagged_to_head patch).

I have a system running with kernel 2.5.62, gcc 3.3 and glibc-2.3.1
with nptl-0.21. So far everything is running stable. I wonder for
how long ...

The short descriptions:
1) Base s390 changes and bug fixes to get something going again.
2) Updates for the channel subsystem and the qdio driver.
3) Bug fixes in the ctc driver.
4) Bug fixes in the dasd driver.
5) s390 documentation update.
6) Use unified extable code.
7) Compile fixes for upcoming gcc-3.3.
8) Code clean up of the iucv driver.
9) Kconfig update.
10) Remove bogus file from the zfcp driver. Small scsi bug fix.
11) Trivial bug fixes (typos and one-liners).
12) Full support for the kernel module loader. This includes loading
  of modules compiled with -fpic.
13) Compatability layer fixes. With this patch I was able to boot a
  system with a 31 bit userspace and a 64 bit kernel. I haven't
  found any flaw in the patches send for s390x by Stephen Rothwell.

blue skies,
   Martin.

