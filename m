Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbSJHTmX>; Tue, 8 Oct 2002 15:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261494AbSJHTmM>; Tue, 8 Oct 2002 15:42:12 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:47259 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261477AbSJHTlu>; Tue, 8 Oct 2002 15:41:50 -0400
Message-Id: <4.3.2.7.2.20021008214311.00b4dd30@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 08 Oct 2002 21:47:21 +0200
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Build fail 2.5.41-ac1 modules
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_free':
drivers/isdn/i4l/isdn_ppp.c:114: warning: implicit declaration of function 
`save_flags'
drivers/isdn/i4l/isdn_ppp.c:115: warning: implicit declaration of function 
`cli'
drivers/isdn/i4l/isdn_ppp.c:122: `lp' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:122: (Each undeclared identifier is reported 
only once
drivers/isdn/i4l/isdn_ppp.c:122: for each function it appears in.)
drivers/isdn/i4l/isdn_ppp.c:131: warning: implicit declaration of function 
`restore_flags'
drivers/isdn/i4l/isdn_ppp.c:105: warning: `flags' might be used 
uninitialized in this function
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bind':
drivers/isdn/i4l/isdn_ppp.c:209: `lp' undeclared (first use in this function)
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

