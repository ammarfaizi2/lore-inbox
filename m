Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKLLta>; Sun, 12 Nov 2000 06:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKLLtY>; Sun, 12 Nov 2000 06:49:24 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:39176 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129239AbQKLLtG>;
	Sun, 12 Nov 2000 06:49:06 -0500
Date: Sun, 12 Nov 2000 12:49:00 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200011121149.MAA22970@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre3 doesn't compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

here is the message :

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i586 -DMODULE   -c -o sysctl_net_ax25.o sysctl_net_ax25.c
sysctl_net_ax25.c: In function `ax25_register_sysctl':
sysctl_net_ax25.c:117: warning: left-hand operand of comma expression has no
effect
sysctl_net_ax25.c:117: parse error before `;'
make[3]: *** [sysctl_net_ax25.o] Error 1
make[3]: Leaving directory `/usr/src/kernel-sources-2.4.0-test11-pre3/net/ax25'
make[2]: *** [_modsubdir_ax25] Error 2
make[2]: Leaving directory `/usr/src/kernel-sources-2.4.0-test11-pre3/net'
make[1]: *** [_mod_net] Error 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.4.0-test11-pre3'
make: *** [stamp-build] Error 2
----

Regards

		jean-luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
