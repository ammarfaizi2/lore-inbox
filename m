Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUJWXOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUJWXOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUJWXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:14:41 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:11017 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP id S261328AbUJWXOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:14:16 -0400
Message-Id: <200410232313.AA00003@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Sun, 24 Oct 2004 08:13:51 +0900
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.9 eepro100 warning
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update linux kernel form 2.6.8.1 to 2.6.9.
I found eepro100 warning, then I update 2.6.10-rc1, but same result.
It is only warning, I think pro100 may work fine.

==

drivers/net/eepro100.c: In function `wait_for_cmd_done':
drivers/net/eepro100.c:564: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_found1':
drivers/net/eepro100.c:749: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:750: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c:816: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:840: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:841: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `do_slow_command':
drivers/net/eepro100.c:919: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/eepro100.c:923: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/eepro100.c:925: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c:928: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/eepro100.c:930: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/eepro100.c:934: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `mdio_read':
drivers/net/eepro100.c:982: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:984: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `mdio_write':
drivers/net/eepro100.c:998: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1000: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_open':
drivers/net/eepro100.c:1056: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/eepro100.c:1075: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_resume':
drivers/net/eepro100.c:1106: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1110: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1111: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c:1119: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1120: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c:1122: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c:1132: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1133: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c:1158: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1161: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_rx_soft_reset':
drivers/net/eepro100.c:1190: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c:1201: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1202: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_timer':
drivers/net/eepro100.c:1234: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_tx_timeout':
drivers/net/eepro100.c:1403: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c:1409: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c:1431: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1436: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_start_xmit':
drivers/net/eepro100.c:1504: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c:1514: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_interrupt':
drivers/net/eepro100.c:1614: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c:1618: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/eepro100.c:1678: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/eepro100.c:1685: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_close':
drivers/net/eepro100.c:1913: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/eepro100.c:1918: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/eepro100.c:1921: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c:1922: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `speedo_get_stats':
drivers/net/eepro100.c:2006: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `set_rx_mode':
drivers/net/eepro100.c:2200: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c:2238: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c:2314: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `eepro100_suspend':
drivers/net/eepro100.c:2345: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/eepro100.c: In function `eepro100_resume':
drivers/net/eepro100.c:2369: warning: passing arg 2 of `writew' makes pointer from integer without a cast
Root device is (3, 3)
Boot sector 512 bytes.
Setup is 4735 bytes.
System is 1026 kB

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
