Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281271AbRKLGWA>; Mon, 12 Nov 2001 01:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281272AbRKLGVu>; Mon, 12 Nov 2001 01:21:50 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:62346 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S281271AbRKLGVn>; Mon, 12 Nov 2001 01:21:43 -0500
Message-ID: <3BEF6B1B.1E077ED9@kegel.com>
Date: Sun, 11 Nov 2001 22:24:27 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Timothy D. Witham" <wookie@osdl.org>
CC: Luigi Genoni <kernel@Expansa.sns.it>, Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it> 
		<3BE5F0B5.52274D07@kegel.com> <1004978377.1226.22.camel@wookie-laptop.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Timothy D. Witham" wrote:
> ...
>   I agree having the users run their applications and under their usage
> model is a very good way of testing code drops.  Dan, I think that what
> you are trying to say is that it might be a good idea to take a group
> of tests and make them the standard set of "pass/fail" that people
> should look to before doing their own testing.

More like a safety net.  It'd help make sure we didn't forget something
obvious.
>...
>   Regression type pass/fail tests don't tend to have the benchmark
> optimization issue but like any test they usually only find the
> problems that you either already have had in the past or that are
> obvious.  Not complete but they should be dynamic environment that
> things are being added to all the time.  Also the nice part about a
> knows series of tests is that if a problem pops up it is much
> easier to reproduce for debugging purposes.

Yep.

> > 2. The STP at OSDLab seems like a great resource that we might be able
> > to leverage to solve the problem Alan points out.
> 
>   The nice part about the way that STP was designed is that it is
> extensible.  If somebody comes up with another test we can add it.
> If we need to add additional equipment to get the run times down
> to a usable level then that is easy to do also.
> 
> > I'm not suggesting anyone do any less testing.  Just the opposite;
> > if we set things up properly with the STP, we might be able to run
> > many more tests before each final release.
> 
>   We are in the process of setting up the Kernel STP to automatically
> grab the Linus and -ac kernels and run the full setup.  This will
> do part of what Dan is asking for and it will also allow people who
> are looking to supply patches a baseline for there patch testing.

That's super!  Thanks, Tim!

At some point it might be nice to also use the STP to help
speed gcc 3 development, too.  (I personally am really
looking forward to the day when I can use the same compiler
for both c++ and kernel.)

- Dan
