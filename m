Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbRATCSt>; Fri, 19 Jan 2001 21:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131180AbRATCSj>; Fri, 19 Jan 2001 21:18:39 -0500
Received: from d225.as5200.mesatop.com ([208.164.122.225]:17288 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S130000AbRATCSe>; Fri, 19 Jan 2001 21:18:34 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Fri, 19 Jan 2001 19:20:43 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Linux 2.4.0-ac10 build errors
MIME-Version: 1.0
Message-Id: <01011919204300.04079@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following errors building 2.4.0-ac10:
The first three digits are the line number in the build log.

855 make[3]: Entering directory `/usr/src/linux-2.4.0-ac10/drivers/acpi'
856 make[3]: warning: -jN forced in submake: disabling jobserver mode.
857 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i686  -I./include -D_LINUX  -DEXPORT_SYMTAB -c acpi_ksyms.c
858 gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i686  -I./include -D_LINUX  -c -o driver.o driver.c
859 In file included from /usr/src/linux/include/linux/module.h:21,
860                  from acpi_ksyms.c:21:
861 /usr/src/linux/include/linux/modversions.h:4: linux/modules/8390.ver: No 
such file or directory
862 /usr/src/linux/include/linux/modversions.h:5: 
linux/modules/ac97_codec.ver: No such file or directory
863 /usr/src/linux/include/linux/modversions.h:6: linux/modules/ac97.ver: No 
such file or directory
864 /usr/src/linux/include/linux/modversions.h:7: 
linux/modules/acpi_ksyms.ver: No such file or directory
865 /usr/src/linux/include/linux/modversions.h:8: linux/modules/ad1848.ver: 
No such file or directory
866 /usr/src/linux/include/linux/modversions.h:9: linux/modules/adb.ver: No 
such file or directory

[root@localhost scripts]# ./ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux localhost.localdomain 2.4.1-pre8 #1 Tue Jan 16 20:25:14 MST 2001 i686 
unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
