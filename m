Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRAXJCl>; Wed, 24 Jan 2001 04:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbRAXJCc>; Wed, 24 Jan 2001 04:02:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32358 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130329AbRAXJC1>; Wed, 24 Jan 2001 04:02:27 -0500
Date: Wed, 24 Jan 2001 10:02:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Henderson <rth@twiddle.net>
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010124100240.A4526@athlon.random>
In-Reply-To: <20010110163158.F19503@athlon.random> <200101102209.f0AM9N803486@flint.arm.linux.org.uk> <20010111005924.L29093@athlon.random> <20010123235115.A14786@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010123235115.A14786@twiddle.net>; from rth@twiddle.net on Tue, Jan 23, 2001 at 11:51:15PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 11:51:15PM -0800, Richard Henderson wrote:
> On Thu, Jan 11, 2001 at 12:59:24AM +0100, Andrea Arcangeli wrote:
> > What I said is that I can write this C code:
> > 
> > 	int x[2], * p = (int *) (((char *) &x)+1);
> > 	main()
> > 	{
> > 		*p = 0;
> > 	}
> > 
> > This is legal C code.
> 
> Err, no.  This is not "legal" by any stretch of the imagination.
> This code has undefined behaviour.

I know this code has undefined behaviour at _runtime_. But I thought
you were obliged to allow it to compile. That was my only point.

> We aren't even obliged to allow this to compile.

I'd love if you could forbid it to compile.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
