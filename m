Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318913AbSICU3g>; Tue, 3 Sep 2002 16:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSICU3g>; Tue, 3 Sep 2002 16:29:36 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:44417 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318913AbSICU3f>; Tue, 3 Sep 2002 16:29:35 -0400
Date: Tue, 3 Sep 2002 14:34:13 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hacksaw <hacksaw@hacksaw.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-Reply-To: <200209032020.g83KKWj4019180@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.44.0209031423260.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Hacksaw wrote:
> > But why have a partition table on each of these 16 pseudo disks?
> 
> If not a partition table, then some positive indication that there is
> nothing more.

And waste a block? With correct raid organization the controller takes up 
the job of your partition table. (Yes, regardless of where it' storing 
data.)

> Because changing hardware is often quite annoying, and proprietary, and
> hard or impossible to script.

Anyway, that's news to me. Where?

> I had one RAID that could only be set up by changing things using four
> buttons on the front panel.

Well, I'm talking about a vision of replacing partition tables with 
sensible and gentle disk handling, where possible. Old technics definitely 
need some other kind of hammer, or to get replaced.

> But more importantly, I want controllers that survive total power down.

You can't get that with partition tables either. And by the way, we 
succeeded doing that at Magdeburg. Pull out the power supply, batteries, 
etc., then run away.

Yes, we need better materia. Mind the biotechnical approach. Still doesn't 
qualify as a statement for partition tables.

> Restoring a 4TiB RAID is not what I want to be doing with a department of idle 
> developers

That's why sensible raid systems do that on their own. In the meanwhile 
you can get around with the data. Mostly it's nothing more than a "find 
disk order", which is not too bad.

> Another factor is usage. I've had users who were assigned a slice of a
> RAID who asked me to divide the slice up, so that one experiment
> couldn't hose another by filling the whole logical disk.

Then give them two logical disks. Just a matter of management.

> Admittedly. But it's important to indicate the lack of a partition
> table, so the software can get on with life, rather than trying to
> determine if the partition table got scribbled on.

Yes, that's cool in case we'd possibly need one. But in the raid cases we 
should get to a position where partition tables are not just theoretically 
meaningless.

> Again, searching a huge RAID to determine the old partition is not
> something I want to spend an afternoon doing, not when I can spend a few
> blocks out of millions and have backups.

I've still not said you'd have to do that. You can have a perl script do 
your job scribbling the table together.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

