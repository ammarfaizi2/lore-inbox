Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131662AbRBNVh4>; Wed, 14 Feb 2001 16:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131668AbRBNVhq>; Wed, 14 Feb 2001 16:37:46 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:3844 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S131662AbRBNVhe>; Wed, 14 Feb 2001 16:37:34 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200102142137.NAA01678@cx518206-b.irvn1.occa.home.com>
Subject: Re: IDE DMA Problems...system hangs
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 14 Feb 2001 13:37:26 -0800 (PST)
Cc: jsidhu@arraycomm.com (Jasmeet Sidhu), linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <E14T8XO-0005wN-00@the-village.bc.nu> from "Alan Cox" at Feb 14, 2001 08:28:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote: 
>> Feb 13 05:23:27 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
>> SeekComplete Error }
>> Feb 13 05:23:27 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
>> BadCRC }
> 
>You have inadequate cabling. CRC errors are indications of that. Make sure you
>are using sufficiently short cables for ATA33 and proper 80pin ATA66 cables.

I've had cases (on VIA chipsets) where, even or ATA33, a 40-pin cable
caused CRC errors for ATA33 and an 80-pin cable fixed things. (The same
40-pin cable does ATA33 without problems on an AMD 750 or an Intel BX,
though.)

IIRC, Andre Hedrick has said in the past that a marginal PSU or
motherboard can also cause CRC errors.

-Barry K. Nathan <barryn@pobox.com>
