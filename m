Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSAXJWu>; Thu, 24 Jan 2002 04:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSAXJWk>; Thu, 24 Jan 2002 04:22:40 -0500
Received: from [213.237.118.153] ([213.237.118.153]:9857 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S286207AbSAXJWa>;
	Thu, 24 Jan 2002 04:22:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: hot IDE change
Date: Thu, 24 Jan 2002 10:19:19 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0201232301090.1053-100000@dial-up-2.energonet.ru> <20020123170713.A17310@animx.eu.org>
In-Reply-To: <20020123170713.A17310@animx.eu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Tg2R-0001w5-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 January 2002 23:07, Wakko Warner wrote:
> > This question is more about hardware, but is also related to Linux.
> > If I have a harddisk, plugged into the motherboard (IDE cable and power),
> > can I turn it off, plugging out first power cable, then IDE cable.
> > Can it harm harddisk or motherboard?
> > If I can do it, then will Linux detect it back, if I make this
> > operation back: i.e. plug IDE cable, then power cable.
>
> I've read what everyone else has said about this.  The one guy talking
> about the pins and power has some good points.  For me, I've always yanked
> the ide cable before the power  and made sure the drive was powered and
> spinning before applying the ide cable.  I have a machine at work dedicated
> for this kind of thing.
>
> anyway, from the linux side, as others have said, make sure it's unmounted.
> On my dedicated box at work, it's nfs mounted and the ide driver is a
> module.  I'm always sure to remove the modules before removing the disk.
>
> When compiled in, it's trickier.  the source to hdparm has a script in the
> contrib directory that allows you to turn off and back on an ide
> controller. It won't do that if the disk is currently in use.  You have to
> do this before it will find another drive (ideally, turning off that
> channel, swapping drive, turning back on)  I've used this on my laptop that
> has a hotswap cdrom.

Maybe ask it to spin down before cutting the power will be even better?
Also the cable issues are not a problem if you have a controller meant for 
hotplugging (IDE RAID-controllers)

-Allan
