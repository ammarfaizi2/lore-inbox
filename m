Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLHOWV>; Fri, 8 Dec 2000 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLHOWL>; Fri, 8 Dec 2000 09:22:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129511AbQLHOWF>; Fri, 8 Dec 2000 09:22:05 -0500
Subject: Re: Signal 11
To: davej@suse.de
Date: Fri, 8 Dec 2000 13:52:15 +0000 (GMT)
Cc: jmerkey@timpanogas.org (Jeff V. Merkey), rmager@vgkk.com (Rainer Mager),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0012080217400.12383-100000@neo.local> from "davej@suse.de" at Dec 08, 2000 02:28:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144Nwg-0003uo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Various processes have been getting random signals after heavy CPU usage.
> Playing an MPEG movie, kernel compile, or even just some small apps
> compiling sometimes. Just for the record, this isn't an OOM situation,
> I've watched this box with half its memory free or in buffers left
> unattended, and suddenly a compile will just die.

This is consistent with page cache corruption in memory. We definitely had
that in older 2.4test kernels. I saw this building stuff on Linux parisc
and it was because some page of gcc had randomly decided to become something
different. Since that was test6 I didnt figure it important 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
