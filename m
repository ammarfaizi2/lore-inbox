Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132014AbQLJTk4>; Sun, 10 Dec 2000 14:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbQLJTkr>; Sun, 10 Dec 2000 14:40:47 -0500
Received: from clem.digital.net ([204.215.239.73]:40708 "EHLO clem.digital.net")
	by vger.kernel.org with ESMTP id <S132014AbQLJTki>;
	Sun, 10 Dec 2000 14:40:38 -0500
From: Pete Clements <clem@clem.digital.net>
Message-Id: <200012101910.OAA29428@clem.digital.net>
Subject: 2.4.0-t12p8 fails compile (smbfs/sock.c)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sun, 10 Dec 2000 14:10:06 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:


gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test12/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o sock.o sock.c
sock.c: In function `smb_data_ready':
sock.c:166: structure has no member named `next'
make[3]: *** [sock.o] Error 1
make[3]: Leaving directory `/sda3/usr/src/linux-2.4.0-test12/fs/smbfs'
make[2]: *** [first_rule] Error 2

-- 
Pete Clements 
clem@clem.digital.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
