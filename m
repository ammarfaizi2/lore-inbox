Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136255AbRASBAg>; Thu, 18 Jan 2001 20:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136503AbRASBA2>; Thu, 18 Jan 2001 20:00:28 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:18982 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S136255AbRASBAR>; Thu, 18 Jan 2001 20:00:17 -0500
Date: Thu, 18 Jan 2001 20:00:16 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
In-Reply-To: <20010119012616.D32087@athlon.random>
Message-ID: <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >                            microseconds/yield
> > # threads      2.2.16-22           2.4        2.4-multi-queue
> > ------------   ---------         --------     ---------------
> > 16               18.740            4.603         1.455
> 
> I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)

isn't the normal case (as in "The Right Case to optimize") 
where there are close to zero runnable tasks?  what realistic/sane
scenarios have very large numbers of spinning threads?  all server
situations I can think of do not.  not volanomark -loopback, surely!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
