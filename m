Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272989AbRIIRaj>; Sun, 9 Sep 2001 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272992AbRIIRa3>; Sun, 9 Sep 2001 13:30:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272989AbRIIRaL>; Sun, 9 Sep 2001 13:30:11 -0400
Date: Sun, 9 Sep 2001 19:30:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010909193051.X11329@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109090925080.14365-100000@penguin.transmeta.com> <E15g7jk-0007Rb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15g7jk-0007Rb-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Sep 09, 2001 at 05:47:12PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 05:47:12PM +0100, Alan Cox wrote:
> > > doesn't matter which free page is used first/last.
> > 
> > You're full of crap.
> > LIFO is obviously superior due to cache re-use.
> 
> Interersting question however. On SMP without sufficient per CPU slab caches
> is tht still the case ?

if we stay in per-cpu caches then the other paths cannot run at all so it
cannot make any difference for such case.

Andrea
