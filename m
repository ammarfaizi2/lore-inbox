Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSLMR6e>; Fri, 13 Dec 2002 12:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSLMR6e>; Fri, 13 Dec 2002 12:58:34 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:61192 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265190AbSLMR6d>; Fri, 13 Dec 2002 12:58:33 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <002c01c2a2d1$eb3d1a70$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Vojtech Pavlik" <vojtech@suse.cz>, "Pavel Machek" <pavel@suse.cz>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Petr Sebor" <petr@scssoft.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <021401c2a05d$f1c72c80$551b71c3@krlis> <1039540202.14251.43.camel@irongate.swansea.linux.org.uk> <039d01c2a0ab$b19a5ad0$551b71c3@krlis> <1039569643.14166.105.camel@irongate.swansea.linux.org.uk> <20021211210416.A506@ucw.cz> <20021212181250.GB184@elf.ucw.cz> <20021213154156.A6001@ucw.cz>
Subject: Re: IDE feature request & problem
Date: Fri, 13 Dec 2002 19:03:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Power Supply is not problem for sure,
there are 1x 420 W and 3x 300W HotSwap,
so I think its enough for it.
    Milan
----- Original Message -----
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>; "Alan Cox"
<alan@lxorguk.ukuu.org.uk>; "Milan Roubal"
<roubm9am@barbora.ms.mff.cuni.cz>; "Petr Sebor" <petr@scssoft.com>; "Linux
Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Friday, December 13, 2002 3:41 PM
Subject: Re: IDE feature request & problem


> On Thu, Dec 12, 2002 at 07:12:50PM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > > I have got xfs partition and man fsck.xfs say
> > > > > that it will run automatically on reboot.
> > > >
> > > > You need to force one. Something (I assume XFS) asked the disk for a
> > > > stupid sector number. Thats mostly likely due to some kind of
internal
> > > > corruption on the XFS
> > >
> > > Or the power supply doesn't give enough power to the drives anymore
(my
> > > 350W PSU is having heavy problems with five or more drives), and the
IDE
> > > transfers get garbled. Note that there is no CRC protection for
non-data
> > > xfers even when UDMA is in use, which includes LBA sector addressing.
> >
> > But kernel would not log bogus LBA in such case.
>
> It could, if the drive has read a different sector than it was supposed
> to and the filesystem got confused by the data ...
>
> --
> Vojtech Pavlik
> SuSE Labs

