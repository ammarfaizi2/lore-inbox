Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319419AbSILCyk>; Wed, 11 Sep 2002 22:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319420AbSILCyk>; Wed, 11 Sep 2002 22:54:40 -0400
Received: from balthasar.nuitari.net ([216.40.249.34]:32450 "HELO
	nuitari.nuitari.net") by vger.kernel.org with SMTP
	id <S319419AbSILCyj>; Wed, 11 Sep 2002 22:54:39 -0400
Date: Thu, 12 Sep 2002 05:12:51 -0400 (EDT)
From: Nuitari <nuitari@balthasar.nuitari.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400
 and agpgart
In-Reply-To: <3D7FF444.87980B8E@bigpond.com>
Message-ID: <Pine.LNX.4.44.0209120511440.10230-100000@balthasar.nuitari.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Allan Duncan wrote:

> This is a reissue of an earlier report, and I've since done some more digging.
> 
> Up to kernel 2.4.20-pre2 there was no problem, agpgart et al ran fine etc,
> but from 2.4.20-pre4 onwards when Xwindows starts to load these modules
> I am instantly thrown back to a booting machine.
> The same kernels on a VIA MVP3 chipset box with a Matrox G200 are fine.
> 
> I have ascertained that any attempt to use agpgart triggers it.
> 
> Rather than clutter up the list with lots of log files, I've made a web page at
> http://www.users.bigpond.com/allan.d/bug/Matrox.html
> with all the info I could gather.
> 
> Any suggestions of how to improve the error messages around the failure point
> are welcome.  Nothing is written into dmesg at the time of failure.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Might be good to check with a previous bug report I posted if there are 
any similarities. My problem is that the kernel panics when opengl is used 
when I have some highmem available.


