Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131606AbQLPNol>; Sat, 16 Dec 2000 08:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131565AbQLPNob>; Sat, 16 Dec 2000 08:44:31 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:60292 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131376AbQLPNoW>;
	Sat, 16 Dec 2000 08:44:22 -0500
Message-Id: <m147H9p-000OX2C@amadeus.home.nl>
Date: Sat, 16 Dec 2000 14:13:49 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: chas@pcscs.com (Charles Wilkins)
Subject: Re: kernel software raid support
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <008201c06760$7ecd9ee0$2b6e60cf@pcscs.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <008201c06760$7ecd9ee0$2b6e60cf@pcscs.com> you wrote:

> Would anybody happen to have a current list of working patches for a
> decent implementation of software raid1 using the 2.2.18 kernel that
> employs some level of read performance that exceeds that of 1 harddisk?

This may seem odd, but it is actually not possible to get a sequential read
performance > 1 harddisk with RAID1 for single-threaded ussage patterns, given
the current on-disk structures.

I have a hack in my (2.4) tree that works around this limitation, but the
on-disk format is incompatible with the stock kernel, so it is no candidate
for inclusion...


Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
