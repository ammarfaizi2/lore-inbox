Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSBUXDF>; Thu, 21 Feb 2002 18:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSBUXCz>; Thu, 21 Feb 2002 18:02:55 -0500
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:45530 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S287134AbSBUXCs>; Thu, 21 Feb 2002 18:02:48 -0500
Date: Thu, 21 Feb 2002 18:02:47 -0500 (EST)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: <kmsmith@millipede.gpcc.itd.umich.edu>
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
In-Reply-To: <3C756C7C.29A7C2BD@compaq.com>
Message-ID: <Pine.SOL.4.33.0202211759410.13345-100000@millipede.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Feb 2002, Brian J. Watson wrote:

> "Kendrick M. Smith" wrote:
> > I just returned from vacation and saw this thread.  I also need trylock()
> > routines for read-write semaphores for NFS version 4, but you're way ahead
> > of me: I hadn't even started to implement them yet, and have been working
> > around the deficiency.  So I would really like to see some variant of this
> > patch go into the 2.5.x series eventually.  Anything I can do to help out?
>
>
> Can you test it on 2.5? It applies cleanly and builds with 2.5.3, but I
> was having trouble booting the 2.5 kernel on RedHat 7.2. Not needing to
> work on 2.5 just yet, I gave up rather quickly and just tested on 2.4.
>
> Anyway, I can send you my test patch and a brief description of what I
> looked for to make sure it was working on 2.4.

I have the patch from your original post and will give it a try with
2.5.  In that post, you also mentioned having some sort of testsuite
which would place the semaphore under heavy contention, while also
testing basic semantics of the semaphore.  If you send this along, I
will give it a try as well...

Cheers,
 Kendrick

>
> --
> Brian Watson                | "Now I don't know, but I been told it's
> Linux Kernel Developer      |  hard to run with the weight of gold,
> Open SSI Clustering Project |  Other hand I heard it said, it's
> Compaq Computer Corp        |  just as hard with the weight of lead."
> Los Angeles, CA             |     -Robert Hunter, 1970
>
> mailto:Brian.J.Watson@compaq.com
> http://opensource.compaq.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

