Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTDKUee (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTDKUd0 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:33:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36488 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261722AbTDKUdU (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:33:20 -0400
Date: Fri, 11 Apr 2003 16:47:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mike Dresser <mdresser_l@windsormachine.com>
cc: Chris Hanson <cph@zurich.ai.mit.edu>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <Pine.LNX.4.33.0304111628160.14943-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.53.0304111643480.15320@chaos>
References: <Pine.LNX.4.33.0304111628160.14943-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Mike Dresser wrote:

> On Fri, 11 Apr 2003, Chris Hanson wrote:
>
> > Using a tree (what you are calling massively parallel) for
> > distribution produces a uniform voltage drop for all of the devices,
> > and has a better worst-case voltage drop than a serial chaining
> > distribution.  The serial chain has different voltage drops for each
> > pair of disks, depending on how far down the chain they are, but the
> > worst case is very bad.
> >
>
> I do wonder how we're going to run the 46KW of power (Assuming these
> drives pull similar to the drive i just checked) down the line.
>
> Should we use solid copper bars in a bus setup?  You'll be pulling 2000
> amps off the 5v, and 3000 off the 12V.  We may wish to rethink the method
> of hooking up our 46000 watt power supply.  I suspect a bus may be a
> better way, and probably easier to setup and maintain.
>
> And much more fun when you drop a screwdriver across it.
>
> Mike

Well the "real-world" parallels at a much higher voltage. You
probably want a single power supply per drive, which eliminates
any single-point failure problems and allows you to use standard
stuff. To keep the heat-load down, you need to distribute the
drives over several large racks anyway. That allows you to get
perhaps 5 kW per rack if you use 9 racks so things are more
reasonable.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

