Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbSJXDxt>; Wed, 23 Oct 2002 23:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSJXDxt>; Wed, 23 Oct 2002 23:53:49 -0400
Received: from www.hs17.order-vault.net ([65.18.157.132]:22290 "EHLO
	hs17.order-vault.net") by vger.kernel.org with ESMTP
	id <S265308AbSJXDxp>; Wed, 23 Oct 2002 23:53:45 -0400
Message-ID: <3DB7703D.6070307@cglinux.com>
Date: Wed, 23 Oct 2002 23:59:57 -0400
From: Chris May <admin@cglinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Module Build error kernel 2.4.18-14
Content-Type: multipart/mixed;
 boundary="------------070404090706050601060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070404090706050601060306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I sent along my ver script and a output file of make modules. The gcc 
error states that there is a code error in the 
/usr/src/linux/include/asm/spinlock.h file along with errors in 
processor.h . The code assigns incorrect paramaters to functions and 
intergs are also improperly defined floats and others. Hope this helps 
... to fix these bugs....

--------------070404090706050601060306
Content-Type: text/plain;
 name="VERFILE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VERFILE"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost.localdomain 2.4.18-14 #1 Wed Sep 4 13:35:50 EDT 2002 i686 i686 i386 GNU/Linux
 
Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7) Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ide-scsi sg scsi_mod i810_audio ac97_codec soundcore nfsd lockd sunrpc autofs ds yenta_socket pcmcia_core eepro100 ipt_REJECT iptable_filter ip_tables ohci1394 ieee1394 mousedev keybdev hid input usb-uhci usbcore

--------------070404090706050601060306
Content-Type: text/plain;
 name="makemodule"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makemodule"

make -r -f tmp_include_depends all
make[1]: Entering directory `/usr/src/linux-2.4.18-14'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/usr/src/linux-2.4.18-14'
make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.18-14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.18-14/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.18-14/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.4.18-14/kernel'
make -C  drivers CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.18-14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.18-14/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.18-14/drivers'
make -C addon modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/addon'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/addon'
make -C block modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/block'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/block'
make -C cdrom modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/cdrom'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/cdrom'
make -C char modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/char'
make -C drm modules
make[3]: Entering directory `/usr/src/linux-2.4.18-14/drivers/char/drm'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/char/drm'
make -C pcmcia modules
make[3]: Entering directory `/usr/src/linux-2.4.18-14/drivers/char/pcmcia'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/char/pcmcia'
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/char'
make -C hotplug modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/hotplug'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/hotplug'
make -C ide modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/ide'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/ide'
make -C media modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/media'
make -C radio modules
make[3]: Entering directory `/usr/src/linux-2.4.18-14/drivers/media/radio'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/media/radio'
make -C video modules
make[3]: Entering directory `/usr/src/linux-2.4.18-14/drivers/media/video'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/media/video'
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/media'
make -C misc modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/misc'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/misc'
make -C net modules
make[2]: Entering directory `/usr/src/linux-2.4.18-14/drivers/net'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.18-14/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/3.2/include -DKBUILD_BASENAME=dummy  -c -o dummy.o dummy.c
make[2]: Leaving directory `/usr/src/linux-2.4.18-14/drivers/net'
make[1]: Leaving directory `/usr/src/linux-2.4.18-14/drivers'

--------------070404090706050601060306--

