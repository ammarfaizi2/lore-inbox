Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273701AbRIQVhy>; Mon, 17 Sep 2001 17:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273702AbRIQVhf>; Mon, 17 Sep 2001 17:37:35 -0400
Received: from forge.redmondlinux.org ([209.81.49.42]:47330 "EHLO
	forge.redmondlinux.org") by vger.kernel.org with ESMTP
	id <S273701AbRIQVhY>; Mon, 17 Sep 2001 17:37:24 -0400
Date: Mon, 17 Sep 2001 14:39:32 -0700 (PDT)
From: Joseph Cheek <joseph@cheek.com>
To: mrsam@courier-mta.com
cc: linux-kernel@vger.kernel.org
Subject: ide zip 100 won't mount
Message-ID: <Pine.LNX.4.10.10109171434550.9815-100000@forge.redmondlinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've tried 2.4.7-ac10 and 2.4.9-ac10.  same results.  at boot i get:

Sep 17 11:02:48 seattle kernel: ide-floppy driver 0.97.sv
Sep 17 11:02:48 seattle kernel: hdd: No disk in drive
Sep 17 11:02:48 seattle kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512
sector size, 2941 rpm

looks good, right?  but i put a disk in and i get:

Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc =  0, key =
2, asc = 30, ascq =  0
Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc = 1b, key =
2, asc = 30, ascq =  0
Sep 17 14:36:23 seattle kernel: hdd: No disk in drive

not hardware, as it works in windows on the same machine.

any ideas?

thanks!

joe

