Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130490AbQJaUz3>; Tue, 31 Oct 2000 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQJaUzT>; Tue, 31 Oct 2000 15:55:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24945 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130490AbQJaUzH>; Tue, 31 Oct 2000 15:55:07 -0500
Subject: Re: Linux-2.4.0-test10
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 31 Oct 2000 20:55:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 31, 2000 12:41:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qiR9-0008FT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, test10-final is out there now. This has no _known_ bugs that I
> consider show-stoppers, for what it's worth.

The fact power management even handling is completely broken and crashes
on unfortunately timed module unloads doesnt count ?

More importantly has the bug when you can use the proc/self/mem trick with read
to crash machines as any user via svgalib stuff been fixed ?

Questions:
	Has the O_SYNC stuff been fixed so that more than ext2 honours this
	flag ?
	What about the fact anyone can crash a box using ioctls on net
	devices and waiting for an unload - was this fixed ?

Less Critical:
	Does autofs4 work yet
	Why haven't you merged irda changes people have been sending for months 	which mean irda in 2.4test doesnt work ?
	Making ramfs work seems to not be merged

Ok so Im always on the more conservative side but the large collection of
'fixe exists isnt merged' and those 4 or 5 other issues to me count as at the
very least alarm bells.

But I have to admit it seems close to 2.4.0. Its stayed up a lot better than
I expected under load once I fixed the scsi one

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
