Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbQLZKie>; Tue, 26 Dec 2000 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131628AbQLZKiY>; Tue, 26 Dec 2000 05:38:24 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4356 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131579AbQLZKiO>;
	Tue, 26 Dec 2000 05:38:14 -0500
Message-ID: <20001224212331.A531@bug.ucw.cz>
Date: Sun, 24 Dec 2000 21:23:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andries Brouwer <aeb@veritas.com>, Manfred <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@transmeta.com
Subject: Re: minor bugs around fork_init
In-Reply-To: <3A44D3F3.522AD08A@colorfullife.com> <20001223233806.A886@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001223233806.A886@veritas.com>; from Andries Brouwer on Sat, Dec 23, 2000 at 11:38:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * get_pid causes a deadlock when all pid numbers are in use.
> > In the worst case, only 10900 threads are required to exhaust
> > the 15 bit pid space.
> 
> Yes. I posted a patch for 31-bit pids once or twice.
> There is no great hurry, but on the other hand, it is always
> better to make these changes long before it is really urgent.

On 2Gig machine, you should be able to overflow 16 bits. So it is
quite urgent.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
