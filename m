Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131014AbQLJW41>; Sun, 10 Dec 2000 17:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbQLJW4H>; Sun, 10 Dec 2000 17:56:07 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:48073 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S131014AbQLJWz6>; Sun, 10 Dec 2000 17:55:58 -0500
Date: Sun, 10 Dec 2000 23:25:33 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre8 compilation errors and make oldconfig problem
Message-ID: <20001210232532.A6808@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know why but make oldconfig keeps asking this:
    ServerWorks OSB4 chipset support (CONFIG_BLK_DEV_OSB4) [N/y/?] (NEW) 

Compilation problems:
plip.c: In function `plip_init_dev':
plip.c:352: structure has no member named `next'
plip.c:357: structure has no member named `next'
plip.c:363: structure has no member named `next'

make[2]: Entering directory `/loc/x29/linux/fs/smbfs'
gcc -D__KERNEL__ -I/loc/x29/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE -DSMBFS_PARANOIA  -c -o proc.o proc.c
gcc -D__KERNEL__ -I/loc/x29/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE -DSMBFS_PARANOIA  -c -o dir.o dir.c
gcc -D__KERNEL__ -I/loc/x29/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE -DSMBFS_PARANOIA  -c -o cache.o cache.c
gcc -D__KERNEL__ -I/loc/x29/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE -DSMBFS_PARANOIA  -c -o sock.o sock.c
sock.c: In function `smb_data_ready':
sock.c:166: structure has no member named `next'
make[2]: *** [sock.o] Error 1
make[2]: Leaving directory `/loc/x29/linux/fs/smbfs'

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
