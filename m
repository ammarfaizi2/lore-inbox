Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283592AbRLRPcZ>; Tue, 18 Dec 2001 10:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282818AbRLRPcQ>; Tue, 18 Dec 2001 10:32:16 -0500
Received: from [194.234.65.222] ([194.234.65.222]:2183 "EHLO mustard.heime.net")
	by vger.kernel.org with ESMTP id <S282690AbRLRPcK>;
	Tue, 18 Dec 2001 10:32:10 -0500
Date: Tue, 18 Dec 2001 16:31:34 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Ingo Molnar <mingo@elte.hu>
cc: Ingo Molnar <mingo@redhat.com>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] raid-2.5.1-I7
In-Reply-To: <Pine.LNX.4.33.0112181809340.4279-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0112181630490.30169-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does this have anything to do with the bug I've reported about 2.4.x
> > slowing down i/o after heavy sequencial read-only from >=50 files
> > concurrently? (see BUG raid subsys)
>
> no. You have a RAID-0 array, while the patch i sent only affects RAID-1.
> It's very likely that 50 concurrent reads wont perform well on any device
> (RAID or standalone disk), i hope we can tackle workloads like that later
> in 2.5.

It really DOES perform well ... that is ... until it's used all the memory
and stops reading fast.


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

