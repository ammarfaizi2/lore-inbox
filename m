Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268593AbRHBCIC>; Wed, 1 Aug 2001 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268597AbRHBCHw>; Wed, 1 Aug 2001 22:07:52 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:57267 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S268593AbRHBCHr>; Wed, 1 Aug 2001 22:07:47 -0400
Date: Thu, 2 Aug 2001 10:11:04 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@mobile.torri.linux>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        "Nadav Har'El" <nyh@math.technion.ac.il>,
        <linux-kernel@vger.kernel.org>, <agmon@techunix.technion.ac.il>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <E15S6NY-00086O-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108021006550.1389-100000@mobile.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are the AMD CPUs really geared at the silicon level for true SMP? Some
friend of mine says that just because you can pull the state pin by a
chipset to remove the CPU and start another doesn't say the CPU is really
made for SMP. It just says that they have made it work through the
chipset. I am not sure if the Intel family are really true SMP or not.

I would apprecite some feedback on this.

Stephen

On Thu, 2 Aug 2001, Alan Cox wrote:

> > the combination of the athlon mp and the amd 761 chipset will do
> > multiprocessor support without trouble... you will want to use 2.4 becuase
> > lots of devices on the boards  aren't supported by 2.2...
>
> Athlon SMP will actually not always work with 2.2. Quite a few folks
> reported problems and patches for 2.2.20pre fixes that and broke other
> stuff so got reverted.
>
> 2.4 seems to do the job nicely
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

