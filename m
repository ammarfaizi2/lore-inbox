Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267777AbTAXQqo>; Fri, 24 Jan 2003 11:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTAXQqn>; Fri, 24 Jan 2003 11:46:43 -0500
Received: from dial-ctb05175.webone.com.au ([210.9.245.175]:18438 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267778AbTAXQqm>;
	Fri, 24 Jan 2003 11:46:42 -0500
Message-ID: <3E31701E.4020101@cyberone.com.au>
Date: Sat, 25 Jan 2003 03:55:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: David Mansfield <lkml@dm.cobite.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59mm5, raid1 resync speed regression.
References: <Pine.LNX.4.44.0301241141540.32240-100000@admin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield wrote:

>Hi Andrew, list,
>
>I'm booting 2.5.59mm5 to run a database workload benchmark that I've been
>running against various kernels.  I'll post those results if they are
>interesting later, but I did notice that the raid1 resync is proceeding at
>half the speed (at best) that it usually does (vs. 2.5.59 that is).
>
>It currently at about 4-8 mb/sec (and falling as resync progresses),
>usually at 12-15 mb/sec.
>
>System is SMP 2xPIII 866mhz, 2GB ram, raid1 is two 15k U160 (running only
>an Ultra speed :-( because the onboard controller sucks) SCSI disks, same
>channel on aic7xxx.
>
>Kernel is 2.5.59-mm5 compiled with gcc version 2.96 20000731 (Red Hat 
>Linux 7.3 2.96-112)
>
>David
>
Thanks for the report. Please do post any results you get.

What disk workload exactly does a RAID1 resync consist of?

Nick

