Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310293AbSCGMIp>; Thu, 7 Mar 2002 07:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310292AbSCGMIZ>; Thu, 7 Mar 2002 07:08:25 -0500
Received: from [202.135.142.196] ([202.135.142.196]:39173 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S310293AbSCGMIT>; Thu, 7 Mar 2002 07:08:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>
Cc: lse-tech@lists.sourceforge.net
Subject: furwocks: Fast Userspace Read/Write Locks
Date: Thu, 07 Mar 2002 23:11:38 +1100
Message-Id: <E16iwkE-000216-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a userspace implementation of rwlocks on top of futexes.

Release was delayed because tdbtorture started crashing... turns out
it's unrelated 2.5.6-pre2 wierdness (after a good 6 hours debugging
<SIGH>).

So I don't have numbers, but I'm pretty sure this is as good as it
gets without explicit kernel support for rwlocks.  Kudos to Paul
Mackerras for the brainwork on this one.  Blame me for the name.

	ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/futex-1.2.tar.gz

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
