Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSFCIYa>; Mon, 3 Jun 2002 04:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317310AbSFCIY3>; Mon, 3 Jun 2002 04:24:29 -0400
Received: from [62.70.58.70] ([62.70.58.70]:14800 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317309AbSFCIY2>;
	Mon, 3 Jun 2002 04:24:28 -0400
Date: Mon, 3 Jun 2002 10:24:17 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: <roy@mail.pronto.tv>
To: Derek Vadala <derek@cynicism.com>
cc: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        Tedd Hansen <tedd@konge.net>, Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.GSO.4.21.0206021721120.15478-100000@gecko.roadtoad.net>
Message-ID: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can always fake this effect by combining two 8-disk RAID-5s into a
> RAID-0. It's not technically RAID-6, but can withstand a 2-disk failure,
> although not _any_ 2-disk failure. However, it's my understanding that
> RAID-6 cannot withstand _any_ two disk failure either (see the above
> thread). 

It'll waste 9 drives, giving me a total capacity of 7n instead of 14n. 
And, by definition, RAID-6 _can_ withstand _any_ two-drive failure.

> I also suspect that the use of dual RAID-5s combined with the CPU overhead
> of ATA will kill most systems under any kind of load. For that matter, the
> 2x parity hit from RAID-6 probably wouldn't make you CPU too happy either,
> even if there was a kernel driver that implemented it.

With a 1500MHz Athlon on a typical file server where there's not much 
writes, the CPU is sitting there chrunching RC5-64 som 99,95 % of the 
time. I don't think it'll make much differnce with today's CPUs

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

