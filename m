Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130192AbQLYSdQ>; Mon, 25 Dec 2000 13:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbQLYSdG>; Mon, 25 Dec 2000 13:33:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:34571 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130192AbQLYScu>;
	Mon, 25 Dec 2000 13:32:50 -0500
Date: Mon, 25 Dec 2000 19:00:07 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andreas Franck <afranck@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
In-Reply-To: <00122517123400.00573@dg1kfa.ampr.org>
Message-ID: <Pine.Linu.4.10.10012251847030.637-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2000, Andreas Franck wrote:

> Hello Mike, hello linux-kernel hackers,
> 
> Mike Galbraith wrote:
> > I wouldn't (not going to here;) spend a lot of time on it.  The compiler
> > has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.
> 
> Maybe, but you were lucky getting an ICE, and not silently failing code :-)

You bet.

> After having spent several hours debugging now, I think it was 
> worth it (at least for my understanding of lower-level kernel issues and of 
> the (rather nice and almost readable) assembly code gcc generates). There 

Don't get me wrong, chasing things like this is never a waste of time.
In the case of gcc in particular.  Our next 'stable' kernel compiler
is going to come from the gcc development tree just as the next 'stable'
kernel is coming out of the kernel development tree.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
