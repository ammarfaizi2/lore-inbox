Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQL1PP2>; Thu, 28 Dec 2000 10:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbQL1PPS>; Thu, 28 Dec 2000 10:15:18 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:24563 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129868AbQL1PPB>; Thu, 28 Dec 2000 10:15:01 -0500
Message-ID: <3A4B51AC.E27FF483@home.net>
Date: Thu, 28 Dec 2000 09:43:56 -0500
From: Shawn Starr <shawn.starr@home.net>
Reply-To: shawn.starr@home.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
Subject: Linux kernel 2.2.19ac2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dec 28 09:31:59 coredump kernel: Filesystem panic (dev 03:41).
Dec 28 09:31:59 coredump kernel:   FAT error
Dec 28 09:31:59 coredump kernel:   File system has been set read-only
Dec 28 09:31:59 coredump kernel: Directory 401: bad FAT
Dec 28 09:32:16 coredump kernel: Filesystem panic (dev 03:41).
Dec 28 09:32:16 coredump kernel:   FAT error
Dec 28 09:32:16 coredump kernel:   File system has been set read-only
Dec 28 09:32:16 coredump kernel: Directory 503: bad FAT

hmmm, there appears to be a problem with the fat or vfat driver. Im
using Windows 2000 on a different hard drive which is using FAT32 for
the filesystem.

When I rebooted into Win2k the system did not detect a corrupt FAT.

Im going to compile 2.2.19ac3 today and see if this was a known issue or
not.

I dont know what information I can give you other then what the log
shows.

Thanks,

Shawn Starr.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
