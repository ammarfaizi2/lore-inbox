Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288543AbSANBNk>; Sun, 13 Jan 2002 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSANBNc>; Sun, 13 Jan 2002 20:13:32 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:54801 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288543AbSANBNO>;
	Sun, 13 Jan 2002 20:13:14 -0500
Date: Sun, 13 Jan 2002 18:05:59 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Robert Love <rml@tech9.net>, Kenneth Johansson <ken@canit.se>,
        arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113180559.A18194@hq.fsmlabs.com>
In-Reply-To: <E16Pmok-0007GD-00@the-village.bc.nu> <3C41ED4E.4D3F2D2C@linux-m68k.org> <20020113171006.A17958@hq.fsmlabs.com> <3C42293F.4962EC82@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C42293F.4962EC82@linux-m68k.org>; from zippel@linux-m68k.org on Mon, Jan 14, 2002 at 01:41:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 01:41:35AM +0100, Roman Zippel wrote:
> Hi,
> 
> yodaiken@fsmlabs.com wrote:
> 
> > > It's a useful patch for anyone, who needs good latencies now, but it's
> > > still a quick&dirty solution. Preempt offers a clean solution for a
> > > certain part of the problem, as it's possible to cleanly localize the
> > > needed changes for preemption (at least for UP). That means the ll patch
> > > becomes smaller and future work on ll becomes simpler, since a certain
> > 
> > That is exactly what Andrew Morton disputes. So why do you think he is
> > wrong?
> 
> Please explain, what do you mean?

I mean, that these conversations are not very useful if you don't
read what the other people write.
Here's a prior response by Andrew to a post by you.

>From akpm@zip.com.au  Sat Jan 12 13:15:22 2002
Roman Zippel wrote:
> 
> Andrew's patch requires constant audition and Andrew can't audit all
> drivers for possible problems. That doesn't mean Andrew's work is
> wasted, since it identifies problems, which preempting can't solve, but
> it will always be a hunt for the worst cases, where preempting goes for
> the general case.

Guys,

I've heard this so many times, and it just ain't so.   The overwhelming
majority of problem areas are inside locks.  All the complexity and 
maintainability difficulties to which you refer exist in the preempt
patch as well.    There just is no difference.

> 
> bye, Roman

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

