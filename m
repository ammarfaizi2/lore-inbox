Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268310AbTBSCGO>; Tue, 18 Feb 2003 21:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268311AbTBSCGO>; Tue, 18 Feb 2003 21:06:14 -0500
Received: from tomts21.bellnexxia.net ([209.226.175.183]:13814 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268310AbTBSCGN>; Tue, 18 Feb 2003 21:06:13 -0500
Date: Tue, 18 Feb 2003 21:13:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
In-Reply-To: <1045623798.25795.73.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302182110070.25342-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2003, Alan Cox wrote:

> On Wed, 2003-02-19 at 01:31, Stephen Wille Padnos wrote:
> > It seems that the mjpeg stuff will be in the wrong place when it starts 
> > being used by non-DVB modules.  I see the two (DVB and mjpeg) as 
> > distinct entities - like ethernet drivers and ipv4.  (DVB drivers should 
> > let you change channels and whatnot, mjpeg drivers should allow you to 
> > decode data streams from any available source.)
> 
> Its more by API than by hardware. One driver sometimes covers cards with
> and without tuners, with and without mpeg hardware and so on. Classification
> is nice, but like biology its never neat

true enough -- there's no perfect solution, but i'm convinced that
it can certainly be much more intuitive and organized that it is now.
i think that, as it stands now, the kernel configuration process is
the inevitable result of the linux kernel growing so fast and having
so many new features added to it that there simply was never the
time to step back, take a deep breath and clean up what was already
there before marching on.

rday

