Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276482AbRI2KTI>; Sat, 29 Sep 2001 06:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276483AbRI2KS4>; Sat, 29 Sep 2001 06:18:56 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:54357 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S276482AbRI2KSk>; Sat, 29 Sep 2001 06:18:40 -0400
Date: Sat, 29 Sep 2001 13:19:02 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
Message-ID: <20010929131902.J22640@niksula.cs.hut.fi>
In-Reply-To: <20010928143205.B3669@md5.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010928143205.B3669@md5.ca>; from pavel@md5.ca on Fri, Sep 28, 2001 at 02:32:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 02:32:05PM -0700, you [Pavel Zaitsev] said:
> I have been watching development of 2.4 since 2.4.2, I wonder wether there
> would be reversion to old process where kernel source will be solidified
> before starting development branch.

I think you can think of each new 2.4.x kernel as a candidate for
solification. The part of the linux community a like me (and perhaps you?)
that can't contribute directly to the kernel development in form of patches,
can help by testing the kernels with a great variety of setups.  Linus,
Alan, all the other guys are working their asses off getting the code as
good, clean and fast as possible. But you can't exactly expect them to
verify each change with thousands of different machines (think of the
variety of just PC hw, then think of all the other platforms linux runs on),
like MS does. Even the linux driver developers don't have access to all the
hw they support. MS doesn't release nearly as often and they have a huge QA
department running the test suites for each change set. They also have a
direct sopprt of hw vendors (who in most cases to the drivers for MS and use
all theK interim knowledge and analyzer equipment in that.)

I've always thought when Linux or alan puts out a new kernel, it's up to the
community to do the testing part.

If you need something stable, stick with 2.2 or something that has gone
through a test cycle like the RH kernels.

If you have the hardware, help testing and report bugs.

That's the way I always figured Linux community works, and IMHO considering
the facts, it does result in pretty impressive development pace and even
stability (much thanks to the pure skill the developers have).

It does, however, seem that in 2.4 the pace has been so rapid that for each
2.4.n bug found and fixed in 2.4.(n+1), there have been a few new bugs in
2.4.(n+1). I'd expect that to get better as 2.5 forks of and the 2.4 pace
slows down.

Just my two cents.


"Dan Maas" <dmaas@dcine.com> wrote:
> e.g. I consider it extremely embarrassing that fundamental drivers like
> aic7xxx, emu10k1, tulip, etc. are breaking regularly in the mainline
> kernels. I haven't had any trouble with things like this in Windows for
> several years now...

Well. I just installed the SRP (security rollup patch MS came up with
instead of releasing proper SP7) on a NT4SP6 box. The SRP erraneously
detected the box was SMP and installed SMP versions for 2 out of 6 kernel
files. Needless to say it didn't work and was a pain to trace and fix.

Similarly, I just updated to the newest NVidia display driver for NT4. It
didn't boot. Not even to VGA mode. BSOD right in start. It took me hours and
a non-NVidia display adapter to clean up the mess. And that driver had been
QA'd at NVidia for months.

So shit happens on (supposedly stable version of) windows as well. And it is
usually more of a pain to clean up, since MS gives you little tools to work
with in case of such problem.

Of course that's not an excuse and I'd certainly like to see 2.4 to be more
stable.


-- v --

v@iki.fi
