Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSF3Tbs>; Sun, 30 Jun 2002 15:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSF3Tbr>; Sun, 30 Jun 2002 15:31:47 -0400
Received: from roc-66-66-84-128.rochester.rr.com ([66.66.84.128]:61824 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP
	id <S315410AbSF3Tbq>; Sun, 30 Jun 2002 15:31:46 -0400
Date: Sun, 30 Jun 2002 15:33:39 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>,
       <MISSING_MAILBOX_TERMINATOR@.SYNTAX-ERROR>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Jakob Oestergaard <jakob@unthought.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs
In-Reply-To: <20020630192046.GJ8557@unthought.net>
Message-ID: <Pine.LNX.4.44.0206301524330.340-100000@death>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jun 2002, Jakob Oestergaard wrote:

> On Sun, Jun 30, 2002 at 02:55:18PM -0400, Ken Witherow wrote:
> > [1.] One line summary of the problem:
> > Random hangs occur on dual athlon system
>
> The 2460 systems (and many other dual athlon systems) are very sensitive
> to temperature.

seems to happen regardless of temperature. In fact, it most frequenly
happens under no load. After doing some compiling, the current
temperatures read CPU0: 131F/55C, CPU1: 136F/58C, MB: 122F/50C. At idle,
they're normally in the 114/45, 120/48, 110/43 range respectively.
Currenly at about 70 minutes of uptime with the longest being about 36
hours.

> > [2.] Full description of the problem/report:
> > Sometimes the system hangs during boot, sometimes at the console and
> > other times while I'm in X. Happens whether or not I use the mem=nopentium
> > and noapic options. Frequently, I can't catch the OOPS because I'm in X
> > and everything freezes.
>
> Can it happen during boot, if you let the system cool down for an hour
> before powering it on ?

I'll have to try letting it cool the next time it happens to see if that
is indeed the cause.

> Also be sure that the PSU is big enough.

PSU is an Antec PP-412X 400 watt.

-- 
 Ken Witherow <phantoml AT rochester.rr.com> ICQ: 21840670
         KRW Technologies http://www.krwtech.com
    Linux 2.4.18 - because I'd like to get there today
to remain free, we must remain free of intrusive government




