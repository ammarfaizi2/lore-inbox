Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbTHHPaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271405AbTHHPaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:30:39 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:61871 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S271401AbTHHPah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:30:37 -0400
Date: Fri, 8 Aug 2003 12:33:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: akpm@osdl.org, <andrea@suse.de>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
In-Reply-To: <20030808170536.23118033.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Aug 2003, Stephan von Krawczynski wrote:

> On Fri, 8 Aug 2003 11:54:39 -0300 (BRT)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> 
> > > I can give you this additional info:
> > > I tried about everything back to 2.4.21 release, and even this crashes on
> > > the box. BUT it is _not_ the only box I can crash 2.4.21. I have another
> > > hardware(also SMP) based not on Serverworks but on VIA chipset and with no
> > > 64 bit pci and it crashes with 2.4.21 around every 10 - 20 days. It
> > > definitely does not with 2.4.19. 
> > 
> > Do you have any traces of the other box crash? 
> 
> Not at hand, but can prepare for the next crash during the weekend.
> 
> > > The only requirement for my usual test-box is a working tg3 driver for the
> > > GBit ethernet link.
> > 
> > > Ah yes, and from the long series of tests I can tell that the box won't
> > > crash with UP kernel. I can re-check that with rc1 if this is useful.
> > 
> > Okey. Thats useful information. How hard would it be for you to try ext3 
> > as the filesystem (as Andrew suggested) ? 
> 
> Well, if that provides further info I will do. I will try to achieve over the
> weekend, I need some spare volumes for conversion (by copy) :-)

That will provide further information yes. We can then know if the problem 
is reiserfs specific or not, which is VERY useful.

Again, thanks for your efforts helping us track down the problem.

