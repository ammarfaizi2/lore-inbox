Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSFRTd1>; Tue, 18 Jun 2002 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFRTd0>; Tue, 18 Jun 2002 15:33:26 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33967 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317578AbSFRTdP>; Tue, 18 Jun 2002 15:33:15 -0400
Date: Tue, 18 Jun 2002 21:32:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
cc: Garet Cammer <arcolin@arcoide.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Need IDE Taskfile Access
In-Reply-To: <Pine.LNX.4.10.10206180917550.3804-100000@master.linux-ide.org>
Message-ID: <Pine.SOL.4.30.0206182120100.23983-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do not worry Garet, I will reimplement it later in 2.5.
I need some free time to do it, (maybe next month?).

On Tue, 18 Jun 2002, Andre Hedrick wrote:

>
> Garet,
>
> You are wasting electons, the interface is gone and the API to the
> transport is wrecked.  I will need to compose a loadable module to renable
> the support.  Clearly 2.5/2.6 is not friendly with the needs of the
> industry and it will never be at this rate.

Will be...

>
> In the end, I will end up writing a closed ATA binary driver for sale as a
> replacement.  I have had several requests to consider the option.  As much
> as I do not like the idea, it is less offensive than the current
> direction.

Ugh, please dont...

>
> Andre Hedrick
> LAD Storage Consulting Group
>
>
> On Tue, 18 Jun 2002, Garet Cammer wrote:
>
> > For some time now we have been writing user applications that send ATAPI commands to the IDE bus to initialize and configure our hardware RAID 1 controllers. This has been working well, thanks to Andre's patch that gave us taskfile access through the ioctl API. We were counting on it to be a permanent part of the 2.5/2.6 kernel, since there is a lot of hardware in the field using these apps.
> > Imagine our surprise when we discovered that taskfile access was being abandoned completely!
> > Although we understand that the kernel may need to filter some commands, why can't applications access at least the Smart commands? Help!
> > Regards,
> > Garet Cammer
> > Software Development
> > Arco Computer Products
> > (954) 925-2688
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

