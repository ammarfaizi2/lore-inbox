Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTEHPhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTEHPhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:37:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25295 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261775AbTEHPhP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:37:15 -0400
Date: Thu, 8 May 2003 17:49:22 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <1052405215.10038.44.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0305081748030.24013-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 May 2003, Alan Cox wrote:
> On Iau, 2003-05-08 at 14:35, Bartlomiej Zolnierkiewicz wrote:
> > Yep, you are right, hwif->addressing logic is reversed, what a mess.
>
> No the problem is you keep treating it as a binary value. Addressing is
> a mode. Right now 0 is LBA28/CHS and 1 is LBA48. SATA next generation
> stuff extends this even further so will I imagine be addressing=2

You are right but currently it is a binary value.
The same goes for actual usage of drive->addressing and comment in ide.h.
--
Bartlomiej

