Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272130AbRIIQ3j>; Sun, 9 Sep 2001 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272059AbRIIQ3c>; Sun, 9 Sep 2001 12:29:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272068AbRIIQ3X>; Sun, 9 Sep 2001 12:29:23 -0400
Date: Sun, 9 Sep 2001 09:25:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <001201c13942$b1bec9a0$010411ac@local>
Message-ID: <Pine.LNX.4.33.0109090925080.14365-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Manfred Spraul wrote:
> >
> > it provides lifo allocations from both partial and unused slabs.
> >
>
> lifo/fifo for unused slabs is obviously superflous - free is free, it
> doesn't matter which free page is used first/last.

You're full of crap.

LIFO is obviously superior due to cache re-use.

		Linus

