Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315957AbSEGTvA>; Tue, 7 May 2002 15:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315958AbSEGTu7>; Tue, 7 May 2002 15:50:59 -0400
Received: from air-2.osdl.org ([65.201.151.6]:20367 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S315957AbSEGTu6>;
	Tue, 7 May 2002 15:50:58 -0400
Date: Tue, 7 May 2002 12:47:32 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Thunder from the hill <thunder@ngforever.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205071245370.4189-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.33.0205071238000.6307-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 May 2002, Thunder from the hill wrote:

> Hi,
> 
> > > >	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> > /driverfs/class/ide/
> > /driverfs/root/pci0/07.2/
> > /driverfs/class/ide/0/
> > /driverfs/class/ide/0/2
> 
> Why not fixing devfs for that? My root directory is messed up enough. We 
> have dev, proc, tmp, ...

For one, I am of the camp that believes devfs is unfixable. 

For two, where driverfs is mounted is irrelevant: /driverfs, /sys, 
/proc/bus are all valid places. 

Besides, who cares what's in /? You have /home, which is all that really 
matters, no? 

> We might have /dev/driver or such, which doesn't make the root directory 
> any fuller. (And also not to disturb the newbies any further. It's hard a 
> lot to explain to a windows user why he can't remove /proc and /dev, and 
> what this is supposed to be.)

So don't give them root access. Or, explain to them that they're magic, 
like the pagefile.sys file. :)

	-pat

