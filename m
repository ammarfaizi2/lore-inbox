Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282539AbRKZUPV>; Mon, 26 Nov 2001 15:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282473AbRKZUPA>; Mon, 26 Nov 2001 15:15:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52231 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282479AbRKZUNa>; Mon, 26 Nov 2001 15:13:30 -0500
Date: Mon, 26 Nov 2001 15:07:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fdisk file size limit exceeded - 2.4.14
In-Reply-To: <u4rK7.294$%l5.6732@news.chello.be>
Message-ID: <Pine.LNX.3.96.1011126145920.27112E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, wim delvaux wrote:

> After checking the groups, I have found some referenced but no solutions to 
> the following problem.
> 
> I have a 2.4.14 kernel
> 1 IDE and 2 SCSI disks (18 GB, 20 GB and 40 GB resp.)
> 
> when I do 
> 
> fdisk /dev/sdb (-> 40 GB disk)
> and create a partion of 2GB (i,e. +2048M)
> 
> I get a file size limit exceeded.

I have seen this reported before, and no solution I can remember. However,
it's not a general problem, something about your setup triggers it. I have
partitions of hundreds of GB on RAID controllers, and 10GB of a few 20GB
ATA/100, with no problems noted.

Perhaps someone can give you a clue on this, but I can tell you that it's
not a general limitation of linux and fdisk.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

