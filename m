Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270258AbRHWUOI>; Thu, 23 Aug 2001 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRHWUN6>; Thu, 23 Aug 2001 16:13:58 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:23691
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270258AbRHWUNk>; Thu, 23 Aug 2001 16:13:40 -0400
Date: Thu, 23 Aug 2001 13:13:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: Bob Glamm <glamm@mail.ece.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823131348.Y14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823085900.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3k7zutw5y.fsf@lxplus051.cern.ch> <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net> <d3g0aituio.fsf@lxplus051.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3g0aituio.fsf@lxplus051.cern.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 10:02:07PM +0200, Jes Sorensen wrote:
> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
> Tom> You've said this before. :) Just how small of an 'embedded'
> Tom> system are you talking about?  I know of people who do compile a
> Tom> kernel now and again on a 'small' system, for fun.  On a larger
> Tom> (cPCI) system, I don't see your point.  If you can somehow
> Tom> transport the 21mb[1] bzip2 kernel source to your system, you can
> Tom> transport python.  If you're porting to a brand new arch, there's
> Tom> still good tests before you have shlib support (You've mentioned
> Tom> that before too I think).
> 
> I am actually much more concerned about bringing up new systems than
> embedded however it is not uncommon to have very limited space to work
> in (like 64MB).

64mb of space for 'disk' ?  You aren't compiling the kernel anyhow without
some serious mucking around.

> My point is that the transport process of the kernel
> image is painful. Some of the embedded devices or new systems being
> brought up may only have serial some do not have network or
> floppy. This makes it *very* painful to move things around because you
> have to physically move your disk or similar.

And you think that trying to transport the kernel srcs + userland
will save you time in the long run?  If you have to physically move
your disk to initially put userland on, you can put on python too.  Or
go and run the 'freeze' schitt on it and have the C version.  What kind
of 'new' systems are you talking about?  I'm biased I guess since I'm
used to working on documented hardware.  So documents + time + good hw
debugger tend to help things along.

> >>  And introduces new problems that so far haven't been addressed.
> 
> Tom> Which is what?  The dependancy on python2?
> 
> Yes

Because with the exception of your unique situation in which you have
a machine which is stable enough to compile a kernel on and develop
but can't run python, it's not a problem.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
