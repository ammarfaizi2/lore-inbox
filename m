Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSF3XLU>; Sun, 30 Jun 2002 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSF3XLT>; Sun, 30 Jun 2002 19:11:19 -0400
Received: from colossus.systems.pipex.net ([62.190.223.73]:5845 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S314459AbSF3XLS> convert rfc822-to-8bit; Sun, 30 Jun 2002 19:11:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Philip Wyett <philipwyett@dsl.pipex.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs
Date: Mon, 1 Jul 2002 00:13:38 +0100
User-Agent: KMail/1.4.1
References: <000601c22082$cd14b980$1401a8c0@saturn>
In-Reply-To: <000601c22082$cd14b980$1401a8c0@saturn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207010013.38955.philipwyett@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This issue has all the hallmarks of PSU problems. I had the same issue running 
dual Athlon MP's with a GeForce 4 Ti4600 until I switched the 400W PSU that 
came with the case too an Enermax 550W beast. The basic Tyan approved PSU for 
the 2460 is a M2463 (460W) unit when talking to my main vendor specifically 
because of all the problems with lockups and failures to even POST (Power On 
Self Test) etc.

Regards

Philip Wyett

On Sunday 30 Jun 2002 11:09 pm, Stephen Lee wrote:
> Ken,
> 	Try a different video card.  My Dual Athlon system (A7M266-D)
> works like a charm with my GeForce 2 MX-400 but if I swap it with my
> GeForce 3 Ti500 the system will completely shutdown at some point
> (guaranteed).  This happens with the system idle or while under a load.
>
> Steve
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ken Witherow
> Sent: Sunday, June 30, 2002 2:34 PM
> To: Jakob Oestergaard
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Tyan 2460/Dual Athlon MP hangs
>
> On Sun, 30 Jun 2002, Jakob Oestergaard wrote:
> > On Sun, Jun 30, 2002 at 02:55:18PM -0400, Ken Witherow wrote:
> > > [1.] One line summary of the problem:
> > > Random hangs occur on dual athlon system
> >
> > The 2460 systems (and many other dual athlon systems) are very
>
> sensitive
>
> > to temperature.
>
> seems to happen regardless of temperature. In fact, it most frequenly
> happens under no load. After doing some compiling, the current
> temperatures read CPU0: 131F/55C, CPU1: 136F/58C, MB: 122F/50C. At idle,
> they're normally in the 114/45, 120/48, 110/43 range respectively.
> Currenly at about 70 minutes of uptime with the longest being about 36
> hours.
>
> > > [2.] Full description of the problem/report:
> > > Sometimes the system hangs during boot, sometimes at the console and
> > > other times while I'm in X. Happens whether or not I use the
>
> mem=nopentium
>
> > > and noapic options. Frequently, I can't catch the OOPS because I'm
>
> in X
>
> > > and everything freezes.
> >
> > Can it happen during boot, if you let the system cool down for an hour
> > before powering it on ?
>
> I'll have to try letting it cool the next time it happens to see if that
> is indeed the cause.
>
> > Also be sure that the PSU is big enough.
>
> PSU is an Antec PP-412X 400 watt.

