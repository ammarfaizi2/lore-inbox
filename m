Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLGNwl>; Thu, 7 Dec 2000 08:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLGNwc>; Thu, 7 Dec 2000 08:52:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129226AbQLGNwQ>; Thu, 7 Dec 2000 08:52:16 -0500
Subject: Re: 64bit offsets for block devices ?
To: baettig@scs.ch (Reto Baettig)
Date: Thu, 7 Dec 2000 13:24:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailinglist)
In-Reply-To: <3A2E5227.693121F@scs.ch> from "Reto Baettig" at Dec 06, 2000 06:50:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14411r-0002P4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way of getting a standardized way of doing I/O to a block
> device which could handle 64bit addresses for the block number?

Submit patches early into 2.5 to extend the block range ?

> Don't you think that we will run into problems anyway because soon there
> will be raid systems with a couple of Terrabytes of space to waste for
> mp3's ;-)

The limit is currently about 1Tb per block so yes it will eventually get us

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
