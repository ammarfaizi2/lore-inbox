Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTEJOVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTEJOVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:21:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33671 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264244AbTEJOVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:21:18 -0400
Date: Sat, 10 May 2003 05:19:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 696] New: alsa mixer and installation problem
Message-ID: <1360000.1052569179@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=696

           Summary: alsa mixer and installation problem
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: llasaa@sohu.com


Distribution:alsa problem
Hardware Environment:via apollo pro266(via8233) 
Software Environment:redhat8.0, glibc2.3, aumix
Problem Description:

1. I use alsa driver that included in the kernel. but the hight voice(eg: mp3
,wav,but except playing cd) is shaking,sounds like radio.


2. I tried to install alsa-9.3 packages. In "alsa-driver-0.9.3" it displayed:
 
 bash-2.05b# make
...
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/root/software/audio/alsa/alsa-driver-0.9.3/include 
-I/lib/modules/2.5.69/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  hwdep32.c ioctl32.c pcm32.c
rawmidi32.c seq32.c timer32.c > .depend
In file included from /lib/modules/2.5.69/build/include/linux/irq.h:19,
                 from /lib/modules/2.5.69/build/include/asm/hardirq.h:6,
                 from /lib/modules/2.5.69/build/include/linux/interrupt.h:10,
                 from
/root/software/audio/alsa/alsa-driver-0.9.3/include/sound/timer.h:27,
                 from ../../alsa-kernel/core/ioctl32/seq32.c:25,
                 from seq32.c:2:
/lib/modules/2.5.69/build/include/asm/irq.h:16:25: irq_vectors.h: file not found
make[3]: *** [fastdep] Error 1
make[3]: Leaving directory
`/root/software/audio/alsa/alsa-driver-0.9.3/acore/ioctl32'
make[2]: *** [_sfdep_ioctl32] Error 2
make[2]: Leaving directory `/root/software/audio/alsa/alsa-driver-0.9.3/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/root/software/audio/alsa/alsa-driver-0.9.3'
make: *** [include/sndversions.h] Error 2


