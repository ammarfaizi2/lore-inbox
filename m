Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286553AbRL0TyN>; Thu, 27 Dec 2001 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286556AbRL0TyG>; Thu, 27 Dec 2001 14:54:06 -0500
Received: from bzq-165-60.dsl.bezeqint.net ([62.219.165.60]:11026 "HELO
	the.linux-dude.net") by vger.kernel.org with SMTP
	id <S286553AbRL0Txq>; Thu, 27 Dec 2001 14:53:46 -0500
Date: Thu, 27 Dec 2001 21:53:40 +0200 (IST)
From: Ido Diamant <ido@the.linux-dude.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: James Stevenson <mistral@stev.org>, <jlladono@pie.xtec.es>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <20011227195101.5bf120f9.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0112272149220.18231-100000@the.linux-dude.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having an old Pentium 120, with an old BIOS.
I got new 40GB hard disk, and in order to make it readable, I needed to
use the cable-select jumper in order to make the hard disk look smaller
for the bios.
The only problem is that the linux recognizes my hard drive as 33GB (maybe
its 32 as you said). will what you said about disabling the hard disk
recognision at the BIOS help me?
I don't want to play with the BIOS for nothing, so please let me know.

 Thanks,
   Ido

On Thu, 27 Dec 2001, Stephan von Krawczynski wrote:

> On Thu, 27 Dec 2001 13:14:43 -0000
> "James Stevenson" <mistral@stev.org> wrote:
>
> > > I tried this one some time ago, and had to find out, that I was not able
> > to
> > > write to the upper cylinders of the disk. You can check this out _before_
> > using
> > > the drive via dd from /dev/zero to your /dev/drive and look at the
> > results.
> >
> > it seems to work fine for me.
> > could it be possible that the chipset that you are using does not support
> > disks bigger than 32GB ?
>
> I don't know. I tried once with
>
> 00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
>
> and it did not work. I could definitely not write beyond the 32 GB border. I
> replaced the mobo then.
>
> Regards,
> Stephan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

