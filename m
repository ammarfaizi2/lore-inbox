Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRA3UPn>; Tue, 30 Jan 2001 15:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbRA3UPd>; Tue, 30 Jan 2001 15:15:33 -0500
Received: from garnet.tc.umn.edu ([160.94.218.249]:42727 "EHLO
	garnet.tc.umn.edu") by vger.kernel.org with ESMTP
	id <S129881AbRA3UPX>; Tue, 30 Jan 2001 15:15:23 -0500
Date: Tue, 30 Jan 2001 14:15:20 -0600 (CST)
From: Jason Michaelson <micha044@tc.umn.edu>
To: linux-kernel@vger.kernel.org
Subject: unresolved symbol in 2.4.1 depmod.
Message-Id: <Pine.SOL.4.20.0101301409420.20128-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings. I've just procured myself a copy of 2.4.1, and tried to build
it. At the tail end of a make modules_install, the following error occurs:

depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/drivers/md/md.o
depmod:         name_to_kdev_t

My first assumption was that this occurred because I'm running 2.2.15 with
a collection of patches. Except I've never seen this happen before with
upgrades.

Thanks,

jdm

--------
Jason D. Michaelson          | Debian GNU/      o http://www.debian.org
micha044@tc.umn.edu          |         __
ares0@geocities.com          |        / /    __  _  _  _  _ __  __
Jason.Michaelson@veritas.com |       / /__  / / / \// //_// \ \/ /
(651)604-7263                |      /____/ /_/ /_/\/ /___/  /_/\_\
http://www.tc.umn.edu/       |
~micha044                    |   ...because lockups are for convicts...


Converting Oxygen into Carbon Dioxide since 1977.

Getting a SCSI chain working is perfectly simple if you remember that
there must be exactly three terminations: one on one end of the cable, one
on the other end, and the goat, terminated over the SCSI chain with
a silver-handled knife whilst burning *black* candles. --- Anthony
DeBoer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
