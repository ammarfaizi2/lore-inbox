Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVJCVHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVJCVHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJCVHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:07:41 -0400
Received: from free.hands.com ([83.142.228.128]:481 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932434AbVJCVHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:07:40 -0400
Date: Mon, 3 Oct 2005 22:07:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003210722.GI8548@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <1128367120.26992.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128367120.26992.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 08:18:40PM +0100, Alan Cox wrote:
> On Llu, 2005-10-03 at 01:54 +0100, Luke Kenneth Casson Leighton wrote:
> >  the message passing system is designed as a parallel message bus -
> >  completely separate from the SMP and NUMA memory architecture, and as
> >  such it is perfect for use in microkernel OSes.
> 
> I've got one of those. It has the memory attached. Makes a fantastic
> message bus and has a really long queue. Also features shortcuts for
> messages travelling between processors in short order cache to cache.
> Made by AMD and Intel.
 
 made?  _cool_.  actual hardware.  new knowledge for me.  do you know
 of any online references, papers or stuff?  [btw just to clarify:
 you're saying you have a NUMA bus or you're saying you have an
 augmented SMP+NUMA+separate-parallel-message-passing-bus er .. thing]


> >  however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
> >  and to get any faster you _have_ to go parallel.
> 
> We do 512 processors passably now. 

 wild.

> Thats a lot of cores and more than
> the commodity computing people can wire to memory subsystems at a price
> people will pay. 

 oops.

 whereas, would you see it more reasonable for a commodity-level
 chip to be something like 32- or even 64- ultra-RISC cores of
 between 5000 and 10,000 gates each, resulting in a processor
 of about 50% cache memory and 50% processing plus associated
 parallel bus architecture at around 1 million gates?

 running at oh say 1ghz or with careful design effort focussed on the
 RISC cores maybe even 2ghz, resulting in 128 total GigaOps if you
 go for 64 cpus @ 2ghz.  that's a friggin lot of processing power
 for a 1m gates processor!!

 (hey, see, i can learn to use the shift key to highlight the keyword)

 such a chip, in 90nm, would be approx $USD 20 in mass production.

 small, good heat distribution, probably too many pins, probably
 need some DRAM memory stamped upside down on top of the die,
 instead of off-chip [putting DRAM and transistors on the same die
 is a frequent and costly mistake: the yields are terrible].

 putting DRAM upside down on top of a die and then hitting it
 with a hammer (literally) is a frequently used technique to
 avoid the problem.


> Besides which you need to take it up with the desktop people really. 

 i'm sort-of drafting a reply to rik's point in my head (no it's not
 reiterations of things already said) and yes it involves legacy apps,
 badly written apps, desktop focus etc.

 server-side, yep, fine, 32-way, use it all, got it, heck,
 even my apache server running on a P200 w/64mb RAM runs more
 processes than that.

 l.

