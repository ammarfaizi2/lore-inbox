Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277373AbRJJTb1>; Wed, 10 Oct 2001 15:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277374AbRJJTbQ>; Wed, 10 Oct 2001 15:31:16 -0400
Received: from [160.131.145.131] ([160.131.145.131]:45841 "EHLO W20303512")
	by vger.kernel.org with ESMTP id <S277373AbRJJTbB>;
	Wed, 10 Oct 2001 15:31:01 -0400
Message-ID: <04b601c151c2$1dd491a0$839183a0@W20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110101217430.1192-100000@twin.uoregon.edu>
Subject: Re: ATA/100 Promise Board
Date: Wed, 10 Oct 2001 15:31:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Joel Jaeggli" <joelja@darkwing.uoregon.edu>
To: "Wilson" <defiler@null.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 10, 2001 3:20 PM
Subject: Re: ATA/100 Promise Board
>
> I have three fasttrack 66's and one ultra100 in the same box... at present
> it's out of pci slots, so I won't be adding more... ;)
>

Quoting from pdc202xx.c:

 *  The latest chipset code will support the following ::
 *  Three Ultra33 controllers and 12 drives.
 *  8 are UDMA supported and 4 are limited to DMA mode 2 multi-word.
 *  The 8/4 ratio is a BIOS code limit by promise.
 *
 *  UNLESS you enable "CONFIG_PDC202XX_BURST"

Does this match your experiences with that many controllers in the same box?
Thanks for the reply, by the way.



