Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbRHWPgc>; Thu, 23 Aug 2001 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRHWPgN>; Thu, 23 Aug 2001 11:36:13 -0400
Received: from mail.ece.umn.edu ([128.101.168.129]:55535 "EHLO
	mail.ece.umn.edu") by vger.kernel.org with ESMTP id <S268614AbRHWPgK>;
	Thu, 23 Aug 2001 11:36:10 -0400
Date: Thu, 23 Aug 2001 10:36:20 -0500
From: Bob Glamm <glamm@mail.ece.umn.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823103620.A6965@kittpeak.ece.umn.edu>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010823140555.A1077@newton.bauerschmidt.eu.org>; from rb@debian.org on Thu, Aug 23, 2001 at 02:05:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Am I the only one afraid that the Python requirement can turn
> > into a problem ? You can develop anything on Linux without
> > Python. I'd compare Python to Tcl - you only install it to
> > waste space, develop, or run applications that use it. Perl
> > is very different. It's required by GNU Automake and more.
> > 
> > I'm really surprised by the fact that nobody noticed what a
> > nightmare 2.6 will be with such a requirement. You can't
> > expect everybody to install something that's of no use for
> > most.
> 
> Well, I don't know the details of the plans, but IMHO is a dependency to
> python for configuring the kernel not unreasonable. Nowadays a lot of
> people don't even compile their kernels themselves, and thus not
> _everybody_ is required to have python installed. When using make

I bet the same number of people still compile their own kernels.
However, the *percentage* of people that still compile their own
kernels probably keeps shrinking as the number of people using
Linux increases.

The same argument applies now that applies when this argument first
started when ESR announced CML to the list: my '386 with 8MB of
RAM and it's 20MB of disk doesn't have the room (or speed, for
that matter) to install the fad interpreted language of today.
Besides, it'll take me 45 minutes to download the latest version
of Python over my 28.8k modem.  And yes, I download the kernel patch
by patch to minimize the download pain ;)

Why isn't ncurses a pain?  For the same reason ncurses wasn't a
pain when 'make menuconfig' (lxdialog) was introduced (yes, I did many a 
'make config'):  curses/ncurses was already on just about every
system running Linux - it was built into the text editor.

> menuconfig you are also required to have curses development files
> installed even if you don't need them for anything else. Python also is
> of (fast) growing popularity, and for example in Debian (I don't know
> about other distributions, but I suppose it's similar there) Python is
> Priority: standard (whereas libncurses5-dev surely isn't). 

Believe it or not, there are people like me that take a distribution,
do a minimal install just to get a machine up and running, then remove
most of the package management software from the installation once
networking has been configured, then continually update software
from source as new fixes are released.  I managed to update an
early version of Slackware from the earliest libc4 releases through
libc6 without ever touching a distribution disk - all updated through
source.

But I would expect that I'm in the minority in this regard. ;)

It does surprise me that Linus would actually allow this to happen.
It's been my impression that he favors a clean, elegant solution.
Maybe it's just me, but adding a dependency solely for the sake of
building the kernel doesn't strike me as very clean or elegant.

-Bob
