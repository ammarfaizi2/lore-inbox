Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132315AbRAPTPP>; Tue, 16 Jan 2001 14:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132357AbRAPTOz>; Tue, 16 Jan 2001 14:14:55 -0500
Received: from cambot.suite224.net ([209.176.64.2]:27140 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S132315AbRAPTOw>;
	Tue, 16 Jan 2001 14:14:52 -0500
Message-ID: <003d01c07ff1$1bd71420$0100a8c0@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> of "Tue, 16 Jan 2001 12:04:57 EST." <3A647F39.EC62BB81@didntduck.org> <20010116182307Z131259-403+875@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 14:18:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

> And this is a problem that has plagues all PC operating systems, but has
never
> been a problem on the Macintosh.  Why?  Because the Mac was designed to
handle
> this problem, but the PC never was.

Quite true on this point.

> The Mac never enumerates its devices like the PC does (no C: D: etc, no
> /dev/sda, /dev/sdb, or anything like that).  It also remembers the boot
device
> in its EEPROM (the Startup Disk Control Panel handles this).

For ATA drives the bios handles this.

> The only way to solve this problem is the DESIGN IT INTO THE OS!  Someone
needs
> to stand up and say, "This is a problem, and I'm going to fix it."  There
needs
> to be a "device mount order database" or some kind, and all the disk
drivers
> need to access that database to determine where to put the devices it
finds.

NO! What needs to happen is:
1) the person who installs a second scsi card should read the manual BEFORE
installing it so they know how to disable the boot features if they aren't
needed,

or

2) install only one bootable scsi card, period.

 Anything else is a useless kludge that will come back and bite us in the
ass.


> The only problem is BIOS boot.  That information is, I believe, stored in
the
> ESCD, but I don't know if it's reliable enough and complete enough to be
usable
> by Linux.

It seems to work well enough.

Matthew D. Pitts
mpitts@suite224.net



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
