Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSERCbf>; Fri, 17 May 2002 22:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSERCbe>; Fri, 17 May 2002 22:31:34 -0400
Received: from [195.223.140.120] ([195.223.140.120]:40018 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316623AbSERCbd>; Fri, 17 May 2002 22:31:33 -0400
Date: Sat, 18 May 2002 04:30:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020518023004.GF29509@dualathlon.random>
In-Reply-To: <20020518011410.GD29509@dualathlon.random> <14957.1021688031@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 12:13:51PM +1000, Keith Owens wrote:
> On Sat, 18 May 2002 03:14:10 +0200, 
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >you're right if we need a make clean it's because the buildsystem is
> >broken. However one thing that happens all the time to me, is that I
> >change an header like mm.h or sched.h and ~everything needs to be
> >rebuilt then.
> 
> That is an orthogonal problem to kbuild 2.5.  The spaghetti that is the

of course.

> include tree needs to be cleaned up, other people are working on that.
> 
> >Now the only regression I can
> >see is that kbuild was quite slower in compiling the kernel from scrach
> >(so I suspect that for me after editing mm.h it would take more time
> >with kbuild2.5 to reach the vmlinux generation than it took with the old
> >buildsystem after the make clean) Is that the case, or did you improved
> >the performance of kbuild recently?
> 
> Since release 2.0 [1], kbuild 2.5 has been faster as well as more

Ok.

> accurate than the old build system.  A couple of people have complained
> that some restricted operations are slower in kbuild 2.5 [2] but
> overall it is faster, more accurate and provides more facilities,
> especially for people building multiple kernels.
> 
> [1] http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-13/0771.html
> [2] http://marc.theaimsgroup.com/?l=linux-kernel&m=102064198628442&w=2

Thanks for the two pointers.

Andrea
