Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278483AbRJPAz2>; Mon, 15 Oct 2001 20:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278484AbRJPAzT>; Mon, 15 Oct 2001 20:55:19 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:3846 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S278483AbRJPAzC>; Mon, 15 Oct 2001 20:55:02 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200110160055.f9G0tXs00314@wildsau.idv-edu.uni-linz.ac.at>
Subject: 2.4.12 compilation fails ieee1284
To: linux-kernel@vger.kernel.org
Date: Tue, 16 Oct 2001 01:55:33 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/data/root/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /data/root/linux/include/linux/modversions.h   -c -o ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/data/root/linux/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/data/root/linux/drivers'
make: *** [_mod_drivers] Error 2



no idea how to fix it (too late/too tired too).

