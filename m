Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132254AbQL1Bo3>; Wed, 27 Dec 2000 20:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbQL1BoU>; Wed, 27 Dec 2000 20:44:20 -0500
Received: from [24.65.192.120] ([24.65.192.120]:30966 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S132254AbQL1BoE>;
	Wed, 27 Dec 2000 20:44:04 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012280113.eBS1DUD00873@webber.adilger.net>
Subject: Re: 2.2.18 dies on my 486..
In-Reply-To: <Pine.LNX.4.31.0012220359540.666-100000@asdf.capslock.lan>
 "from Mike A. Harris at Dec 27, 2000 08:05:25 pm"
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Date: Wed, 27 Dec 2000 18:13:30 -0700 (MST)
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Harris writes:
> I just upgraded my 486 firewall's kernel to pure 2.2.18 from
> 2.2.17, with no other changes, and now it dies with all sorts
> of hard disk failures.
> 
> I get:
> 
> hdb: lost interrupt
> 
> And stuff about DRQ lost...

Is it possible you compiled the kernel with gcc 2.95.2?  I've been having
a similar problem, but I'm having trouble tracking it down.  Because I
normally use a very heavily modified 2.2.18 kernel, I'm trying to isolate
just where the problem is - I have no problems with a stock 2.2.18 kernel.
If I compile with gcc 2.7.2.3 it works fine.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
