Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290047AbSBKSdt>; Mon, 11 Feb 2002 13:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290056AbSBKSdj>; Mon, 11 Feb 2002 13:33:39 -0500
Received: from www.formation.com ([209.204.114.130]:5380 "EHLO
	formail.formation.com") by vger.kernel.org with ESMTP
	id <S290047AbSBKSdV>; Mon, 11 Feb 2002 13:33:21 -0500
From: "Steve Snyder" <steves@formation.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Why won't my HD do DMA I/O?
Date: Mon, 11 Feb 2002 13:30:26 -0600
Message-ID: <KMEBIOGPEGOACPDOHPEEMEAMCAAA.steves@formation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.96.1020211131841.32755E-100000@gatekeeper.tmr.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have noted this in my original post but, yes, I have enabled DMA in
the kernel:

# grep DMA /usr/src/linux-2.4.17/.config | grep -v '#'
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

Thanks for the response.


-----Original Message-----
From: Bill Davidsen [mailto:davidsen@tmr.com]
Sent: Monday, February 11, 2002 12:20 PM
To: Steve Snyder
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why won't my HD do DMA I/O?


On Fri, 8 Feb 2002, Steve Snyder wrote:

> I've got a system on which the hard disk cannot be set to use DMA.  When I
> attempt to enable DMA ("hdparm -d1 /dev/hda") on this drive, there is a
long
> time-out period, after which displaying the settings shows that DMA is
still
> not set.

You did build this kernel with DMA support in the kernel, right? For your
chipset? Vendor kernels have been known to err on the side of safty.

--
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


