Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272311AbRHXUNB>; Fri, 24 Aug 2001 16:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272314AbRHXUMv>; Fri, 24 Aug 2001 16:12:51 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:40951
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S272311AbRHXUMg>; Fri, 24 Aug 2001 16:12:36 -0400
Date: Fri, 24 Aug 2001 16:12:49 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Anwar P <anwarp@mail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: What version of the kernel fixes these VM issues?
In-Reply-To: <20010824194958Z16116-32386+96@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108241610560.25240-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Daniel Phillips wrote:

> On August 24, 2001 08:14 pm, Nicolas Pitre wrote:
> > I have a totally different setup but I can reproduce the same behavior on
> > the system I have here:
> >
> > ARM board with 32 MB RAM, no flash, NFS root.
> > The kernel is based on 2.4.8-ac9 plus some small VM fixes from -ac10.
> >
> > My test consist in compiling gcc 3.0 while some MP3s are continously playing
> > in the background.  The gcc build goes pretty far along until both the mp3
> > player and the gcc build completely jam.
>
> Which sound system, and which sound card driver?

The driver is for the UDA1341 on a SA1110 chip written by myself.  It is
fully OSS compliant, no ALSA.


Nicolas

