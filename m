Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270207AbRHWTlh>; Thu, 23 Aug 2001 15:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270205AbRHWTl3>; Thu, 23 Aug 2001 15:41:29 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:10123
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270206AbRHWTlM>; Thu, 23 Aug 2001 15:41:12 -0400
Date: Thu, 23 Aug 2001 12:41:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: Bob Glamm <glamm@mail.ece.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823085900.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3k7zutw5y.fsf@lxplus051.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3k7zutw5y.fsf@lxplus051.cern.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 09:26:33PM +0200, Jes Sorensen wrote:

> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
> Tom> On Thu, Aug 23, 2001 at 10:36:20AM -0500, Bob Glamm wrote:
> Tom> And the same set of replies.  Doing it in !python would be much
> Tom> harder than it sounds.  But people have stepped up and said
> Tom> they'd do it in C.  So python is only needed for xconfig.  And
> Tom> that's just trading tcl for python.  The other thing is, the
> Tom> python cml2 tools are supposed to eliminate a bunch of other
> Tom> tools and remove some of the dependancies.
> 
> Most of these tools were written in bash or C ... going the python way
> is a major loss.

Or perl.

> >> Why isn't ncurses a pain?  For the same reason ncurses wasn't a
> >> pain when 'make menuconfig' (lxdialog) was introduced (yes, I did
> >> many a 'make config'): curses/ncurses was already on just about
> >> every system running Linux - it was built into the text editor.
> 
> Tom> And many a new system has python.
> 
> It still doesn't solve the situation of people building embedded
> systems who do only have a bare minimum on their systems. Or people
> who are bringing up systems who do not have network/floppy available
> and do not want to move their disks between systems constantly in
> order to configure their kernels. I have brought this point up
> several times to the CML2 developer and every time I received the
> utterly useless answer saying I should move my source to another box,
> configure it there and move it back to the devel box.

You've said this before. :)  Just how small of an 'embedded' system are
you talking about?  I know of people who do compile a kernel now and
again on a 'small' system, for fun.  On a larger (cPCI) system, I
don't see your point.  If you can somehow transport the 21mb[1] bzip2
kernel source to your system, you can transport python.  If you're
porting to a brand new arch, there's still good tests before you
have shlib support (You've mentioned that before too I think).

> >> It does surprise me that Linus would actually allow this to happen.
> >> It's been my impression that he favors a clean, elegant solution.
> >> Maybe it's just me, but adding a dependency solely for the sake of
> >> building the kernel doesn't strike me as very clean or elegant.
> 
> Tom> Because the python solution happened to fix all of the problems.
> 
> And introduces new problems that so far haven't been addressed.

Which is what?  The dependancy on python2?

> The solution seems to be that someone implements CML2 in C, once that
> happens we are talking something completely different.

As long as it does everything the current version does and is just as
fast I don't think there'll be much of an argument for either.  Hell,
probably both for a while...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
