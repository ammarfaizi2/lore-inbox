Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276430AbRJKOsT>; Thu, 11 Oct 2001 10:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRJKOsJ>; Thu, 11 Oct 2001 10:48:09 -0400
Received: from kiln.isn.net ([198.167.161.1]:17696 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S276430AbRJKOr6>;
	Thu, 11 Oct 2001 10:47:58 -0400
Message-ID: <3BC5B12E.1420A7FE@isn.net>
Date: Thu, 11 Oct 2001 11:48:14 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.11-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: parport modules in 2.4.12
Content-Type: multipart/mixed;
 boundary="------------605175EB304FEA9EA2D63B84"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------605175EB304FEA9EA2D63B84
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached the relevant log of make modules
cc
Garst
--------------605175EB304FEA9EA2D63B84
Content-Type: text/plain; charset=us-ascii;
 name="makemodules.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makemodules.log"

make -C parport modules
make[2]: Entering directory `/usr/src/linux/drivers/parport'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
make[2]: *** [ieee1284_ops.o] Error 1

--------------605175EB304FEA9EA2D63B84--

