Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287577AbSAEHVK>; Sat, 5 Jan 2002 02:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287579AbSAEHVA>; Sat, 5 Jan 2002 02:21:00 -0500
Received: from 240.209-115-183-0.interbaun.com ([209.115.183.240]:44458 "EHLO
	polarbear.homenet") by vger.kernel.org with ESMTP
	id <S287577AbSAEHUt>; Sat, 5 Jan 2002 02:20:49 -0500
Message-ID: <3C36A94F.A35D1A@phys.ualberta.ca>
Date: Sat, 05 Jan 2002 00:20:47 -0700
From: Dmitri Pogosyan <pogosyan@phys.ualberta.ca>
Reply-To: pogosyan@phys.ualberta.ca
Organization: Dept of Physics, University of Alberta
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
In-Reply-To: <Pine.GSO.4.33.0201021812560.28783-100000@sweetums.bluetronic.net> <Pine.LNX.4.33.0201022010340.10236-100000@coffee.psychology.mcmaster.ca> <20020104025424.GP28238@auctionwatch.com> <3C352FAA.3AB8C520@phys.ualberta.ca> <20020104102507.A20412@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> > My new IBM 40GB   hard drive  on ide0  (alone,   master)  controller  is
> > always get set at boot
> >  to UDMA2 mode,  not UDMA5.
> > The second identical drive on onboard promise controller is getting set
> > to UDMA5
> > and runs much faster.
> >
> > I looked in BIOS setup, and BIOS sets the first ide0 drive to UDMA5,
> > which at least says that
> > cable is the correct one, and that it is linux boot which changes the
> > setting to udma2.
> >
> > Here are the related pieces of dmesg. As you see I use RH rawhide 2.4.16
> > kernel,  which is
> > something like 2.4.17-pre8,   I think
>
> Some RH kernels (may include yours) deliberately disable UDMA3, 4 and 5
> on any VIA IDE controller. I don't know why. Unpatch your kernel and
> it'll likely work.
>

Thanks, where should I look in the code to see if this is applicable to my
kernel version ?
Also RH7.2 stock 2.4.7 kernel was totally unhappy with my configuration
(VIA-IDE: chipset unknown - contact you) and DMA could not be set at all.
This was main my reason to upgrade to 2.4.16

            Regards, Dmitri


