Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQL4d>; Fri, 17 Nov 2000 06:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbQKQL4X>; Fri, 17 Nov 2000 06:56:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19548 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129097AbQKQL4N>; Fri, 17 Nov 2000 06:56:13 -0500
Subject: Re: How to add a drive to DMA black list?
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Fri, 17 Nov 2000 11:26:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20001117105359.00adbec0@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Nov 17, 2000 11:03:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wjex-0000XQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drive problem, considering that another ide drive on the same controller 
> works fine with DMA enabled (a QUANTUM TRB850A) while the Conner 
> Peripherals 1275MB - CFS1275A fails with DMA enabled. They are in fact both 

And the Conner drives work fine on a VIA MVP3 it seems. You need to try
the drive with multiple controllers to be sure its not a PIIX bug that only
trips on that drive (or indeed a bug in the combination)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
