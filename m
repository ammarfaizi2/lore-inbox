Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBTD3z>; Mon, 19 Feb 2001 22:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRBTD3q>; Mon, 19 Feb 2001 22:29:46 -0500
Received: from [216.184.166.130] ([216.184.166.130]:14894 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S129288AbRBTD32>; Mon, 19 Feb 2001 22:29:28 -0500
Date: Mon, 19 Feb 2001 19:28:37 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
In-Reply-To: <E14V3Du-0005Py-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010219192656.8485A-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Alan Cox wrote:

> Date: Tue, 20 Feb 2001 03:12:15 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>
> Cc: Linus Torvalds <torvalds@transmeta.com>,
>     lkml <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] exclusive wakeup for lock_buffer
> 
> > --- linux/include/linux/locks.h.orig	Mon Feb 19 23:16:50 2001
> > +++ linux/include/linux/locks.h	Mon Feb 19 23:21:48 2001
> > @@ -13,6 +13,7 @@
> >   * lock buffers.
> >   */
> >  extern void __wait_on_buffer(struct buffer_head *);
> > +extern void __lock_buffer(struct buffer_head *);
> 
> So are we starting 2.5 now ?

If per chance it's so, what's actually in plan for 2.5 so far?


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
kerndev@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

