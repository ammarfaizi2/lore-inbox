Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281926AbRLRPPz>; Tue, 18 Dec 2001 10:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbRLRPPq>; Tue, 18 Dec 2001 10:15:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22929 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S280126AbRLRPPb>;
	Tue, 18 Dec 2001 10:15:31 -0500
Date: Tue, 18 Dec 2001 18:13:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] raid-2.5.1-I7
In-Reply-To: <Pine.LNX.4.30.0112181407010.29293-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0112181809340.4279-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Roy Sigurd Karlsbakk wrote:

> Does this have anything to do with the bug I've reported about 2.4.x
> slowing down i/o after heavy sequencial read-only from >=50 files
> concurrently? (see BUG raid subsys)

no. You have a RAID-0 array, while the patch i sent only affects RAID-1.
It's very likely that 50 concurrent reads wont perform well on any device
(RAID or standalone disk), i hope we can tackle workloads like that later
in 2.5.

	Ingo

