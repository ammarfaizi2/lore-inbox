Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSC3LHv>; Sat, 30 Mar 2002 06:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSC3LHm>; Sat, 30 Mar 2002 06:07:42 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:16645 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S312446AbSC3LH0>;
	Sat, 30 Mar 2002 06:07:26 -0500
Date: 30 Mar 2002 11:07:16 -0000
Message-ID: <20020330110716.28931.qmail@legolas.dynup.net>
From: rudmer@legolas.dynup.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.5-dj2 compile failure for aha152x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know I have seen this before in linux-2.5.5 and there was a patch for it, but I deleted the patch and now I can't find it anymore...

This is the error:

gcc -D__KERNEL__ -I/Upload/linux-2.5.7-dj2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE  -DKBUILD_BASENAME=aha152x -DAHA152X_STAT -DAUTOCONF -c -o aha152x.o aha152x.c
aha152x.c: In function `aha152x_internal_queue':
aha152x.c:1497: structure has no member named `address'
aha152x.c: In function `datai_run':
aha152x.c:2684: structure has no member named `address'
aha152x.c: In function `datao_run':
aha152x.c:2794: structure has no member named `address'
aha152x.c: In function `datao_end':
aha152x.c:2824: structure has no member named `address'
aha152x.c:2830: structure has no member named `address'
make[2]: *** [aha152x.o] Error 1
make[2]: Leaving directory `/Upload/linux-2.5.7-dj2/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/Upload/linux-2.5.7-dj2/drivers'
make: *** [_mod_drivers] Error 2

can someone point me to the patch, or even better, fix this in the tree?

Rudmer

PS. CC me as I am not on the list
