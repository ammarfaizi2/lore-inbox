Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLDU0O>; Mon, 4 Dec 2000 15:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLDU0E>; Mon, 4 Dec 2000 15:26:04 -0500
Received: from windsormachine.com ([206.48.122.28]:32530 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129231AbQLDUZr>; Mon, 4 Dec 2000 15:25:47 -0500
Message-ID: <3A2BF6A2.1BD792BA@windsormachine.com>
Date: Mon, 04 Dec 2000 14:55:15 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: DMA !NOT ONLY! for triton again...
In-Reply-To: <E1430NA-000470-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, i just checked ide-dma.c, and the WDC 21600 isn't listed.  31600 is, but no
21600
I've been using the 21600 for awhile now with DMA enabled, under reasonable load,
and it seems to hold up.
Guennadi: I don't suppose you can get your hands on a different size/brand drive
long enough to plug it in, and see if it allows DMA?

Alan Cox wrote:

> Certain older WDC drives are explicitly blacklisted due to firmware bugs.
> WDC put out firmware upgrades but given no answer from them on how to be sure
> a drive was upgraded we play safe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
