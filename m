Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271388AbTHHOwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271389AbTHHOwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:52:09 -0400
Received: from proibm3.portoweb.com.br ([200.248.222.108]:53915 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S271388AbTHHOv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:51:58 -0400
Date: Fri, 8 Aug 2003 11:54:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Andrew Morton <akpm@osdl.org>, <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
In-Reply-To: <20030808002918.723abb08.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0308081151330.8204-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Aug 2003, Stephan von Krawczynski wrote:

> On Thu, 7 Aug 2003 14:49:17 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > >
> > >  Anyway, you seem to be getting random memory corruption and I have no idea
> > >  
> > >  what the hell maybe causing it.
> > > 
> > >  Andrea? Andrew? Alan? _Any_ helpful comments?  
> > 
> > Not really, sorry.  Ugly.
> > 
> > What was the last kernel which didn't crash?
> > 
> > You're showing a huge set of reiserfs diffs there, mostly cosmetic though.
> > 
> > Running memtest86 for 12 hours is needed.
> > 
> > Going back to the last-known-kernel would be useful, just to verify that
> > the hardware is still good (some connector could have become resistive, or
> > the power supply could have drifted, etc).
> > 
> > Would it be possible to try a different filesystem on that box?
> > 
> > Do we know of other people who are using late 2.4 kernels on server-grade
> > hardware?  If so, are they doing OK?
> 
> I can give you this additional info:
> I tried about everything back to 2.4.21 release, and even this crashes on the
> box. BUT it is _not_ the only box I can crash 2.4.21. I have another hardware
> (also SMP) based not on Serverworks but on VIA chipset and with no 64 bit pci
> and it crashes with 2.4.21 around every 10 - 20 days. It definitely does not
> with 2.4.19. 

Do you have any traces of the other box crash? 

> The only requirement for my usual test-box is a working tg3 driver for the GBit
> ethernet link.

> Ah yes, and from the long series of tests I can tell that the box won't crash
> with UP kernel. I can re-check that with rc1 if this is useful.

Okey. Thats useful information. How hard would it be for you to try ext3 
as the filesystem (as Andrew suggested) ? 

