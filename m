Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130256AbQKFVcJ>; Mon, 6 Nov 2000 16:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbQKFVb7>; Mon, 6 Nov 2000 16:31:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1028 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130256AbQKFVb4>; Mon, 6 Nov 2000 16:31:56 -0500
Date: Mon, 6 Nov 2000 16:31:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: linux 2.4.0-test9
Message-ID: <Pine.LNX.3.95.1001106162033.212A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.4.0-test9 can be built and booted via initrd when running
a 2.2.17 kernel.

However when running, the new kernel 2.4.0-test9, can't be used to
make a usable initrd ram disk. The result being that 2.4.0-test9
can't, itself, build an "initrd" bootable system.

Before everybody screams that I don't know what I'm doing, let me
assure you that I know that the two kernels put their modules in
different directories and the new directory scheme seems to require
the latest and greatest version of modutils.

I have two ways of building an initial RAM disk (they both use
scripts, not provided with any distribution). One uses the loop-device
and the other uses the RAM disk directly. Because of previous
problems, on some kernel versions, with the loop device (it was
being mucked with for encription), I exclusively use the RAM disk
to build initrd.

Therefore, the problem seems to be that 2.4.0-test9 has a problem
with the RAM Disk.


Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
