Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268723AbRG3W5r>; Mon, 30 Jul 2001 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268709AbRG3W5h>; Mon, 30 Jul 2001 18:57:37 -0400
Received: from ns.caldera.de ([212.34.180.1]:11695 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268762AbRG3W5X>;
	Mon, 30 Jul 2001 18:57:23 -0400
Date: Tue, 31 Jul 2001 00:56:47 +0200
Message-Id: <200107302256.f6UMuli30314@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: nigel@nrg.org (Nigel Gamble)
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.05.10107301529300.11108-100000@cosmic.nrg.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <Pine.LNX.4.05.10107301529300.11108-100000@cosmic.nrg.org> you wrote:
> I'd like to see all the various execution contexts of Linux (irqs,
> softirqs, tasklets, kernel daemons) all become (real-time where
> necessary) kernel threads like ksoftirqd, scheduled with the appropriate
> scheduling class and priority.  The resulting kernel code would be much
> simpler and more maintainable; and it would make it possible to change
> the scheduling priority of the threads to optimize for different
> application loads.

That's how solaris does it, btw.  From time to time sun seems to get
something right ;)

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
