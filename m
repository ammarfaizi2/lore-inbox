Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbSI3Fkh>; Mon, 30 Sep 2002 01:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbSI3Fkh>; Mon, 30 Sep 2002 01:40:37 -0400
Received: from [210.19.28.11] ([210.19.28.11]:9345 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S261929AbSI3Fkg>; Mon, 30 Sep 2002 01:40:36 -0400
Date: Mon, 30 Sep 2002 13:55:49 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 compile error (intermezzo)
Message-Id: <20020930135549.05a8ec4a.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another compile error

make[2]: Entering directory `/usr/src/linux/fs/intermezzo'
  gcc -Wp,-MD,./.vfs.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -I/usr/src/linux/arch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux/include/linux/modversions.h   -DKBUILD_BASENAME=vfs   -c -o vfs.o vfs.c
vfs.c: In function `presto_debug_fail_blkdev':
vfs.c:134: invalid initializer
vfs.c:136: warning: implicit declaration of function `is_read_only'
vfs.c: In function `presto_do_rmdir':
vfs.c:1244: warning: implicit declaration of function `double_down'
vfs.c:1260: warning: implicit declaration of function `double_up'
vfs.c: In function `presto_rename_dir':
vfs.c:1627: warning: implicit declaration of function `triple_down'
vfs.c:1644: warning: implicit declaration of function `triple_up'
vfs.c: In function `lento_do_rename':
vfs.c:1755: warning: implicit declaration of function `double_lock'
vfs.c: In function `lento_iopen':
vfs.c:1934: called object is not a function
vfs.c:1935: parse error before string constant
make[2]: *** [vfs.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/intermezzo'
make[1]: *** [intermezzo] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [fs] Error 2

Regards,

-Ubaida-
