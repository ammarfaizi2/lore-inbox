Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSKNPaY>; Thu, 14 Nov 2002 10:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSKNPaY>; Thu, 14 Nov 2002 10:30:24 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:147 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264885AbSKNPaX>; Thu, 14 Nov 2002 10:30:23 -0500
Date: Thu, 14 Nov 2002 09:35:53 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Nicolas Pitre <nico@cam.org>
cc: Andreas Steinmetz <ast@domdv.de>, Sam Ravnborg <sam@ravnborg.org>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <Pine.LNX.4.44.0211131628010.16858-100000@xanadu.home>
Message-ID: <Pine.LNX.4.44.0211140933150.5313-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Nicolas Pitre wrote:

> On Wed, 13 Nov 2002, Andreas Steinmetz wrote:
> 
> > Sam Ravnborg wrote:
> > > On Wed, Nov 13, 2002 at 02:32:27PM -0500, Bill Davidsen wrote:
> > >>Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
> > >>"make help." It's really useful to have distclean work to build patched 
> > >>kernels for distribution, hopefully this is an oversight and not a new 
> > >>policy.
> > > 
> > > Since they are equal I removed the help for the less used version.
> > 
> > Not so nice. /me e.g. is used to distclean, never used mrproper and 
> > distclean is a standard target in most projects, so people are probably 
> > more used to distclean than mrproper which is kernel specific.

I think there's good reasons for both distclean and mrproper, distclean is
the standard target which most projects use, and mrproper is the
traditional Linux kernel target. So I would vote for keeping them both
(and share a common help entry).

What I don't see is why we would need different semantics, though, 
anybody?

--Kai


