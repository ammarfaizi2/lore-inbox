Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272752AbTHENYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272754AbTHENYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:24:31 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:24562 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S272752AbTHENY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:24:29 -0400
Date: Tue, 5 Aug 2003 15:24:29 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: linux-kernel@vger.kernel.org
Subject: poor disk performance : HPT372 on Abit KD7-RAID, 2.4.22-pre10-ac1
Message-ID: <Pine.LNX.4.44.0308051500250.10621-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm experimenting with an Abit kd7-raid motherboard. One Maxtor 6Y080L0
HDD connected to each HPT372 channel. Disk performance is poor: md
synchronisation works with only 1500-1800kB/sec (raid level 1). When the
drives are connected to the VIA IDE channels, synchronisation works with
10MB/sec, as the default /proc/sys/dev/raid/speed_limit_max. (I want to
use an IDE CD-writer, so I have to connect the drives to the HPT
controller.)

Any advice, how to speed up the drives?

Additional information:
kernel is 2.4.22-pre10-ac1
HPT372 BIOS was upgraded to the latest version (2.34)
hdparm, cat /proc/ide/hpt366 reports, that the drives are working in UDMA
 mode (udma6), cable is ATA-66
lspci -n reports 1103:0004 (rev05)

I'm using an HPT374 controller in an another machine without problems.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

