Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315938AbSEGSva>; Tue, 7 May 2002 14:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315940AbSEGSv3>; Tue, 7 May 2002 14:51:29 -0400
Received: from pD9E23EE2.dip.t-dialin.net ([217.226.62.226]:63898 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315938AbSEGSv2>; Tue, 7 May 2002 14:51:28 -0400
Date: Tue, 7 May 2002 12:49:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Patrick Mochel <mochel@osdl.org>
cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.33.0205071053070.6307-100000@segfault.osdl.org>
Message-ID: <Pine.LNX.4.44.0205071245370.4189-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > >	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> /driverfs/class/ide/
> /driverfs/root/pci0/07.2/
> /driverfs/class/ide/0/
> /driverfs/class/ide/0/2

Why not fixing devfs for that? My root directory is messed up enough. We 
have dev, proc, tmp, ...
We might have /dev/driver or such, which doesn't make the root directory 
any fuller. (And also not to disturb the newbies any further. It's hard a 
lot to explain to a windows user why he can't remove /proc and /dev, and 
what this is supposed to be.)
This is just my opinion...

Regards,
Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

