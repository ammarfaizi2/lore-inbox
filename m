Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275845AbRI1Fsv>; Fri, 28 Sep 2001 01:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275846AbRI1Fsl>; Fri, 28 Sep 2001 01:48:41 -0400
Received: from oe55.law11.hotmail.com ([64.4.16.63]:45837 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275845AbRI1Fsd>;
	Fri, 28 Sep 2001 01:48:33 -0400
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: "Steven Joerger" <steven@spock.2y.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010928041519.968EA4FA00@spock>
Subject: Re: ide drive problem?
Date: Thu, 27 Sep 2001 22:44:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com>
X-OriginalArrivalTime: 28 Sep 2001 05:48:55.0728 (UTC) FILETIME=[42D0D300:01C147E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the standard response people would give you is that your IDE cable
is too long, of bad quality, or you are using a 40-pin cable instead of an
80-pin cable (although I'm pretty sure that should have been detected, and
DMA should automatically have not been used, but I heard at one point that
the code which detected this on motherboards using the vt82c686b chip didn't
really work in some cases).

That's the standard answer, but I used to get this messages on my machine as
well (I think it was back when I was trying to use my VIA chipset with
Redhat 7.1).  I don't seem to get them anymore though, but maybe that's just
because I'm trying to install distros newer than Redhat 7.1.  That makes me
think that I never had CRC errors, it was just some buggy VIA code.

I just get the dma timeout errors now with my VIA IDE controller.  I also
get them with the Promise controller (sigh...).

David Grant

----- Original Message -----
From: "Steven Joerger" <steven@spock.2y.net>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, September 27, 2001 9:02 PM
Subject: ide drive problem?


> List,
>
> When I enable support for my chipset in the kernel (via kt133) I always
get
> these messages:
>
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>
> over and over and ....
>
> Any clues to whats going on?
>
> Thanks,
> Steven Joerger
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
