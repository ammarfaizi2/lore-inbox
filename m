Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKQD0q>; Thu, 16 Nov 2000 22:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQD0h>; Thu, 16 Nov 2000 22:26:37 -0500
Received: from clem.digital.net ([204.215.239.73]:7180 "EHLO clem.digital.net")
	by vger.kernel.org with ESMTP id <S129145AbQKQD01>;
	Thu, 16 Nov 2000 22:26:27 -0500
From: Pete Clements <clem@clem.digital.net>
Message-Id: <200011170256.VAA10669@clem.digital.net>
Subject: 2.4.0-test11-pre6 fails compile (dev.c)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Thu, 16 Nov 2000 21:56:23 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o dev.o dev.c
dev.c: In function `run_sbin_hotplug':
dev.c:2736: `hotplug_path' undeclared (first use in this function)
dev.c:2736: (Each undeclared identifier is reported only once
dev.c:2736: for each function it appears in.)
make[3]: *** [dev.o] Error 1
make[3]: Leaving directory `/sda3/usr/src/linux-2.4.0-test11/net/core'
make[2]: *** [first_rule] Error 2

-- 
Pete Clements 
clem@clem.digital.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
