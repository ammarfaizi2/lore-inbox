Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRJOVrB>; Mon, 15 Oct 2001 17:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278454AbRJOVqv>; Mon, 15 Oct 2001 17:46:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39686 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277431AbRJOVqh>; Mon, 15 Oct 2001 17:46:37 -0400
Subject: Re: USB stability - possibly printer related
To: kkrieser_list@footballmail.com (Kevin Krieser)
Date: Mon, 15 Oct 2001 22:52:54 +0100 (BST)
Cc: stano@meduna.org (Stanislav Meduna),
        kkrieser_list@footballmail.com (Kevin Krieser),
        linux-kernel@vger.kernel.org
In-Reply-To: <NDBBLFLJADKDMBPPNBALCEJDGAAA.kkrieser_list@footballmail.com> from "Kevin Krieser" at Oct 15, 2001 07:41:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tFfK-0003V6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I will have to reboot to find this out.  However, it was the latest
> available a couple months ago when I bought the drive, and found out the
> normal BIOS for the regular IDE controllers hung the computer when it hit
> the 40GB drive during boot.

There are various ways around this. One bizarre one for Linux boxes is to
set the box to boot off a floppy, stick a boot floppy into it and then
tell the BIOS there is no IDE drive on hda. Linux for most controllers will
find it anyway
