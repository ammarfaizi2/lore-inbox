Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLGO7E>; Thu, 7 Dec 2000 09:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGO6x>; Thu, 7 Dec 2000 09:58:53 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:42256 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129414AbQLGO6m>; Thu, 7 Dec 2000 09:58:42 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Thu, 7 Dec 2000 07:27:55 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, scole@lanl.gov
In-Reply-To: <E14415o-0002PJ-00@the-village.bc.nu>
In-Reply-To: <E14415o-0002PJ-00@the-village.bc.nu>
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
MIME-Version: 1.0
Message-Id: <00120707275500.00924@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 December 2000 06:28, Alan Cox wrote:
> > I copied the cs46xx.c driver from 2.4.0-test11 to 2.4.0-test11-ac1,
> > rebuilt, and I got a test11-ac1 kernel which works with KDE 2.0 and
> > sound.
>
> Excellent, that really narrows it down. Once 2.2.18 is out I will try and
> get to the bottom of this

Linus Torvalds wrote:
>The only reason for this pre7 is to resolve some warring patches in the
>cs46xx driver.

It looks like cs46xx version 1.10 is a winner.

Crystal 4280/461x + AC97 Audio, version 1.10, 07:08:39 Dec  7 2000
cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
cs461x: Unknown card (1028:0096) at 0xf8ffe000/0xf8e00000, IRQ 18
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)

The cs46xx driver in test12-pre7 by Nils Faerber, Thomas Woller, et al works 
great with my troublesome Dell 420.  I'm now listening to music on the CD, 
running KDE 2.0 with the machine booted up on 2.4.0-test12-pre7.

Many thanks to all who helped with this.

Steven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
