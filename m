Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSF3WEv>; Sun, 30 Jun 2002 18:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSF3WEu>; Sun, 30 Jun 2002 18:04:50 -0400
Received: from [64.246.18.23] ([64.246.18.23]:40083 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S313202AbSF3WEt>;
	Sun, 30 Jun 2002 18:04:49 -0400
Reply-To: <steve@tuxsoft.com>
From: "Stephen Lee" <steve@tuxsoft.com>
To: "'Ken Witherow'" <ken@krwtech.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Tyan 2460/Dual Athlon MP hangs
Date: Sun, 30 Jun 2002 17:09:16 -0500
Message-ID: <000601c22082$cd14b980$1401a8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <Pine.LNX.4.44.0206301524330.340-100000@death>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken,
	Try a different video card.  My Dual Athlon system (A7M266-D)
works like a charm with my GeForce 2 MX-400 but if I swap it with my
GeForce 3 Ti500 the system will completely shutdown at some point
(guaranteed).  This happens with the system idle or while under a load.

Steve

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ken Witherow
Sent: Sunday, June 30, 2002 2:34 PM
To: Jakob Oestergaard
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs

On Sun, 30 Jun 2002, Jakob Oestergaard wrote:

> On Sun, Jun 30, 2002 at 02:55:18PM -0400, Ken Witherow wrote:
> > [1.] One line summary of the problem:
> > Random hangs occur on dual athlon system
>
> The 2460 systems (and many other dual athlon systems) are very
sensitive
> to temperature.

seems to happen regardless of temperature. In fact, it most frequenly
happens under no load. After doing some compiling, the current
temperatures read CPU0: 131F/55C, CPU1: 136F/58C, MB: 122F/50C. At idle,
they're normally in the 114/45, 120/48, 110/43 range respectively.
Currenly at about 70 minutes of uptime with the longest being about 36
hours.

> > [2.] Full description of the problem/report:
> > Sometimes the system hangs during boot, sometimes at the console and
> > other times while I'm in X. Happens whether or not I use the
mem=nopentium
> > and noapic options. Frequently, I can't catch the OOPS because I'm
in X
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




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


