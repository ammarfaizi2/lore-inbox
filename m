Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRHMFUu>; Mon, 13 Aug 2001 01:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHMFUk>; Mon, 13 Aug 2001 01:20:40 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:39305
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S269810AbRHMFUd>; Mon, 13 Aug 2001 01:20:33 -0400
Message-ID: <028101c123b5$f3d50040$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15Vvjz-0005k2-00@the-village.bc.nu>
Subject: Re: Lost interrupt with HPT370
Date: Sun, 12 Aug 2001 22:08:12 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just tried an HPT-366 card with IC35L040VER07 drives (latest DeskStar
41G ATA-100, although the card is only ATA-66) and could not get them to
even let me create a filesystem without hard locking the machine. This was
using 2.4.8-ac1 and 2.4.7-ac11. I wrote this off to motherboard/IDE card
compatibility (or lack thereof), but could it still be an IDE driver issue?

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Adam Huffman" <bloch@verdurin.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, August 12, 2001 6:57 AM
Subject: Re: Lost interrupt with HPT370


> > I get hde/hdg: lost interrupt messages when booting with 2.4.7/8.
> >
> > There are two IBM DTLA-307030 drives on the HPT370 interface (m/b is
> > Abit KA7-100).
> >
> > 2.4.6-ac5 (which I had been using for quite a while) does not have this
> > problem.
>
> The fixes you need to run certain HPT cards with certain drives (HPT370
> included) are not in the Linus tree. Its waiting Andre to submit the
> relevant stuff on to Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

