Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271373AbTHPHa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 03:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272804AbTHPHa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 03:30:26 -0400
Received: from imsm072.netvigator.com ([218.102.48.126]:27370 "EHLO
	imsm072dat.netvigator.com") by vger.kernel.org with ESMTP
	id S271373AbTHPHaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 03:30:25 -0400
X-Mailer: Openwave WebEngine, version 2.8.10.1 (webedge20-101-191-105-20030415)
From: Sum <ellenyip@netvigator.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem after installing 2.6.0-test3
Date: Sat, 16 Aug 2003 15:30:22 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 8BIT
Message-Id: <20030816073022.OXNS15634.imsm072dat.netvigator.com@imailmta.netvigator.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just install the kernel 2.6.0-test3, but I can't make the modules. After I type "make modules", the error displayed as following: 

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/block/paride/pd.o
drivers/block/paride/pd.c: In function `pd_init':
drivers/block/paride/pd.c:896: warning: passing arg 1 of `blk_init_queue' from incompatible pointer type
drivers/block/paride/pd.c:896: warning: passing arg 2 of `blk_init_queue' from incompatible pointer type
drivers/block/paride/pd.c:896: too many arguments to function `blk_init_queue'
make[2]: *** [drivers/block/paride/pd.o] Error 1
make[1]: *** [drivers/block/paride] Error 2
make: *** [drivers] Error 2

When I type "make modules_install", there is also error occurred
  INSTALL drivers/atm/ambassador.ko
cp: cannot stat ¡¥drivers/atm/ambassador.ko¡¦: no such directory
make[1]: *** [drivers/atm/ambassador.ko] Error 1
make: *** [_modinst_] Error 2

And so, there is only two folder in the directory /lib/modules/2.6.0-test3 which are "build" and "kernel". I can't use the modprobe command, because the /lib/modules/2.6.0-test3/modules.dep does not exist. In the kernel folder there is only the drivers/atm existed and the atm folder is empty.

I feel very confused now. Would u please help me with it. Thanks very much.

