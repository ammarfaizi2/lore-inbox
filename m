Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSE2NDP>; Wed, 29 May 2002 09:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSE2NDO>; Wed, 29 May 2002 09:03:14 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:61772 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S315235AbSE2NDN>; Wed, 29 May 2002 09:03:13 -0400
Date: Wed, 29 May 2002 23:47:56 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: odd timer bug, similar to VIA 686a symptoms
In-Reply-To: <1022680131.4123.210.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.05.10205292342150.3388-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2002, Alan Cox wrote:

> On Wed, 2002-05-29 at 14:18, Neale Banks wrote:
> > Does it help in that it's got a CMD640?  If not, what am I looking for?
> 
> Thats the IDE controller. Look at lspci and the bridges and see what
> they are. Those are generally the core chipset of the PC

Straight from the metaphorical horses's virtual mouth:

gull:~# lspci 
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1451 (rev ad)
00:02.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M1449 (rev b2)
00:06.0 VGA compatible controller: Chips and Technologies F65545
00:07.0 IDE interface: CMD Technology Inc PCI0640 (rev 02)

Is the "[ALi] M1451" and "[ALi] M1449" are what we are looking for here?

Thanks,
Neale.

