Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRHWP7M>; Thu, 23 Aug 2001 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269081AbRHWP7C>; Thu, 23 Aug 2001 11:59:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:53641
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268997AbRHWP6z>; Thu, 23 Aug 2001 11:58:55 -0400
Date: Thu, 23 Aug 2001 08:59:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bob Glamm <glamm@mail.ece.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823085900.F14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010823103620.A6965@kittpeak.ece.umn.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 10:36:20AM -0500, Bob Glamm wrote:
 
> The same argument applies now that applies when this argument first
> started when ESR announced CML to the list: my '386 with 8MB of
> RAM and it's 20MB of disk doesn't have the room (or speed, for
> that matter) to install the fad interpreted language of today.
> Besides, it'll take me 45 minutes to download the latest version
> of Python over my 28.8k modem.  And yes, I download the kernel patch
> by patch to minimize the download pain ;)

And the same set of replies.
Doing it in !python would be much harder than it sounds.  But people have
stepped up and said they'd do it in C.  So python is only needed for
xconfig.  And that's just trading tcl for python.  The other thing is,
the python cml2 tools are supposed to eliminate a bunch of other tools and
remove some of the dependancies.

> Why isn't ncurses a pain?  For the same reason ncurses wasn't a
> pain when 'make menuconfig' (lxdialog) was introduced (yes, I did many a 
> 'make config'):  curses/ncurses was already on just about every
> system running Linux - it was built into the text editor.

And many a new system has python.

> Believe it or not, there are people like me that take a distribution,
> do a minimal install just to get a machine up and running, then remove
> most of the package management software from the installation once
> networking has been configured, then continually update software
> from source as new fixes are released.  I managed to update an
> early version of Slackware from the earliest libc4 releases through
> libc6 without ever touching a distribution disk - all updated through
> source.
> 
> But I would expect that I'm in the minority in this regard. ;)

Probably.  And you can compile python too I bet :)

> It does surprise me that Linus would actually allow this to happen.
> It's been my impression that he favors a clean, elegant solution.
> Maybe it's just me, but adding a dependency solely for the sake of
> building the kernel doesn't strike me as very clean or elegant.

Because the python solution happened to fix all of the problems.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
