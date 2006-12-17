Return-Path: <linux-kernel-owner+w=401wt.eu-S1752423AbWLQLE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbWLQLE6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbWLQLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:04:58 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:38341 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752423AbWLQLE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:04:58 -0500
Date: Sun, 17 Dec 2006 12:04:56 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <200612161015.08355.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.62.0612171201540.27120@pademelon.sonytel.be>
References: <1166226982.12721.78.camel@localhost> <20061216064344.GF24090@1wt.eu>
 <200612161128.27721.rjw@sisk.pl> <200612161015.08355.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Gene Heskett wrote:
> On Saturday 16 December 2006 05:28, Rafael J. Wysocki wrote:
> >On Saturday, 16 December 2006 07:43, Willy Tarreau wrote:
> [...]
> >I think the most important problem with the binary-only drivers is that
> > we can't support their users _at_ _all_, but some of them expect us to
> > support them somehow.
> >
> >So, why don't we make an official statement, like something that will
> > appear on the front page of www.kernel.org, that the users of
> > binary-only drivers will never get any support from us?  That would
> > make things crystal clear.
> 
> I disagree with this, to the extent that I perceive this business of no 
> support for a 'tainted' kernel to be almost in the same category as 
> saying that if we configure and build our own kernels, then we are alone 
> and you don't want to hear about it.
> 
> Yes, there is a rather large difference in actual fact, but if I come to 

There's indeed a big difference. That's why people ask for your .config and for
the changes you made to your kernel (especially in cases like `Hi, the kernel
crashes with my newly written driver').

> the list with a firewire or usb problem, we should be capable of 
> divorcing the fact that I may also be using an ati or nvidia supplied 
> driver from the firewire or usb problem at hand.

You can divorce it by not loading the binary-only driver(s) and reproducing the
problem.

> I am not in fact using the ati driver with my 9200SE, as the in-kernel as 
> its plenty good enough for that I do, but that's the point.  To 
> automaticly deny supplying what might be helpfull suggestions just 
> because the user has a 'tainted' kernel strikes me as being pretty darned 
> hypocritical, particularly when the user states he has reverted but this 
> instant problem persists.

Then the kernel is no longer tainted, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
