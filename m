Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbQLWNqz>; Sat, 23 Dec 2000 08:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbQLWNqp>; Sat, 23 Dec 2000 08:46:45 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:59863 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129737AbQLWNqa>;
	Sat, 23 Dec 2000 08:46:30 -0500
Date: Sat, 23 Dec 2000 14:00:59 +0100 (CET)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: linux-2.2.19pre3
Message-ID: <Pine.LNX.4.21.0012231358230.26427-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to build 2.2.18+pe-patch-2.2.19-3 gives:

 
/usr/bin/cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o ne2k-pci.o ne2k-pci.c
ne2k-pci.c: In function `ne2k_pci_probe':
ne2k-pci.c:246: `version' undeclared (first use in this function)
ne2k-pci.c:246: (Each undeclared identifier is reported only once
ne2k-pci.c:246: for each function it appears in.)
make[3]: *** [ne2k-pci.o] Error 1
make[3]: Leaving directory `/user2/src/linux-2.2.18/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/user2/src/linux-2.2.18/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/user2/src/linux-2.2.18/drivers'
make: *** [_dir_drivers] Error 2
 
Kees


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
