Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262993AbSJGL47>; Mon, 7 Oct 2002 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262994AbSJGL47>; Mon, 7 Oct 2002 07:56:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22659 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262993AbSJGL45>; Mon, 7 Oct 2002 07:56:57 -0400
Date: Mon, 7 Oct 2002 08:04:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gigi Duru <giduru@yahoo.com>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021007053805.95762.qmail@web13204.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1021007075423.18528A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Gigi Duru wrote:

> --- Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> > > * now, 2.6 (or whatever) seems like a very bad
> > choice
> > > for us.
> > 
> > have you actually tried?
> 
> didn't need to. already told you what size the bare
> bones 2.5 is, and I doubt it will get any smaller. au
> contraire...
> 
> > 
> > > Why are old versions being actively maintained
> > anyway?
> > 
> > because there are old systems where it makes sense
> > to avoid upgrades.
> > 
> > > Isn't that a realization that those old versions
> > are
> > > better suited for some tasks than the new one? Why
> > 
> > no, it's not.
> > 
> 
> oh, but it is! even using your own explanation: why
> does it make sense to avoid upgrades on those old
> systems? because those are better without, otherwise
> it would make sense to upgrade. so the old stuff
> performs better (whatever that means) on those old
> systems than the new one. q.e.d.
> 
> not to mention that "active maintenance" of the old
> kernels doesn't really save you from upgrades... just
> upgrades to the "new and improved" kernel...
> 

We use 2.4.18 on embedded systems. 2.4.19 has some new
problems (The reported select() on network I/O, being
one of them). If 2.5 becomes "stable", I should be able
to use it as long as it can be booted off a 1.2 MB floppy.
Our embedded systems don't boot off floppies, but my
BIOS NVRAM-virtual disk emulates a floppy so I don't
have any problems with compatibility. We don't do any
"execute-in-place" stuff. Linux "thinks" it was booted
off a floppy and the executables run off a RAM Disk. This
makes development and maintenance easy and allows untouched
kernels to be used.

There are absolutely no changes to the kernel. We use a
lot of modules, many (most) of which would never exist in
a Linux distribution so we are not witholding anything to,
as some say, screw, anybody.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

