Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSEKVXF>; Sat, 11 May 2002 17:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSEKVXE>; Sat, 11 May 2002 17:23:04 -0400
Received: from sm14.texas.rr.com ([24.93.35.41]:51901 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S315171AbSEKVXD>;
	Sat, 11 May 2002 17:23:03 -0400
Date: Sat, 11 May 2002 16:23:03 -0500 (CDT)
From: Jeff Meininger <jeffm@boxybutgood.com>
X-X-Sender: jeffm@spaz.localdomain
To: linux-kernel@vger.kernel.org
Subject: mapping from scsi Host/Chan/Id/Lun to /dev/foo
Message-ID: <Pine.LNX.4.44.0205111609070.2589-100000@spaz.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to write a userspace program that takes Host/Chan/Id/Lun
arguments for some sort of scsi storage device and prints out the
corresponding /dev entry, if one exists.

This is easy to do with devfs... assuming SCSI 0 0 0 0, the program can 
simply look in /dev/scsi/host0/bus0/target0/lun0/ for 'cd' or 'disc', etc.

Without devfs, though, I can't figure out how to map 0 0 0 0 to /dev/scd0,
/dev/sr0, or /dev/sda, etc.

I hope I haven't missed anything obvious in the ioctl commands in the .h 
files, /proc, etc...

I'm not subscribed to LKML, so I would appreciate it if you'd Cc me in 
your reply!

Thanks!
-Jeff Meininer

