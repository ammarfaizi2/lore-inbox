Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTKXUGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTKXUGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:06:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263868AbTKXUFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:05:10 -0500
Date: Mon, 24 Nov 2003 15:05:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Larry McVoy <lm@bitmover.com>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: data from kernel.bkbits.net
In-Reply-To: <20031124192432.GA20839@work.bitmover.com>
Message-ID: <Pine.LNX.4.53.0311241459320.2333@chaos>
References: <20031124155034.GA13896@work.bitmover.com>
 <Pine.GSO.4.33.0311241405070.13188-100000@sweetums.bluetronic.net>
 <20031124192432.GA20839@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Larry McVoy wrote:

> On Mon, Nov 24, 2003 at 02:17:44PM -0500, Ricky Beam wrote:
> > On Mon, 24 Nov 2003, Larry McVoy wrote:
> > >Sorry to be short but I already said that I'd eliminated this source of
> > >error.  What did you think I was doing all weekend?
> >
> > Let me be equally short.  Your original message gave no details of what
> > debugging steps had been taken. (I can assume you would know what you're
> > doing, but frankly, I could be wrong.)  You venture a guess that the
> > system had been h4x0r3d in some inventive way to prevent your attempts
> > to recover data and proceed to paste error messages from the 3ware
> > driver that indicate a problem with the hardware (either driver bug,
> > cabling, controller, or channel on that controller) including the
> > drive itself.
> >
> > Please do not attribute to hackers what is simply a half dead drive.  So,
> > was the machine powered down for an extended period as I aluded? (to
> > preserve the machine until someone had time to look at it.)
>
> As I said, *both* drives have extensive file system problems.  No, the
> machine was not powered down for a long time, and no, neither of these
> drives are old, and no, they are not from the same factory batch (they
> aren't even the same vendor, one is a Maxtor and the other is a Seagate),
> and yes, I of course tried different cable/controller/machine combos.
>
> Any other questions?
> --
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> -

Attempt to copy the raw drive to /dev/null.  If that works, the
drive is likely okay, but the fs got fsucked up by software. You
might be able to mount the drive on a 2.4.22 machine if you have a
spare. Then you might be able to selectively copy important stuff
to another drive, after which you can make a new file-system as
a "repair".

If you can't copy the raw drive, yet you booted on a system that
uses the same driver(s) to access the disk, then you probably
have a bad drive.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


