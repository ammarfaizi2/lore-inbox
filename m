Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131922AbQKQLWF>; Fri, 17 Nov 2000 06:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132003AbQKQLVz>; Fri, 17 Nov 2000 06:21:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16218 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131922AbQKQLVs>; Fri, 17 Nov 2000 06:21:48 -0500
Subject: Re: How to add a drive to DMA black list?
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Fri, 17 Nov 2000 10:52:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.0.25.2.20001116182436.00ab3160@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Nov 17, 2000 12:13:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wj7l-0000US-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried adding the string that is output for the bad drive by hdparm -i 
> into drivers/ide/ide-dma.c::drive_blacklist and 
> drivers/ide/ide-dma.c::bad_dma_drives but the kernel still says that it is 
> using DMA and the kernel hangs after displaying:

The black list is for drives with problems, not for controller bugs. Controller
bugs in the Linux code just have to be fixed.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
