Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313668AbSDQUIB>; Wed, 17 Apr 2002 16:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313669AbSDQUIA>; Wed, 17 Apr 2002 16:08:00 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:47120 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S313668AbSDQUH7>; Wed, 17 Apr 2002 16:07:59 -0400
Date: Wed, 17 Apr 2002 16:07:59 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417160759.G17779@sventech.com>
In-Reply-To: <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com> <07d501c1e644$ee62c6e0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002, David Brownell <david-b@pacbell.net> wrote:
> > Note that the relevance of the USB spec to most people is exactly 0%.
> 
> But to USB developers, if it's not 100% they're in major trouble!
> They're the folk who will be using this terminology/API the most.
> 
> The challenge here is to come up with something that doesn't
> needlessly confuse the major communities of interest ... such
> as by redefining terms that are already in use.

I agree. While the relevance of the USB spec to most people is exactly
0%, the relevance to the USB portion of the kernel is almost exactly 0%
as well. I'd much rather cater to the USB developers since they're the
people who will be looking at those names, not anyone else.

Nonetheless, the current naming is a bit confusing.

> > Since we're talking about the other end of a "host" driver, "client" makes
> > sense - in computers, I've always seen "client" as the reverse of the
> > "host", but maybe that's just me. 
> 
> Another overloaded word.  I've always seen it as the requestor,
> in all contexts (restaurants, stores, networking ... :) and in USB
> it's the "host" that requests.

Hmm, good point.

> > What were the other suggestions?
> 
> Of the two I saw coming by this morning ("target" from Larry,
> and "gadget" from Stephen) I confess I liked "target" best.
> It captures the initating/responding roles quite well.

I agree too.

> I don't recall many other suggestions that were forthcoming.
> 
> But I'll also toss out "firmware", which is often used in such
> contexts:  firmware revision for a network adapter, and so on.
> "USB firmware" is not likely to be expected on the host side.
> "USB target firmware", and so on.

This can also be used too, although I typically picture smaller
controllers when it comes to firmware, whereas software runs on more
general purpose controllers, like the ones people would find running
embedded devices and thusly this software.

Anyway, my opinion is that "target" is the best term to use.

JE

