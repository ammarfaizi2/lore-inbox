Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSBQMOG>; Sun, 17 Feb 2002 07:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSBQMN4>; Sun, 17 Feb 2002 07:13:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60936 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292941AbSBQMNm>; Sun, 17 Feb 2002 07:13:42 -0500
Date: Sun, 17 Feb 2002 07:11:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16bAIS-0002Qs-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020217070424.30060B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Daniel Phillips wrote:

> On February 13, 2002 10:51 pm, Bill Davidsen wrote:
> > On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> > 
> > > The advantage, of course is that if you are executing the kernel,
> > > it can give you all the information necessary to recreate a
> > > new one from the sources because its .config is embeded into
> > > itself. Once you have the ".config" file, you just do `make oldconfig`
> > > and you are home free.
> > 
> > But it does no such thing! You not only need the config file, you need the
> > source.
> 
> The source is readily available, the specific config used for your kernel may
> not be.

So is the prototype config file, what's your point? You need BOTH the
actual config file and the actual kernel source including patches to
really know what happened and to replicate it. As in kernel.org source,
Redhat source, etc. There is no "the source."
 
> > This feature just isn't all that useful,
> 
> Given your little logic slip above I'm not sure I should trust your conclusion.
> OK, I'm out of here, I'm not interested in discussing why any more, only how.

That's the point, you probably only do the very simple stuff, booting from
a multi-GB disk. People who have more complex boot systems want the boot
image small, that's why it was gzipped and later bzipped, so it would fot
more places.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

