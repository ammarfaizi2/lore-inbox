Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDIeF>; Mon, 4 Dec 2000 03:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbQLDIdz>; Mon, 4 Dec 2000 03:33:55 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:16681 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129226AbQLDIdo>; Mon, 4 Dec 2000 03:33:44 -0500
Date: Mon, 4 Dec 2000 02:03:05 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4
In-Reply-To: <3A2B163A.380E4A62@haque.net>
Message-ID: <Pine.LNX.3.96.1001204020202.19309A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Dec 2000, Mohammad A. Haque wrote:

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
> 

No, module.h needs fixing.  I guess I didn't send that one to Alan...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
