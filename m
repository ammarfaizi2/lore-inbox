Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267772AbTAXQjM>; Fri, 24 Jan 2003 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTAXQjM>; Fri, 24 Jan 2003 11:39:12 -0500
Received: from ns0.cobite.com ([208.222.80.10]:62474 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S267772AbTAXQjL>;
	Fri, 24 Jan 2003 11:39:11 -0500
Date: Fri, 24 Jan 2003 11:48:22 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: 2.5.59mm5, raid1 resync speed regression.
Message-ID: <Pine.LNX.4.44.0301241141540.32240-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, list,

I'm booting 2.5.59mm5 to run a database workload benchmark that I've been
running against various kernels.  I'll post those results if they are
interesting later, but I did notice that the raid1 resync is proceeding at
half the speed (at best) that it usually does (vs. 2.5.59 that is).

It currently at about 4-8 mb/sec (and falling as resync progresses),
usually at 12-15 mb/sec.

System is SMP 2xPIII 866mhz, 2GB ram, raid1 is two 15k U160 (running only
an Ultra speed :-( because the onboard controller sucks) SCSI disks, same
channel on aic7xxx.

Kernel is 2.5.59-mm5 compiled with gcc version 2.96 20000731 (Red Hat 
Linux 7.3 2.96-112)

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

