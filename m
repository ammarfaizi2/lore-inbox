Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318950AbSICVrU>; Tue, 3 Sep 2002 17:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSICVrU>; Tue, 3 Sep 2002 17:47:20 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:5250 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318950AbSICVqe>; Tue, 3 Sep 2002 17:46:34 -0400
Date: Tue, 3 Sep 2002 15:51:13 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hacksaw <hacksaw@hacksaw.org>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-Reply-To: <200209032132.g83LWKOO020742@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.44.0209031535510.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Hacksaw wrote:
> > Disk-backed raid config storage can do that just as well. I don't
> > really think a partition table is the thing you'll want in order to
> > store your raid config.
> 
> Additionally, I want the OS to be able to do what it wants with the
> disk, which may well mean logically dividing the disks presented by the
> RAID into logical partitions.

We're going cyclic. All over. I think I've made my point, and you've made 
yours. Yet I could live with my raid(s). IMO you can handle it all at the 
level of clueful hardware presenting virtual hardware to your OS.

> In fact, the two systems (RAID controller and OS) should not have
> anything to do with each other. The OS should just see disks, and the
> controller should just see raw data for it to put where ever the OS says
> to put it.

I agree for more than a hundred percent. And I think the OS shouldn't have 
to bother with disk slicing where it's not necessary.

> And yes you can resize disks, especially if you don't mind hosing the
> data thereon.

I've meant to say "physical disks". I'm happily aware of raid virtual disk 
resizing.

> > (I still wonder how often you resize your partitions, per second.)
> 
> Not often. I probably changed disk setup once a week. Even still, I want it to 
> take me almost zero time, and the RAID as a whole must remain up at all times, 
> 24/7.

Enough time to back up the stuff.

> The theory doesn't match my experience. Maybe ten years from now it
> will. But I doubt it seriously.

I'm not talking about all the stuff that's on the market right now. I'm 
talking about the good stuff which we should evolve within the next few 
years in order to get proper support for our requirements.

> In ten years I think we'll have PC's shipping with 4TiB disks that are
> still damned slow.

I'm still talking about raid here.

> And my time could include every developer. At $250 an hour, 70 idle
> developers = $17,500 for an hour of down time.

My response is: don't watch the script work.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

