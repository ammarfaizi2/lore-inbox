Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSE1JCZ>; Tue, 28 May 2002 05:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSE1JCY>; Tue, 28 May 2002 05:02:24 -0400
Received: from spook.vger.org ([213.204.128.210]:36328 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S313202AbSE1JCY>; Tue, 28 May 2002 05:02:24 -0400
Date: Tue, 28 May 2002 11:39:37 +0200 (CEST)
From: me@vger.org
To: Thunder from the hill <thunder@ngforever.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
In-Reply-To: <Pine.LNX.4.44.0205270903440.15928-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.21.0205281135040.6798-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Thunder from the hill wrote:

> Hi,
> 
> On Mon, 27 May 2002 me@vger.org wrote:
> > Ive got a machine running debian test dist and 2.4.18. The machine has
> > two promise ata100 tx2 controller cards. My question is why does the
> > devices hde to hdh use udma100 but devices hdi to hdl only use udma.
> > Note on this is that the devices hdi to hdl did i have to make myself
> > (dont know if there is some other configure possibility). All drives are
> > the same model.
> 
> Well, you found the /sbin/hdparm solution, which isn't too bad (And 
> hopefully you added it to your boot scripts). However, watch that! If the 
> mode switches back to lower UDMA modes, it doesn't support the mode 
> properly and thus was downgraded.
> 

Only thing i get, while i was stresstesting the hardware, is that DMA gets
timeouts time from time and then the DMA gets disabled (logical
realy). But nothing happens with the transfer mode and thats good.


