Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSKJTFA>; Sun, 10 Nov 2002 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSKJTFA>; Sun, 10 Nov 2002 14:05:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38151 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265095AbSKJTE6>; Sun, 10 Nov 2002 14:04:58 -0500
Date: Sun, 10 Nov 2002 11:11:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BOGUS: megaraid changes 
In-Reply-To: <200211101904.gAAJ4RX12573@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211101107400.9581-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Nov 2002, J.E.J. Bottomley wrote:
> 
> OK, what about the runtime warning with no requirement for a special flag to 
> enable attachment.

That certainly works for me - informational but not irritating. I just
suspect it will scroll past without being seen that much, though.

But along with a stack_dump() or something to make it a bit more
noticeable it might actually be visible.

> I don't necessarily agree.  It's easy to miss in all the build noise (most 
> average users don't do make -s).  And the warning isn't that fierce (it 
> complains about a prototype mismatch), so even if it's noticed, it might get 
> ignored.  At least if we have a run time warning, it's in the logs for all to 
> see when a problem gets posted to any given mailing list.

I dunno - I personally think more people look at the compile output than
at the dmessages when they scroll past. But maybe it's just me (I don't
use -s, but I tend to do "make -j4 bzImage > ../makes", so the _only_
thing I see are warnings and errors).

		Linus

