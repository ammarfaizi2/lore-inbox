Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbQLDMwE>; Mon, 4 Dec 2000 07:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbQLDMvx>; Mon, 4 Dec 2000 07:51:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9296 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129834AbQLDMvq>; Mon, 4 Dec 2000 07:51:46 -0500
Subject: Re: test12-pre4
To: mhaque@haque.net (Mohammad A. Haque)
Date: Mon, 4 Dec 2000 12:21:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3A2B163A.380E4A62@haque.net> from "Mohammad A. Haque" at Dec 03, 2000 10:57:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142ucX-0003mR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Was borking on dummy.c. This seemed to fix it. Verification please?
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11/include -Wall
> -Wstrict-prototypes -O6 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.0-test11/include/linux/modversions.h   -c -o dummy.o
> dummy.c
> dummy.c: In function `dummy_init_module':
> dummy.c:103: invalid type argument of `->'
> make[2]: *** [dummy.o] Error 1

Can you send me your .config and I'll double check this. "It built for me
before I sent it to Linus, honest" 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
