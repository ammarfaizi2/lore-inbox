Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318932AbSICVBR>; Tue, 3 Sep 2002 17:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318934AbSICVBR>; Tue, 3 Sep 2002 17:01:17 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:57473 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318933AbSICVBP>; Tue, 3 Sep 2002 17:01:15 -0400
Date: Tue, 3 Sep 2002 15:05:52 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hacksaw <hacksaw@hacksaw.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-Reply-To: <200209032050.g83Ko1CW019969@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.44.0209031456210.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Hacksaw wrote:
> > > But more importantly, I want controllers that survive total power down.
> > 
> > You can't get that with partition tables either.
> 
> WHAT? Partition tables written onto the disk certainly do survive total power 
> down.

Disk-backed raid config storage can do that just as well. I don't really 
think a partition table is the thing you'll want in order to store your 
raid config.

> Again, with an annoying controller, and having the user change their
> requirements every so often (like once a day), I do not want to change
> the RAID setup lots. The last RAID I was working with took up to an hour
> to commit geometry changes to the disk.

As mentioned -- there may still be bad hardware out there. And why can't 
the people just live with it? I mean you can't resize disks either. You 
could even assign a number of disks of different size to the users, and if 
one of them needs to get to another level of disk space, shall he. A pool 
of disks can save you resizes.

> Please describe this algorithm? Would this potentially mean looking at
> every block on the disk, including the giant logical disk that a RAID
> might present?  Even if you only have to look at the first few bytes of
> each block, this is a lot of seeking.

(I still wonder how often you resize your partitions, per second.)

I was talking about saving your time. And I've presented the theory of no 
partition tables on raid, which reduces the whole thing to backup work on 
PC, or few seeking on small disks, up to 200 GiB. Yes, currently.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

