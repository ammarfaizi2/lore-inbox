Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSHOOjT>; Thu, 15 Aug 2002 10:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSHOOjT>; Thu, 15 Aug 2002 10:39:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:49348 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317034AbSHOOjS>; Thu, 15 Aug 2002 10:39:18 -0400
Date: Thu, 15 Aug 2002 09:43:04 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Greg Banks <gnb@alphalink.com.au>, Peter Samuelson <peter@cadcamlab.org>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <Pine.LNX.4.44.0208151111130.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0208150937270.849-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Roman Zippel wrote:

> > I don't think anyone who actually understands the config system would
> > argue these points, but we are limited by practical constraints to making
> > incremental improvements only.
> 
> That's fine with me, but nonetheless I'd really like to know where it will
> go to. Just fixing the easy problems is simple, but so far I haven't seen
> any plan on how to fix the hard problems. Anyone starting to fix all the
> problems should have at least some ideas how to do it and I'd really like
> to hear them. I don't want to discourage anyone, but he should understand
> the complete problem first before going for the easy targets.

I think concentrating on the small gotchas for now is a good thing. 
Surely not all conceptual problems are fixable easily, they probably need 
to be done in conjunction with switching to a common parser etc. (Note: 
this switch to a new parser should happen with no change to the config.in 
format or semantics, in order to fit the Linux/Linus way of doing things). 
However, I think it is too late in 2.5 for these kind of big changes.

That doesn't mean that fixing bugs, of which there are plenty, and small 
improvements like "" == "n" where possible shouldn't be done. If nothing 
else, it will at least give a better starting point for more elaborate 
work later.

--Kai


