Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSAQU23>; Thu, 17 Jan 2002 15:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290445AbSAQU2T>; Thu, 17 Jan 2002 15:28:19 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:59913 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289842AbSAQU2H>; Thu, 17 Jan 2002 15:28:07 -0500
Date: Sat, 19 Jan 2002 04:16:15 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: 2.4.18-pre4 can't compile cs4281m.c
Message-ID: <Pine.LNX.4.43.0201190409370.1165-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/18/2002
 04:15:43 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/18/2002
 04:28:03 AM,
	Serialize complete at 01/18/2002 04:28:03 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any patch for this? Sorry if there's already one posted, but I couldn't
find it.

Thanks,
Jeff


make[3]: Entering directory `/v6/src/2418p4/linux/drivers/sound/cs4281'
gcc -D__KERNEL__ -I/v6/src/2418p4/linux/include -Wall -Wstrict-prototypes
-Wno-
rigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpref
rred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include
/v6/src/2418p
/linux/include/linux/modversions.h  -DKBUILD_BASENAME=cs4281m  -c -o cs4281m.o
s4281m.c
cs4281m.c:100: cs4281_wrapper.h: No such file or directory
cs4281m.c: In function `dealloc_dmabuf':
cs4281m.c:1757: warning: implicit declaration of function `cs4x_mem_map_unresee'
cs4281m.c: In function `prog_dmabuf':
cs4281m.c:1816: warning: implicit declaration of function `cs4x_mem_map_reserve
cs4281m.c: At top level:
cs4281m.c:4611: `cs4281_null_suspend' undeclared here (not in a function)
cs4281m.c:4611: initializer element is not constant
cs4281m.c:4611: (near initialization for `cs4281_pci_driver.suspend')
cs4281m.c:4612: `cs4281_null_resume' undeclared here (not in a function)
cs4281m.c:4612: initializer element is not constant
cs4281m.c:4612: (near initialization for `cs4281_pci_driver.resume')
cs4281m.c:4613: initializer element is not constant
cs4281m.c:4613: (near initialization for `cs4281_pci_driver')
cs4281m.c:4613: initializer element is not constant
cs4281m.c:4613: (near initialization for `cs4281_pci_driver')
make[3]: *** [cs4281m.o] Error 1
make[3]: Leaving directory `/v6/src/2418p4/linux/drivers/sound/cs4281'
make[2]: *** [_modsubdir_cs4281] Error 2
make[2]: Leaving directory `/v6/src/2418p4/linux/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/v6/src/2418p4/linux/drivers'
make: *** [_mod_drivers] Error 2


