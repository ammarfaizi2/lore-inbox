Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264999AbSJPJzp>; Wed, 16 Oct 2002 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265000AbSJPJzo>; Wed, 16 Oct 2002 05:55:44 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:55482 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264999AbSJPJzn>; Wed, 16 Oct 2002 05:55:43 -0400
Message-Id: <4.3.2.7.2.20021016120554.00c5f2e0@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 16 Oct 2002 12:06:30 +0200
To: linux-kernel@vger.kernel.org
From: Roger While <RogerWhile@sim-basis.de>
Subject: 2.5.43 make modules fail
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDRemoteIP: 192.168.6.50
X-Return-Path: RogerWhile@sim-basis.de
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   gcc -Wp,-MD,drivers/isdn/i4l/.isdn_ppp.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
-DMODULE   -DKBUILD_BASENAME=isdn_ppp   -c -o drivers/isdn/i4l/isdn_ppp.o 
drivers/isdn/i4l/isdn_ppp.c
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_free':
drivers/isdn/i4l/isdn_ppp.c:114: warning: implicit declaration of function 
`save_flags'
drivers/isdn/i4l/isdn_ppp.c:115: warning: implicit declaration of function 
`cli'
drivers/isdn/i4l/isdn_ppp.c:122: `lp' undeclared (first use in this 
function)
drivers/isdn/i4l/isdn_ppp.c:122: (Each undeclared identifier is reported 
only once
drivers/isdn/i4l/isdn_ppp.c:122: for each function it appears in.)
drivers/isdn/i4l/isdn_ppp.c:131: warning: implicit declaration of function 
`restore_flags'
drivers/isdn/i4l/isdn_ppp.c:105: warning: `flags' might be used 
uninitialized in this function
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bind':
drivers/isdn/i4l/isdn_ppp.c:209: `lp' undeclared (first use in this 
function)
drivers/isdn/i4l/isdn_ppp.c:158: warning: `flags' might be used 
uninitialized in this function
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_init':
drivers/isdn/i4l/isdn_ppp.c:1374: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1385: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1386: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1387: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1390: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1393: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1394: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1395: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1397: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_receive':
drivers/isdn/i4l/isdn_ppp.c:1415: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1425: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1426: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1562: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1418: warning: `mp' might be used uninitialized 
in this function
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_cleanup':
drivers/isdn/i4l/isdn_ppp.c:1634: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1638: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1641: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_reassembly':
drivers/isdn/i4l/isdn_ppp.c:1693: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bundle':
drivers/isdn/i4l/isdn_ppp.c:1766: warning: implicit declaration of function 
`isdn_net_findif'
drivers/isdn/i4l/isdn_ppp.c:1766: warning: assignment makes pointer from 
integer without a cast
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_dial_slave':
drivers/isdn/i4l/isdn_ppp.c:1910: warning: assignment makes pointer from 
integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1917: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c:1921: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c:1908: warning: `sdev' might be used 
uninitialized in this function
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_hangup_slave':
drivers/isdn/i4l/isdn_ppp.c:1939: warning: assignment makes pointer from 
integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1946: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c:1937: warning: `sdev' might be used 
uninitialized in this function
make[3]: *** [drivers/isdn/i4l/isdn_ppp.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2


