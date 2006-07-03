Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWGCOJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWGCOJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWGCOJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:09:27 -0400
Received: from lucidpixels.com ([66.45.37.187]:38361 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751169AbWGCOJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:09:26 -0400
Date: Mon, 3 Jul 2006 10:09:24 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: Gigabyte Quad Royal SLI Agere Gigabit Network Chip Not Supported
 Under 2.6.x?
Message-ID: <Pine.LNX.4.64.0607031001530.20402@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I do not have this motherboard currently, I am just looking at 
possible motherboards with many PCI-e slots, this one would fit nicely, 
however, it does not have a driver built-in to the kernel for the first 
gigabit nic.

README: Release Notes for ET1310 Linux Driver
v1.2.2 -------------------------------------------------------------

The ET1310 Linux Driver v1.2.2 is a driver which supports the ET1310 
Customer Evaluation Board (Revision 1.1) This driver is subject to change 
with subsequent releases.

This PCI-e adapter is also in the Gigabyte Quad Royal SLI motherboard, the 
driver did not compile for me under 2.6.17.1.  Once fixed, I was wondering 
when/if this would be merged into the mainline and/or -mm?

6.  Once unpackaged, change directory to /et131x/linux/driver:

         cd et131x/linux/driver

7.  Build the driver source code by executing the following command:

         make

The errors:

#@make -C /lib/modules/2.6.17.1/build M=/home/user/et131x_20060131_v1-2-2/et131x/linux/driver modules
make[1]: Entering directory `/usr/src/linux-2.6.17.1'
   CC [M]  /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.o
In file included from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_common.h:89,
                  from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_phy.h:90,
                  from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:111:
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:115:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:136:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:157:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:178:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:199:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:238:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:293:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:346:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:401:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:456:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:491:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:512:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:537:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:597:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:650:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:671:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:694:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:717:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:762:9: warning: "BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:785:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:808:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:831:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:854:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:936:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1005:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1026:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1047:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1070:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1093:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1138:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1159:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1182:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1205:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1226:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1269:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1290:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1313:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1336:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1357:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1465:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1500:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1525:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1549:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1570:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1591:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1618:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1653:9: warning: "BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1688:9: warning: "BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1740:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1773:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1818:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1839:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1860:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1885:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1919:9: warning: "BIT_FILEDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1944:9: warning: "BIT_FILEDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:1969:9: warning: "BIT_FILEDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2005:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2036:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2061:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2086:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2111:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2136:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2159:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2247:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2296:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2335:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2366:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2401:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2433:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2454:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2483:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2506:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2531:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2552:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2573:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2598:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2649:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2688:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2713:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2774:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:2841:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:3067:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_address_map.h:3100:9: warning: "_BIT_FIELDS_HTOL" is not defined
In file included from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_adapter.h:84,
                  from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:116:
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_tx.h:99:13: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_tx.h:195:9: warning: "_BIT_FIELDS_HTOL" is not defined
In file included from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_adapter.h:85,
                  from /home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:116:
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_rx.h:138:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_rx.h:169:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_rx.h:245:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_rx.h:284:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/ET1310_rx.h:315:9: warning: "_BIT_FIELDS_HTOL" is not defined
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:140: error: syntax error before string constant
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:140: warning: type defaults to 'int' in declaration of 'MODULE_PARM'
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:140: warning: function declaration isn't a prototype
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:140: warning: data definition has no type or storage class
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:141: error: syntax error before string constant
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:141: warning: type defaults to 'int' in declaration of 'MODULE_PARM'
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:141: warning: function declaration isn't a prototype
/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.c:141: warning: data definition has no type or storage class
make[2]: *** [/home/user/et131x_20060131_v1-2-2/et131x/linux/driver/et131x_main.o] Error 1
make[1]: *** [_module_/home/user/et131x_20060131_v1-2-2/et131x/linux/driver] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.17.1'
make: *** [modules] Error 2
