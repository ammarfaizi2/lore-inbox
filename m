Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136664AbRASBeo>; Thu, 18 Jan 2001 20:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136636AbRASBeg>; Thu, 18 Jan 2001 20:34:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2569 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136629AbRASBe1>; Thu, 18 Jan 2001 20:34:27 -0500
Date: Fri, 19 Jan 2001 02:35:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
Message-ID: <20010119023502.G32087@athlon.random>
In-Reply-To: <20010119012616.D32087@athlon.random> <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Thu, Jan 18, 2001 at 08:00:16PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 08:00:16PM -0500, Mark Hahn wrote:
> > >                            microseconds/yield
> > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > ------------   ---------         --------     ---------------
> > > 16               18.740            4.603         1.455
> > 
> > I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> 
> isn't the normal case (as in "The Right Case to optimize") 
> where there are close to zero runnable tasks?  what realistic/sane
> scenarios have very large numbers of spinning threads?  all server
> situations I can think of do not.  not volanomark -loopback, surely!

This is why the numbers with 2/4/8 threads in the runqueue are the most
interesting ones 8)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
