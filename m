Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268807AbRG0Jva>; Fri, 27 Jul 2001 05:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268808AbRG0JvK>; Fri, 27 Jul 2001 05:51:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59909 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268807AbRG0JvI>; Fri, 27 Jul 2001 05:51:08 -0400
Subject: Re: Hard disk problem:
To: mharris@opensourceadvocate.org (Mike A. Harris)
Date: Fri, 27 Jul 2001 10:51:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.33.0107270005210.25463-100000@asdf.capslock.lan> from "Mike A. Harris" at Jul 27, 2001 12:30:32 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q4Hi-0005LE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Is this a hardware or software problem, or could it be either?
> 
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: status=0x51
> { DriveReady SeekComplete Error }
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: error=0x40
> { UncorrectableError }, LBAsect=8545004, sector=62608
> Jul 26 23:51:59 asdf kernel: end_request: I/O error, dev 03:05
> (hda), sector 62608

The uncorrectable error came from the drive itself. The sector number is in
range so I suspect its a real disk error.

Alan
