Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRAaCaW>; Tue, 30 Jan 2001 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129375AbRAaCaM>; Tue, 30 Jan 2001 21:30:12 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:50928 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129305AbRAaC37>; Tue, 30 Jan 2001 21:29:59 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101310228.f0V2SmL24177@webber.adilger.net>
Subject: Re: Multiple SCSI host adapters, naming of attached devices
In-Reply-To: <20010131012207.G388@kermit.wd21.co.uk> from Michael Pacey at "Jan
 31, 2001 01:22:07 am"
To: Michael Pacey <michael@wd21.co.uk>
Date: Tue, 30 Jan 2001 19:28:47 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Pacey writes:
> But it looks like I can change the order in driver/scsi/hosts.c, though
> this is not an elegant solution :(

You can compile the "primary (rootfs)" adapter into the kernel, and load
the second adapter as a module.  This is supposed to work.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
