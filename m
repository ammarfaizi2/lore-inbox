Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130888AbRBQIYT>; Sat, 17 Feb 2001 03:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130835AbRBQIYJ>; Sat, 17 Feb 2001 03:24:09 -0500
Received: from anime.net ([63.172.78.150]:55559 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S130783AbRBQIYB>;
	Sat, 17 Feb 2001 03:24:01 -0500
Date: Sat, 17 Feb 2001 00:24:18 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: <linux-kernel@vger.kernel.org>
Subject: 3ware 6400 ATA-RAID bugs
Message-ID: <Pine.LNX.4.30.0102170023500.19065-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.1-ac15, 3ware driver.

512mb ram, amd thunderbird 1000, 3ware escalade 6400 with 2 x 45gb IBM
in raid5 mode.

'iozone 512 16384' is a guaranteed, repeatable way to totally kill this
machine.

The kernel starts spitting out a zillion of

"Warning - running *really* short on DMA buffers"

And then it starts going endlessly into a loop of

"3w-xxxx: tw_scsi_eh_abort(): Abort failed for unknown Scsi_Cmnd 0xe7da6e00, resetting card 0."

And the system is completely unresponsive, locked up.

-Dan

