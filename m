Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272992AbRIIReu>; Sun, 9 Sep 2001 13:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272995AbRIIRek>; Sun, 9 Sep 2001 13:34:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23872 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272992AbRIIReb>; Sun, 9 Sep 2001 13:34:31 -0400
Date: Sun, 9 Sep 2001 19:35:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010909193513.Y11329@athlon.random>
In-Reply-To: <E15g7jk-0007Rb-00@the-village.bc.nu> <Pine.LNX.4.33.0109090952380.14365-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109090952380.14365-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Sep 09, 2001 at 10:01:32AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 10:01:32AM -0700, Linus Torvalds wrote:
> (Doing per-CPU LIFO queues for the actual page allocator would potentially
> make page alloc/de-alloc much faster due to lower locking requirements
> too. So you might have a double performance win if anybody wants to try
> this out).

I recall I seen this one implemented during some auditing recently, I
think it's in the tux patch but I may remeber wrong.

Andrea
