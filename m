Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSCLTLT>; Tue, 12 Mar 2002 14:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311323AbSCLTK6>; Tue, 12 Mar 2002 14:10:58 -0500
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:54421 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S311320AbSCLTKz>; Tue, 12 Mar 2002 14:10:55 -0500
Date: Tue, 12 Mar 2002 20:01:53 +0100 (CET)
From: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
To: Jeroen Geusebroek <j.geusebroek@infraxs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 & HPT370 raid
In-Reply-To: <64BA755D4BD38F4EBA330020C11C5F1C746D@infradc03.infraxs-nl.com>
Message-ID: <Pine.LNX.4.30.0203121954560.32728-100000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeroen

> I'm trying to use the raid function of my motherboard (abit vp6) which has a HPT370 controller.
> I compiled the kernel with HPTP370 support & also the support for HPT370 raid.
>
> Everything seems to be working correctly, but i don't have the /dev/ataraid devices.
> My kernel does shows it detected the harddisks correctly:

[schnipp]
>  ataraid/d0: unknown partition table
> Highpoint HPT370 Softwareraid driver for linux version 0.01
> Drive 0 is 29311 Mb
> Drive 1 is 29311 Mb
> Raid array consists of 2 drives.
[schnapp]
> Did i forget anything? Do i have to create the /dev/ataraid devices myself?

Yes, yes - http://people.redhat.com/arjanv/pdcraid/ataraidhowto.html

>From the page - "Currently, only RAID level 0 (striping) is supported, for
the Promise Fasttrak(tm) and Highpoint HPT370 series of IDE RAID
controllers." - everything else is well explained.

You may also use the closed source linux drivers from
www.highpoint-tech.com, if you need full support.

Bye

Jan-Marek

