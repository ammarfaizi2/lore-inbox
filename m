Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310189AbSB1XKr>; Thu, 28 Feb 2002 18:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293754AbSB1XIR>; Thu, 28 Feb 2002 18:08:17 -0500
Received: from perth.fpcc.net ([207.174.142.141]:5406 "EHLO perth.fpcc.net")
	by vger.kernel.org with ESMTP id <S310189AbSB1XEP>;
	Thu, 28 Feb 2002 18:04:15 -0500
Message-Id: <200202282303.QAA15397@perth.fpcc.net>
Content-Type: text/plain; charset=US-ASCII
From: Peter Hutnick <peter@fpcc.net>
To: Jason Cook <jasonc@reinit.org>
Subject: Re: wvlan_cs in limbo?
Date: Thu, 28 Feb 2002 21:01:29 -0700
X-Mailer: KMail [version 1.3.1]
Cc: John Jasen <jjasen1@umbc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31L.02.0202252302120.5307822-100000@irix2.gl.umbc.edu> <200202260533.WAA30955@perth.fpcc.net> <20020228172958.A10716@panacea.canonical.org>
In-Reply-To: <20020228172958.A10716@panacea.canonical.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 February 2002 03:29 pm, Jason Cook wrote:
> * Peter Hutnick (peter@fpcc.net) wrote:
> > On Monday 25 February 2002 09:03 pm, John Jasen wrote:
> > > On Mon, 25 Feb 2002, Peter Hutnick wrote:
> > > > I can't figure out which end is up with wvlan_cs.  Not in the kernel
> > > > yet . . . but pcmcia-cs package is not for use with 2.4.
> > > >
> > > > Could someone give me a hint?
> > >
> > > I don't understand why you think that pcmcia-cs is not for use in 2.4.
> > > I use it on my laptop, which was just recently moved to 2.4.17.
>
> From what I understand the wvlan_cs driver is being phased out and
> replaced by the much improved orinoco_cs driver.

I guess "improved" is somewhat subjective.  It doesn't work with my card :-(

The wvlan_cs driver is in the current pcmcia-cs package, but isn't built with 
"make all."  I'm "just an end user" so I am not really cut out for figuring 
out how to build it manually.

Too bad there is no pcmcia-cs mailing list :-(

Guess I'll stick with the working stuff that came with my distro and try the 
main tree kernel again around 2.4.21.

-Peter
