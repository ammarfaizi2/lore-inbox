Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbRAQVu5>; Wed, 17 Jan 2001 16:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbRAQVur>; Wed, 17 Jan 2001 16:50:47 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:5935 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129745AbRAQVua>; Wed, 17 Jan 2001 16:50:30 -0500
Date: Wed, 17 Jan 2001 23:57:28 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <20010117180433.A4979@almesberger.net>
Message-ID: <Pine.LNX.4.21.0101172356090.26160-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The underlying problem is of course that all those sanity checks should
> be done in user space, not in the kernel.
> 
> (See also ftp://icaftp.epfl.ch/pub/people/almesber/slides/tmp-tc.ps.gz
> The bitching starts on slide 11, some ideas for fixing the problem on
> slide 16, but heed the warning on slide 15.)
> 
> Besides that, I agree that we have far too many EINVALs in the kernel.
> Maybe we should just record file name and line number of the EINVAL
> in *current and add an eh?(2) system call ;-)

I don't care about an error, but EINVAL is giving very confusing
errors.. Like finding your glasses when you're already have them on.

I like the h_errno solution, but that's another glibc change.

> - Werner


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
