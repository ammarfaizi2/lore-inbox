Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSBMXK3>; Wed, 13 Feb 2002 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSBMXKT>; Wed, 13 Feb 2002 18:10:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57863 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289089AbSBMXKF>; Wed, 13 Feb 2002 18:10:05 -0500
Date: Wed, 13 Feb 2002 18:08:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <Pine.LNX.3.95.1020213165845.22523A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020213180317.12448K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Richard B. Johnson wrote:

> On Wed, 13 Feb 2002, Bill Davidsen wrote:
> 
> > On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> > 
> > > The advantage, of course is that if you are executing the kernel,
> > > it can give you all the information necessary to recreate a
> > > new one from the sources because its .config is embeded into
> > > itself. Once you have the ".config" file, you just do `make oldconfig`
> > > and you are home free.
> > 
> > But it does no such thing! You not only need the config file, you need the
> > source. So you now need to add to the kernel the entire source tree from
> > which it was built, or perhaps just a diff file from a kernel.org source,
> > which you will suitably compress, of course.
> 
> What the F..? You are outa your mind. The PURPOSE is to create a .config
> from which one can do a `make oldconfig` and get the same drivers,
> modules, etc., that you have in the running kernel.
> 
> Of course you need a kernel source-code tree.

If you are going to build the same kernel you don't need *a* kernel source
code tree, you need the same kernel source code tree. Anyone who has
turned off an option because it had a bug in one kernel release will
assure you that config files for one kernel are not always safe or
functional on another.

I didn't think anyone would take that literally, I was making the point
that the config is "necessary but not sufficient" to borrow an engineering
term, and that the config is not the whole solution.

Did you build your mail reader with the sarcasm and hyperbole detector
option off?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

