Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129642AbQKGM3H>; Tue, 7 Nov 2000 07:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbQKGM25>; Tue, 7 Nov 2000 07:28:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129642AbQKGM2q>; Tue, 7 Nov 2000 07:28:46 -0500
Subject: Re: removable EIDE disks
To: woodey@twasystems.fsnet.co.uk (Joe Woodward)
Date: Tue, 7 Nov 2000 12:29:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000001c048ae$6132c340$6904883e@default> from "Joe Woodward" at Nov 07, 2000 11:12:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7st-0007Ly-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> works, but only if the new disk is no larger than the disk present at =
> boot time (smaller and equal capacity disks work OK).
> 
> How do I get Linux to recognise that the media in /dev/hdc has changed?

I imagine your disks are not reporting themselves as 'removable' ? If they
correctly report removable then umount/mount would do the necessary I think.
It certainly does for magneto-optical

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
