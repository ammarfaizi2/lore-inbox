Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292538AbSBTWJi>; Wed, 20 Feb 2002 17:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292539AbSBTWJ2>; Wed, 20 Feb 2002 17:09:28 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:44816 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S292538AbSBTWJU>;
	Wed, 20 Feb 2002 17:09:20 -0500
Date: Wed, 20 Feb 2002 23:09:12 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: now yes... 2.5.5 compile error
Message-ID: <Pine.LNX.4.44.0202202308480.11844-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5/include/linux/modversions.h  
-DKBUILD_BASENAME=vfs  -c -o vfs.o vfs.c
vfs.c: In function `presto_do_create':
vfs.c:410: structure has no member named `i_zombie'
vfs.c:414: structure has no member named `i_zombie'
vfs.c:498: structure has no member named `i_zombie'
vfs.c: In function `presto_do_link':
vfs.c:588: structure has no member named `i_zombie'
vfs.c:592: structure has no member named `i_zombie'
vfs.c:667: structure has no member named `i_zombie'
vfs.c: In function `presto_do_unlink':
vfs.c:742: structure has no member named `i_zombie'
vfs.c:746: structure has no member named `i_zombie'
vfs.c:754: structure has no member named `i_zombie'
vfs.c:761: structure has no member named `i_zombie'
vfs.c:771: structure has no member named `i_zombie'
vfs.c:806: structure has no member named `i_zombie'
vfs.c: In function `presto_do_symlink':
vfs.c:897: structure has no member named `i_zombie'
vfs.c:902: structure has no member named `i_zombie'
vfs.c:980: structure has no member named `i_zombie'
vfs.c: In function `presto_do_mkdir':
vfs.c:1059: structure has no member named `i_zombie'
vfs.c:1064: structure has no member named `i_zombie'
vfs.c:1145: structure has no member named `i_zombie'
vfs.c: In function `presto_do_rmdir':
vfs.c:1258: warning: implicit declaration of function `double_down'
vfs.c:1258: structure has no member named `i_zombie'
vfs.c:1258: structure has no member named `i_zombie'
vfs.c:1274: warning: implicit declaration of function `double_up'
vfs.c:1274: structure has no member named `i_zombie'
vfs.c:1274: structure has no member named `i_zombie'
vfs.c: In function `presto_do_mknod':
vfs.c:1361: structure has no member named `i_zombie'
vfs.c:1366: structure has no member named `i_zombie'
vfs.c:1447: structure has no member named `i_zombie'
vfs.c: In function `presto_rename_dir':
vfs.c:1643: warning: implicit declaration of function `triple_down'
vfs.c:1643: structure has no member named `i_zombie'
vfs.c:1644: structure has no member named `i_zombie'
vfs.c:1645: structure has no member named `i_zombie'
vfs.c:1648: structure has no member named `i_zombie'
vfs.c:1649: structure has no member named `i_zombie'
vfs.c:1660: warning: implicit declaration of function `triple_up'
vfs.c:1660: structure has no member named `i_zombie'
vfs.c:1661: structure has no member named `i_zombie'
vfs.c:1662: structure has no member named `i_zombie'
vfs.c:1667: structure has no member named `i_zombie'
vfs.c:1668: structure has no member named `i_zombie'
vfs.c: In function `presto_rename_other':
vfs.c:1708: structure has no member named `i_zombie'
vfs.c:1708: structure has no member named `i_zombie'
vfs.c:1714: structure has no member named `i_zombie'
vfs.c:1714: structure has no member named `i_zombie'
vfs.c: In function `lento_do_rename':
vfs.c:1773: warning: implicit declaration of function `double_lock'
make[3]: *** [vfs.o] Error 1
make[3]: Leaving directory 
`/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5/fs/intermezzo'
make[2]: *** [_modsubdir_intermezzo] Error 2
make[2]: Leaving directory `/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5/fs'
make[1]: *** [_mod_fs] Error 2
make[1]: Leaving directory `/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5'
error: Bad exit status from /home/pau/LnxZip/tmp/rpm-tmp.45153 (%build)


-- 

Pau

