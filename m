Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268903AbRHFRV6>; Mon, 6 Aug 2001 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268906AbRHFRVs>; Mon, 6 Aug 2001 13:21:48 -0400
Received: from [63.209.4.196] ([63.209.4.196]:53508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268903AbRHFRVg>; Mon, 6 Aug 2001 13:21:36 -0400
Date: Mon, 6 Aug 2001 10:20:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wedgwood <cw@f00f.org>, "David S. Miller" <davem@redhat.com>,
        David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <20010806143603.C20837@athlon.random>
Message-ID: <Pine.LNX.4.33.0108061019280.8972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Andrea Arcangeli wrote:

> On Tue, Aug 07, 2001 at 12:26:50AM +1200, Chris Wedgwood wrote:
> > mmap does merge in many common cases.
>
> (assuming you speak about 2.2 because 2.4 obviously doesn't merge
> anything and that's the point of the discussion) So what? What do you
> mean with your observation?

2.4.x _does_ merge. Look for yourself. It doesn't merge mprotects, no. And
why should glibc do mprotect() for a malloc() call? Electric Fence, yes.
glibc, no.

		Linus

