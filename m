Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRAXMVb>; Wed, 24 Jan 2001 07:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRAXMVV>; Wed, 24 Jan 2001 07:21:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56342 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131613AbRAXMVN>; Wed, 24 Jan 2001 07:21:13 -0500
Date: Wed, 24 Jan 2001 13:21:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Henderson <rth@twiddle.net>
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010124132144.A13308@athlon.random>
In-Reply-To: <20010110163158.F19503@athlon.random> <200101102209.f0AM9N803486@flint.arm.linux.org.uk> <20010111005924.L29093@athlon.random> <20010123235115.A14786@twiddle.net> <20010124100240.A4526@athlon.random> <20010124015149.A14891@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010124015149.A14891@twiddle.net>; from rth@twiddle.net on Wed, Jan 24, 2001 at 01:51:49AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 01:51:49AM -0800, Richard Henderson wrote:
> On Wed, Jan 24, 2001 at 10:02:40AM +0100, Andrea Arcangeli wrote:
> > I'd love if you could forbid it to compile.
> 
> Problem is that there's stuff like this all over the place.  Plus,

That's why I thought you were required to make it to compile. For example
you don't know if there's another object that will cast the int pointer back to
char pointer before dereferencing. That would get a defined runtime behaviour
on all archs.

And yes, I see above I'm not allowed to say "runtime" nor "defined behaviour"
according to the standard, but that's how thing works in practice.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
