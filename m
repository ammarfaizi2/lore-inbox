Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbQJ2UcM>; Sun, 29 Oct 2000 15:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129253AbQJ2UcC>; Sun, 29 Oct 2000 15:32:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129134AbQJ2Uby>; Sun, 29 Oct 2000 15:31:54 -0500
Subject: Re: page->mapping == 0
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 29 Oct 2000 20:32:00 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        paulus@linuxcare.com.au (Paul Mackerras), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0010291308260.27484-100000@weyl.math.psu.edu> from "Alexander Viro" at Oct 29, 2000 01:32:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pz7a-0006JY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would expect problems with truncate, mmap, rename, POSIX locks, fasync,
> ptrace and mount go unnoticed for _long_. Ditto for parts of procfs

Well the ptrace one still has mysteriously breaks usermode linux against it
on my list here. Was that ever explained. It looked like the stack got corrupted
which is weird.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
