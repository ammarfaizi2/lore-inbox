Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267900AbRGVEWH>; Sun, 22 Jul 2001 00:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbRGVEV5>; Sun, 22 Jul 2001 00:21:57 -0400
Received: from juicer02.bigpond.com ([139.134.6.78]:38137 "EHLO
	mailin5.bigpond.com") by vger.kernel.org with ESMTP
	id <S267898AbRGVEVi>; Sun, 22 Jul 2001 00:21:38 -0400
Message-Id: <m15O8ta-000CFtC@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation 
In-Reply-To: Your message of "Tue, 17 Jul 2001 18:34:10 MST."
             <20010717183410.S29668@work.bitmover.com> 
Date: Sun, 22 Jul 2001 12:23:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <20010717183410.S29668@work.bitmover.com> you write:
> We've got a fairly nice hash table interface in BitKeeper that we'd be 
> happy to provide under the GPL.  I've always thought it would be cool
> to have it in the kernel, we use it everywhere.
> 
> http://bitmover.com:8888//home/bk/bugfixes/src/src/mdbm

Hmmm.... cf. tdb on sourceforge.  Although having code to be mmap or
read/write backed is overkill in the kernel.

Interestingly, there's an unused, undocumented hash table interface in
include/linux/ghash.h.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
