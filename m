Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131957AbRAASD6>; Mon, 1 Jan 2001 13:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132030AbRAASDs>; Mon, 1 Jan 2001 13:03:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8463 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131957AbRAASDc>; Mon, 1 Jan 2001 13:03:32 -0500
Subject: Re: Chipsets, DVD-RAM, and timeouts....
To: axboe@suse.de (Jens Axboe)
Date: Mon, 1 Jan 2001 17:34:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andre@linux-ide.org (Andre Hedrick),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010101175005.B1650@suse.de> from "Jens Axboe" at Jan 01, 2001 05:50:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14D8qR-00015A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for FAT etc when reading. Writing is a bit more difficult, as that
> then turns out to generate a read before we can commit a dirty
> block. IMO, this type of thing does not belong in the drivers --
> we should _never_ receive request for < hard block size.

Unfortunately someone ripped the support out from 2.2 to do this, then didnt
fix it. So right now 2.4 is useless to anyone with an M/O drive.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
