Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRAUB3q>; Sat, 20 Jan 2001 20:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRAUB3g>; Sat, 20 Jan 2001 20:29:36 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:49810 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131590AbRAUB3a>; Sat, 20 Jan 2001 20:29:30 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Is sendfile all that sexy?
Date: Sat, 20 Jan 2001 17:29:29 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKMELMNCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.10.10101201629110.10849-100000@penguin.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm _not_ seeing the point for a high-performance link to have a generic
> packet buffer.
>
> 		Linus

	Well suppose your RAID controller can take over control of disks
distributed throughout your I/O subsystem. If you assume the bandwidth of
the I/O subsystem is not the limiting factor, there's no need to hang the
disks directly off the RAID controller.

	This makes even more sense if your computer can upload code to your
peripherals which they can then run autonomously. Imagine if your filesystem
code is mobile and can reside (perhaps to a variable extent) in your drives
if you want it to.

	Of course none of this really relates to the case of the OS trying to get
peripherals to talk to each other directly.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
