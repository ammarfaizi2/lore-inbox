Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292762AbSCDTnh>; Mon, 4 Mar 2002 14:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292798AbSCDTn0>; Mon, 4 Mar 2002 14:43:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:42690 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292762AbSCDTnN>; Mon, 4 Mar 2002 14:43:13 -0500
Date: Mon, 04 Mar 2002 11:44:24 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: ipslinux@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: 2.5.5 and 2.5.5-dj2 compile error
Message-ID: <19230000.1015271064@w-hlinder.des>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an 8-way SMP system which doesn't compile the 2.5.x kernel.
If I turn off CONFIG_SCSI_IPS it compiles fine. It also worked
fine with 2.4.x. 

Here is the error:

gcc -D__KERNEL__ -I/home/hlinder/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=ips  -c -o ips.o
ips.c
ips.c:143:2: #error Please convert me to Documentation/DMA-mapping.txt
ips.c: In function `ips_next':
ips.c:3784: structure has no member named `address'
ips.c:3789: structure has no member named `address'
ips.c:3798: structure has no member named `address'
ips.c: In function `ips_done':
ips.c:4473: structure has no member named `address'
ips.c:4477: structure has no member named `address'
ips.c:4494: structure has no member named `address'
ips.c:4512: structure has no member named `address'
ips.c:4525: structure has no member named `address'
make[3]: *** [ips.o] Error 1
make[3]: Leaving directory `/home/hlinder/src/linux-2.5.5/drivers/scsi'

Let me know if you want any more info.

Hanna Linder
hannal@us.ibm.com
IBM Linux Technology Center


