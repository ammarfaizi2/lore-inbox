Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261983AbREPP1U>; Wed, 16 May 2001 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbREPP1A>; Wed, 16 May 2001 11:27:00 -0400
Received: from matrix.netsoc.tcd.ie ([134.226.83.50]:25424 "EHLO
	matrix.netsoc.tcd.ie") by vger.kernel.org with ESMTP
	id <S261983AbREPP0w>; Wed, 16 May 2001 11:26:52 -0400
Date: Wed, 16 May 2001 16:33:27 +0100
From: Mark Phalan <loop@tcd.ie>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: ide-floppy
Message-ID: <20010516163327.A11844@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: OpenBSD matrix 2.8 GENERIC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Whenever I boot (2.4.4-ac6) I get this error message if there is a zip
disk in the drive.

hdb: 98288kB, 196576 blocks, 512 sector size, hdb: 98304kB, 96/64/32 CHS,
4096 kBps, 512 sector size, 2941 rpm ide-floppy: hdb: I/O error, pc = 5a,
key = 5, asc = 24, ascq = 0

The drive seems to work fine for everything except writing large files
(>500k) - umount hangs indefinitely. This has been a problem for all the
kernels I've used since I got the drive (2.2.18, 2.2.20, 2.4.0->2.4.4-ac6
series). The ide-floppy support is compiled into the kernel but I've had
similar problems when using it as a module. The disks work perfectly on a
windows box and even worked fine when I was using the drive with windows.

Can anyone shed any light on this for me?


Thanks,

Mark Phalan


ps
Could you cc replies to this address as I am not on the mailing
list. Thanks.
