Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270319AbRHMRYo>; Mon, 13 Aug 2001 13:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270321AbRHMRYf>; Mon, 13 Aug 2001 13:24:35 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:31376
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S270319AbRHMRYT>; Mon, 13 Aug 2001 13:24:19 -0400
Message-ID: <000b01c1241c$b0cc2e60$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15WG2Z-0007Di-00@the-village.bc.nu>
Subject: Re: Lost interrupt with HPT370
Date: Mon, 13 Aug 2001 10:23:38 -0700
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

OK, I've downloaded a beta BIOS update, if that doesn't cure it I'll try
adding it to the "bad list" and let y'all know what happens.

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Monday, August 13, 2001 4:37 AM
Subject: Re: Lost interrupt with HPT370


> > I have just tried an HPT-366 card with IC35L040VER07 drives (latest
DeskStar
> > 41G ATA-100, although the card is only ATA-66) and could not get them to
> > even let me create a filesystem without hard locking the machine. This
was
> > using 2.4.8-ac1 and 2.4.7-ac11. I wrote this off to motherboard/IDE card
> > compatibility (or lack thereof), but could it still be an IDE driver
issue?
>
> Some HPT cards have problems with certain drives. I believe its a fixed
> problem in newer boards or on those with updatable firmware if you update
> the firmware itself
>
> Check your drive is in the bad_ata100_5 and bad_ata66_4 list. If not add
> it then rebuild and retry (drivers/ide/hpt366.c) - and let me know
>
> Alan
>
>
>

