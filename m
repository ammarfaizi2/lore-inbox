Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130053AbQJaD1H>; Mon, 30 Oct 2000 22:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQJaD05>; Mon, 30 Oct 2000 22:26:57 -0500
Received: from newton.hartwick.edu ([147.205.85.10]:14858 "EHLO
	newton.hartwick.edu") by vger.kernel.org with ESMTP
	id <S130053AbQJaD0s>; Mon, 30 Oct 2000 22:26:48 -0500
Date: Mon, 30 Oct 2000 22:26:44 -0500
From: Decklin Foster <decklin@red-bean.com>
To: linux-kernel@vger.kernel.org
Subject: test10-pre7 compile error in ip_forward.c
Message-ID: <20001030222644.A9869@gyah.this.is.broken>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Key: 0xF1968D1B at keyring.debian.org
Organization: Imperial Mica Board
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this when I try to compile test10-pre7:

make[3]: Entering directory `/home/decklin/src/kernel/linux/net/ipv4'
gcc -D__KERNEL__ -I/home/decklin/src/kernel/linux/include -Wall
    -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
    -mpreferred-stack-boundary=2 -march=i686    -c -o route.o route.c
gcc -D__KERNEL__ -I/home/decklin/src/kernel/linux/include -Wall
    -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
    -mpreferred-stack-boundary=2 -march=i686    -c -o ip_forward.o ip_forward.c
ip_forward.c: In function `ip_forward':
ip_forward.c:139: `NET_RX_BAD' undeclared (first use in this function)
ip_forward.c:139: (Each undeclared identifier is reported only once
ip_forward.c:139: for each function it appears in.)
make[3]: *** [ip_forward.o] Error 1

-- 
There is no TRUTH. There is no REALITY. There is no CONSISTENCY. There
are no ABSOLUTE STATEMENTS. I'm very probably wrong. -- BSD fortune(6)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
