Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131999AbRAAQmd>; Mon, 1 Jan 2001 11:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131957AbRAAQmX>; Mon, 1 Jan 2001 11:42:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131999AbRAAQmJ>; Mon, 1 Jan 2001 11:42:09 -0500
Subject: Re: Chipsets, DVD-RAM, and timeouts....
To: andre@linux-ide.org (Andre Hedrick)
Date: Mon, 1 Jan 2001 16:12:41 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012312252220.21836-300000@master.linux-ide.org> from "Andre Hedrick" at Jan 01, 2001 12:07:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14D7Zj-00011M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	./drivers/ide/ide-cd.c
> 	./drivers/ide/ide-cd.h
> 
> 	Adds ATAPI DVD-RAM native read/write mode for any FS.

Interesting to say the least. But..

> 	mke2fs -b 2048 /dev/hdc
> 	You must format to 2048 size blocks.

FAT style FS doesnt support 2K blocks 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
