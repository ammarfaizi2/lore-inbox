Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275482AbRJAUAr>; Mon, 1 Oct 2001 16:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275485AbRJAUAh>; Mon, 1 Oct 2001 16:00:37 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:2058 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S275482AbRJAUAe>; Mon, 1 Oct 2001 16:00:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] invalidate buffers on blkdev_put
Date: Mon, 1 Oct 2001 16:02:51 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.GSO.4.21.0109242333240.21827-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0109242118540.29038-100000@penguin.transmeta.com> <20010927140312.A35@toy.ucw.cz>
In-Reply-To: <20010927140312.A35@toy.ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15o9FF-0005Ve-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 September 2001 10:03, Pavel Machek wrote:
> Hi!
>
> > > It's solvable, but not obvious.  It _does_ solve coherency problems
> > > between device page cache and buffer cache (thus killing
> > > update_buffers() and its ilk), but the last issue (new access path to
> > > page-private buffer_heads) may be rather nasty.
> >
> > It's certainly solvable, but it is also certainly very fraught with tons
> > of small details. I'll be very happy if people end up looking through the
> > patches _very_ critically (and don't even bother testing them if you
> > don't have a machine where you can lose a filesystem or two).
>
> Time to rename 2.4.10 to 2.5.0? ;-)

<Waving hand> It broke my feature patch. Good enough for me.  ; >

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
