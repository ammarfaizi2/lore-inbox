Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268289AbRGXRCm>; Tue, 24 Jul 2001 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268360AbRGXRCc>; Tue, 24 Jul 2001 13:02:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29705 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268289AbRGXRCV>; Tue, 24 Jul 2001 13:02:21 -0400
Subject: Re: MO-Drive under 2.4.7 usinf vfat
To: axboe@suse.de (Jens Axboe)
Date: Tue, 24 Jul 2001 18:00:50 +0100 (BST)
Cc: dougg@torque.net (Douglas Gilbert),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010724103310.L4221@suse.de> from "Jens Axboe" at Jul 24, 2001 10:33:10 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15P5YA-0000NI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> FAT oopses, right?
> 
> It will not be fixed (Logical sector size smaller than device sector
> size) directly, there needs to be support for this type of thing. For
> now folks should just use loop on top of DVD-RAM, for instance.

Oopses are bad. It means any random user can trick you into crashing your
box just by swapping media around or you crash it in error

I/O error by all means - but oops is a bug
