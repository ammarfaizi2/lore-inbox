Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129960AbQK1DAa>; Mon, 27 Nov 2000 22:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130232AbQK1DAU>; Mon, 27 Nov 2000 22:00:20 -0500
Received: from clem.digital.net ([204.215.239.73]:16403 "EHLO clem.digital.net")
        by vger.kernel.org with ESMTP id <S129960AbQK1DAG>;
        Mon, 27 Nov 2000 22:00:06 -0500
From: Pete Clements <clem@clem.digital.net>
Message-Id: <200011280230.VAA12126@clem.digital.net>
Subject: 2.4.0-test12pre1 fails compile (vmscan.c)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Mon, 27 Nov 2000 21:30:01 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test12/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o vmscan.o vmscan.c
vmscan.c: In function `try_to_swap_out':
vmscan.c:199: duplicate label `out_failed'
make[2]: *** [vmscan.o] Error 1
make[2]: Leaving directory `/sda3/usr/src/linux-2.4.0-test12/mm'

-- 
Pete Clements 
clem@clem.digital.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
