Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132813AbRDDM7w>; Wed, 4 Apr 2001 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132818AbRDDM7m>; Wed, 4 Apr 2001 08:59:42 -0400
Received: from chiara.elte.hu ([157.181.150.200]:36108 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132813AbRDDM7g>;
	Wed, 4 Apr 2001 08:59:36 -0400
Date: Wed, 4 Apr 2001 13:57:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Fabio Riccardi <fabio@chromium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <E14kbH2-0000qX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0104041351400.4611-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Apr 2001, Alan Cox wrote:

> The problem has always been - alternative scheduler, crappier
> performance for 2 tasks running (which is most boxes). [...]

it's not only the 2-task case, but also less flexibility or lost
semantics.

> Indeed. I'd love to see you beat tux entirely in userspace. It proves
> the rest of the API for the kernel is right

well, until the cost of entry into the kernel is eliminated, this is not
possible - unless there are performance bugs in TUX :-)

but yes, getting a userspace solution that gets 'close enough' in eg.
SPECweb99 benchmarks (which is complex enough to be trusted as a generic
performance metric) would be a nice thing to have. There are existing
SIGIO based, multithreaded solutions (eg. phttpd), with varying success.

	Ingo

