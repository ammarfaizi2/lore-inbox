Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272336AbRHXW3e>; Fri, 24 Aug 2001 18:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272341AbRHXW3Y>; Fri, 24 Aug 2001 18:29:24 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:57608 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272336AbRHXW3P>; Fri, 24 Aug 2001 18:29:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: What version of the kernel fixes these VM issues?
Date: Sat, 25 Aug 2001 00:35:59 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Anwar P <anwarp@mail.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108241610560.25240-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.33.0108241610560.25240-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824222924Z16116-32383+1243@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2001 10:12 pm, Nicolas Pitre wrote:
> On Fri, 24 Aug 2001, Daniel Phillips wrote:
> 
> > On August 24, 2001 08:14 pm, Nicolas Pitre wrote:
> > > I have a totally different setup but I can reproduce the same behavior on
> > > the system I have here:
> > >
> > > ARM board with 32 MB RAM, no flash, NFS root.
> > > The kernel is based on 2.4.8-ac9 plus some small VM fixes from -ac10.
> > >
> > > My test consist in compiling gcc 3.0 while some MP3s are continously playing
> > > in the background.  The gcc build goes pretty far along until both the mp3
> > > player and the gcc build completely jam.
> >
> > Which sound system, and which sound card driver?
> 
> The driver is for the UDA1341 on a SA1110 chip written by myself.  It is
> fully OSS compliant, no ALSA.

Your system should be able to handle that easily.  Do you have some meminfo
output to look at?  What about 2.4.9?

--
Daniel

