Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262206AbREQW4i>; Thu, 17 May 2001 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbREQW42>; Thu, 17 May 2001 18:56:28 -0400
Received: from [24.219.123.215] ([24.219.123.215]:4079 "EHLO
	p6dnf.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262206AbREQW4U>; Thu, 17 May 2001 18:56:20 -0400
Date: Thu, 17 May 2001 15:56:15 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernel Archive: ide-floppy
Message-ID: <Pine.LNX.4.21.0105171553200.923-100000@p6dnf.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.2/0082.html

> Whenever I boot (2.4.4-ac6) I get this error message if there is a zip
> disk in the drive.
> 
> hdb: 98288kB, 196576 blocks, 512 sector size, hdb: 98304kB, 96/64/32 CHS,
> 4096 kBps, 512 sector size, 2941 rpm ide-floppy: hdb: I/O error, pc = 5a,
> key = 5, asc = 24, ascq = 0
> 
> The drive seems to work fine for everything except writing large files
> (>500k) - umount hangs indefinitely. This has been a problem for all the
> kernels I've used since I got the drive (2.2.18, 2.2.20, 2.4.0->2.4.4-ac6
> series). The ide-floppy support is compiled into the kernel but I've had
> similar problems when using it as a module. The disks work perfectly on a
> windows box and even worked fine when I was using the drive with windows.
> 
> Can anyone shed any light on this for me?

Linux p6dnf 2.4.5-pre2 #1 SMP Thu May 17 14:46:10 PDT 2001 i686 unknown

Well I dusted of the device an chucked it into a box via handy-dandy
hotswap shuttle and..........

May 17 15:29:59
 p6dnf kernel: hdl: 98304kB, 196608 blocks, 512 sector size,
May 17 15:29:59
 p6dnf kernel: hdl: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm

Pop the module out and back in and ...

May 17 15:46:58
 p6dnf kernel: hdl: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm

As for AC patches have not gotten around to messing with, but I have a few
reported cases where stock or pre-patched linus-trees work and
pre-patched ac-trees fail...

So you got me on that one.

--
Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com






