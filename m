Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSIAI4t>; Sun, 1 Sep 2002 04:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSIAI4s>; Sun, 1 Sep 2002 04:56:48 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:5585 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316582AbSIAI4r>; Sun, 1 Sep 2002 04:56:47 -0400
Message-ID: <3D71D74C.136AC5FD@wanadoo.fr>
Date: Sun, 01 Sep 2002 11:01:00 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre5 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.33 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,./.af_inet6.o.d -D__KERNEL__
-I/usr/src/kernel-source-2.5.33/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -nostdinc -iwithprefix
include -DMODULE -include
/usr/src/kernel-source-2.5.33/include/linux/modversions.h  
-DKBUILD_BASENAME=af_inet6   -c -o af_inet6.o af_inet6.c
af_inet6.c: In function `inet6_init':
af_inet6.c:666: called object is not a function
af_inet6.c:667: parse error before string constant
make[3]: *** [af_inet6.o] Erreur 1
make[3]: Leaving directory `/usr/src/kernel-source-2.5.33/net/ipv6'
make[2]: *** [ipv6] Erreur 2

---
Regards
	Jean-Luc
