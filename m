Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTDKUZP (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTDKUZP (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:25:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261697AbTDKUZN (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:25:13 -0400
Date: Fri, 11 Apr 2003 16:39:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Mike Dresser <mdresser_l@windsormachine.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <200304112016.h3BKG0TM001931@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0304111635140.15320@chaos>
References: <200304112016.h3BKG0TM001931@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, John Bradford wrote:

> > > Every three-connection connector supplies power to two drives.
> > >
> > >      |--------D1
> > > -----|--------D2    ________D3
> > >      |______________|_______D4
> > >                     |_______Continue
> > Here's the way I thought of it.
> >
> >                      |--x -- 3
> >        |--------X----|--x -- 3
> >        |             |--x -- 3
> >        |
> >        |             |--x -- 3
> > -------|--------X----|--x -- 3
> >        |             |--x -- 3
> >        |
> >        |             |--x -- 3
> >        |--------X----|--x -- 3
> >                      |--x -- 3
> >
> > I now have 1 + 3 + 9 = 13 splitters, giving me 27 connections, out of 1.
> > etc, etc. Same numbers I'd have doing it your way, yours would be 13
> > levels deep instead.
> >
> > I think I just went for the massively parallel method of hooking
> > these up and from there got massively lost.
>
> Now, assuming a voltage drop of 0.05V across each cable...
>
> :-)
>
> John.
>

Also the 1 ampere that each of drives take on the 12-volt line
that's 4000 amperes for 4000 drives. You need 8 parallel wires
of AWG #00 to handle that current.... and you need to get rid
of 4,000 * 12 = 48,000 watts of heat ;^


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

