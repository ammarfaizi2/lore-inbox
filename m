Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVC1NQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVC1NQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVC1NQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:16:15 -0500
Received: from alog0423.analogic.com ([208.224.222.199]:43651 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261707AbVC1NP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:15:58 -0500
Date: Mon, 28 Mar 2005 08:12:30 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
In-Reply-To: <1112011441.27381.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0503280727310.19644@chaos.analogic.com>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
 <1112011441.27381.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Steven Rostedt wrote:

> On Sun, 2005-03-27 at 21:54 -0400, Horst von Brand wrote:
>
>> Wrong. You are free to do whatever you like in the privacy of your home,
>> but not distribute the result. So you could very well distribute both
>> pieces, one under GPL, the other not, and leave the linking to the end
>> user.
>>
>> Sure, /creating/ the piece to be linked with the GPLed code might make it
>> GPL also, but that is another story.
>
> Actually this is an easy one. If you are the creator of the code, you
> can license it anyway you want. So you can make it both GPL and allow it
> to link with your code. Heck, put it under LGPL since GPL is allowed to
> link to that.
>
> Anyway, I don't think that the GPL is that powerful to affect things not
> linked directly with it. Just like the MS license can't make you do
> certain things that were stated in the license, the GPL can't take too
> much control over what you do.  If something in the license is
> reasonable, than it is easy to enforce (like taking the code from GPL
> source and using it in a binary) but if it starts to stretch (like
> controlling the code you write and how you can use it) then that will
> have to be fought in court, and will probably lose.
>
> -- Stev

Shims are used everywhere to interface with strange, incompatible,
or otherwise difficult to interface operating systems. If Linux
is too difficult or incompatible, use a shim.

In its simplest form, a shim might be a separate object containing
only the GPL license, linked with the difficult-to-interface code.
Don't jump on me yet. Read on.

In its most complicated form, the shim-file might contain some
pointers, statically initialized to GPL-only symbols, and additional
public symbols with which that your code interfaces.

In any event, you can do anything you want in the privacy of your
own bedroom, in most all countries except, perhaps, Cuba. The problems
come about when you try to sell a product, a portion of which was
designed by somebody who wanted his works to be forever "free". The
solution to this is to simply add the code that the "hold-out"
prevented you from using, to your code. Certainly, given the
complete source-code, you could come up with a perfect emulation
that doesn't copy a single line. In fact, given the time, you
could emulate all of Linux because you have the source-code
available.

To me, the fact that you want to interface with symbols that
the writer wanted to restrict, means that you want the writer
to do your work and not get paid. Perhaps you are just too
lazy to do your own thing and expect that something that
already exists should surely be freely available so you can
make money from it. Not so. I certainly am not allowed to
pick my neighbor's flowers (GPL symbols) simply because
they are where I can see them.

Of course there is the other side of the coin. I've seen
persons who had nothing at all to do with the writing of
some code, decide on their own, that its symbols are now
GPL-only symbols. Funny how they seem to know the intention
of some writer who wrote some code, left his mark, then
traveled on.

This "GPL" junk will continue forever. There is no way to
fight it. It's become a religion. If you want to write
drivers for Linux, they really must contain the GPL License
and you really need to make the source-code available. If
your "trade secrets" are really that "secret", they won't
be in a month or two, notwithstanding what the lawyers say.

Following the flock in this GPL issue insulates you from
many future changes in the kernel. Major portions of the
module code has already been rewritten to erect a solid
barrier, marking what's in the kernel and what's without.
What used to be done outside the kernel, the only reasonable
place to do it, has now been moved inside the kernel for no
other reason but isolation.

So tell your senior staff that you need to include the
GPL license with your code. If you write good code, the
chances of anybody outside your company actually reading
it is near zero. If your "trade secrets" are so obvious
that a look at the code will reveal them, you really need
to get another job, your company will disappear in a
month or two.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
