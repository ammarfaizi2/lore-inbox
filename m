Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310249AbSCUQQj>; Thu, 21 Mar 2002 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311593AbSCUQQa>; Thu, 21 Mar 2002 11:16:30 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:61354 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S310249AbSCUQQZ>; Thu, 21 Mar 2002 11:16:25 -0500
Message-ID: <3C9A0735.8999EBB3@wanadoo.fr>
Date: Thu, 21 Mar 2002 17:15:49 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory
`/usr/src/kernel-sources-2.5.7/drivers/net/hamradio'
gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.5.7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -DMODULE -DMODVERSIONS -include
/usr/src/kernel-sources-2.5.7/include/linux/modversions.h 
-DKBUILD_BASENAME=scc  -c -o scc.o scc.c
scc.c: In function `scc_net_rx':
scc.c:1664: `dev' undeclared (first use in this function)
scc.c:1664: (Each undeclared identifier is reported only once
scc.c:1664: for each function it appears in.)
make[3]: *** [scc.o] Error 1
make[3]: Leaving directory
`/usr/src/kernel-sources-2.5.7/drivers/net/hamradio'
make[2]: *** [_modsubdir_net/hamradio] Error 2
make[2]: Leaving directory `/usr/src/kernel-sources-2.5.7/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.5.7'
make: *** [stamp-build] Error 2

-----------
Regards
	Jean-Luc
