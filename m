Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTJEGmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 02:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTJEGmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 02:42:55 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24338
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262973AbTJEGmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 02:42:52 -0400
Date: Sat, 4 Oct 2003 23:40:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rob Landley <rob@landley.net>
cc: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <200310041952.09186.rob@landley.net>
Message-ID: <Pine.LNX.4.10.10310042320170.21746-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are so young and fresh to the game, it is cute.

http://www.gcom.com/home/support/whitepapers/linux-gnu-license.html

Try doing a little more checking of your history Rob.

The position was set in 1995 and to many who objected let it unchallanged.
Now regardless if you knew of this information or not when you entered
into kernel development, tough!  I did not know about it and have to suck
it up that binary modules are permitted, period.  So if other people can
make money, then I will too, and encourage others to persue also.

If you want to try and strike with the iron is cold bring a lunch.
Otherwise bring your lawyers when I publish freed_symbols and will eat
your lame position for a snack and spit it out because of bad taste.

Tell me I can not publish a GPL w/ source code project which returns the
original API's to their normal place in history, and I will show you that
I can still draw the string on a bow.

Tell anyone they can not change anything they want in the kernel, and you
impose a restriction and you lose your right to use by the terms of the
license called GPL.  Funny how the other side of the sword is ignored
even when it is splitting your forehead wide open.

So have a nice day.

Andre Hedrick
LAD Storage Consulting Group

On Sat, 4 Oct 2003, Rob Landley wrote:

> On Monday 15 September 2003 00:57, Erik Andersen wrote:
> > On Mon Sep 15, 2003 at 12:17:37AM +0000, Henning P. Schmiedehausen wrote:
> > > Erik Andersen <andersen@codepoet.org> writes:
> > > >When you are done making noise, please explain how a closed
> > > >source binary only product that runs within the context of the
> > > >Linux kernel is not a derivitive work and therefore not subject
> > > >to the terms of the GPL, per the definition given in the kernel
> > > >COPYING file that grants you your limited rights for copying,
> > > >distribution and modification.
> > >
> > > "Because Linus said so".
> >
> > It does not say "Because Linus said so" in the Linux kernel
> > COPYING file, which is the only official document that grants
> > legal permission to copy, distribute and/or modify the kernel.
> 
> Linus clearly and publicly stated his position on binary only kernel modules 
> almost exactly one year ago:
> 
> http://groups.google.com/groups?selm=Pine.LNX.4.44.0210170958340.6739-100000%40home.transmeta.com.lucky.linux.kernel
> 
> He basically said there IS no module exception to the GPL, it's just a 
> question of what is and is not a derived work.
> 
> The kernel developers have marked up portions of the API to indicate "we 
> consider anything that needs to access this deeply internal bit to be a 
> derived work, hence subject to the GPL".  That's what GPL_ONLY _means_.  
> Needing to re-export that therefore opens you up to a lawsuit.  (Whether you 
> can defend yourself in court from that lawsuit is always an open question, 
> but by adding GPL_ONLY markup the developers made their intent much more 
> clear, which is unlikely to help you convince a judge of your interpretation 
> if you explicitly undo that markup and then claim the license doesn't apply 
> to you...)
> 
> Here's the relevant section of the above posting from Linus:
> 
> -----
> 
> I will re-iterate my stance on the GPL and kernel modules:
> 
>   There is NOTHING in the kernel license that allows modules to be 
>   non-GPL'd. 
> 
>   The _only_ thing that allows for non-GPL modules is copyright law, and 
>   in particular the "derived work" issue. A vendor who distributes non-GPL 
>   modules is _not_ protected by the module interface per se, and should 
>   feel very confident that they can show in a court of law that the code 
>   is not derived.
> 
>   The module interface has NEVER been documented or meant to be a GPL 
>   barrier. The COPYING clearly states that the system call layer is such a 
>   barrier, so if you do your work in user land you're not in any way 
>   beholden to the GPL. The module interfaces are not system calls: there 
>   are system calls used to _install_ them, but the actual interfaces are
>   not.
> 
>   The original binary-only modules were for things that were pre-existing 
>   works of code, ie drivers and filesystems ported from other operating 
>   systems, which thus could clearly be argued to not be derived works, and 
>   the original limited export table also acted somewhat as a barrier to 
>   show a level of distance.
> 


