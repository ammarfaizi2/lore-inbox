Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTIDBtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTIDBtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:49:22 -0400
Received: from [209.195.52.120] ([209.195.52.120]:55519 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S264502AbTIDBtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:49:13 -0400
From: David Lang <david.lang@digitalinsight.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 3 Sep 2003 18:46:02 -0700 (PDT)
Subject: Re: Scaling noise
In-Reply-To: <20030904013253.GB4306@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0309031844270.17581-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, William Lee Irwin III wrote:

> On Wed, Sep 03, 2003 at 06:06:53PM -0700, Larry McVoy wrote:
> > Here's a thought.  Maybe the next kernel summit needs to have a CC cluster
> > BOF or whatever.  I'd be happy to show up, describe what it is that I see
> > and have you all try and poke holes in it.  If the net result was that you
> > walked away with the same picture in your head that I have that would be
> > cool.  Heck, I'll sponser it and buy beer and food if you like.
>
> It'd be nice if there were a prototype or something around to at least
> get a feel for whether it's worthwhile and how it behaves.
>
> Most of the individual mechanisms have other uses ranging from playing
> the good citizen under a hypervisor to just plain old filesharing, so
> it should be vaguely possible to get a couple kernels talking and
> farting around without much more than 1-2 P-Y's for bootstrapping bits
> and some unspecified amount of pain for missing pieces of the above.
>
> Unfortunately, this means
> (a) the box needs a hypervisor (or equivalent in native nomenclature)

how much of this need could be met with a native linux master and kernels
running user-mode kernels? (your resource sharing would obviously not be
that clean, but you could develop the tools to work across the kernel
images this way)

David Lang

> (b) substantial outlay of kernel hacking time (who's doing this?)
>
> I'm vaguely attached to the idea of there being _something_ to assess,
> otherwise it's difficult to ground the discussions in evidence, though
> worse comes to worse, we can break down to plotting and scheming again.
>
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
