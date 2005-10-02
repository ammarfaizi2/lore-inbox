Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVJBXl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVJBXl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJBXl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:41:59 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:5265 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751141AbVJBXl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:41:59 -0400
Date: Sun, 2 Oct 2005 16:41:58 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <200510021932.00969.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0510021638070.28193@shell2.speakeasy.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4340627F.6010303@shaw.ca>
 <200510021932.00969.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Gene Heskett wrote:

> On Sunday 02 October 2005 18:43, Robert Hancock wrote:
> >Luke Kenneth Casson Leighton wrote:
> >> and, what is the linux kernel?
> >>
> >> it's a daft, monolithic design that is suitable and faster on
> >> single-processor systems, and that design is going to look _really_
> >> outdated, really soon.
> >
> >Well, it sounds like it works pretty well on such things as 512 CPU
> >Altix systems, so it sounds like the suggestion that Linux is designed
> >solely for single-processor systems and isn't suitable for multicore,
> >hyperthreaded CPUs doesn't hold much water..
>
> Ahh, yes and no, Robert.  The un-answered question, for that
> 512 processor Altix system, would be "but does it run things 512
> times faster?"  Methinks not, by a very wide margin.  Yes, do a lot
> of unrelated things fast maybe, but render a 30 megabyte page with
> ghostscript in 10 milliseconds?  Never happen IMO.

This is only true for workloads that are parallelizable. I don't think
any kernel is quite good enough to divine what a single-threaded
userland application is doing and make its work parallel.

That is to say, if we are going to look at examples (and so we should),
then we need to pick an example that is actually expected to benefit
from many-processor machines.

> And Christoph in the next msg, calls him 1/2 drunk.  He doesn't come
> across to me as being more than 1 beer drunk.  And he does make some
> interesting points, so if they aren't valid, lets use proveable logic
> to shoot them down, not name calling and pointless rhetoric.
>
> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.35% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
>
>
> -

-Vadim Lobanov
