Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131823AbRAQKNJ>; Wed, 17 Jan 2001 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRAQKM7>; Wed, 17 Jan 2001 05:12:59 -0500
Received: from [24.65.192.120] ([24.65.192.120]:50414 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S132311AbRAQKMs>;
	Wed, 17 Jan 2001 05:12:48 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101171012.f0HACMM04543@webber.adilger.net>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <20276.979724327@redhat.com> "from David Woodhouse at Jan 17, 2001
 09:38:47 am"
To: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 17 Jan 2001 03:12:22 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> adilger@turbolinux.com said:
> >  One reason why this may NOT ever make it into the kernel is that I
> > know "kernel poking at devices" is really frowned upon. 
> 
> A possible alternative is to specify drives by serial number. 

Same thing, really.  You have to poke each drive to get the serial
number.  What if they are IDE or SCSI or FCAL or RAID array?  Probably
reading a block from a disk is safer than trying to find the drive
serial number.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
