Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbSJBXLM>; Wed, 2 Oct 2002 19:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262669AbSJBXLM>; Wed, 2 Oct 2002 19:11:12 -0400
Received: from cp44749-a.roemd1.lb.home.nl ([217.121.99.54]:3582 "EHLO
	garion.edsons.demon.nl") by vger.kernel.org with ESMTP
	id <S262639AbSJBXLI>; Wed, 2 Oct 2002 19:11:08 -0400
Message-ID: <3D9B7F51.9090209@edsons.demon.nl>
Date: Thu, 03 Oct 2002 01:20:49 +0200
From: Rudy Zijlstra <rudy@edsons.demon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: compile errors on 2.5.40 - modules ieee1394 and i20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from a compilation session on 2.5.40

ieee1394: Y
all suboptions of 1394 as modules.

make[2]: Entering directory `/usr/src/linux-2.5.40/drivers/ieee1394'
  gcc -Wp,-MD,./.pcilynx.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=pcilynx   -c -o pcilynx.o pcilynx.c
In file included from pcilynx.c:41:
drivers/ieee1394/ieee1394_core.h:72: parse error before `task_queue'
drivers/ieee1394/ieee1394_core.h:72: warning: no semicolon at end of 
struct or union
drivers/ieee1394/ieee1394_core.h:78: parse error before `}'
drivers/ieee1394/ieee1394_core.h: In function `driver_packet':
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:82: warning: type defaults to `int' in 
declaration of `__mptr'
drivers/ieee1394/ieee1394_core.h:82: warning: initialization from 
incompatible pointer type
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:83: warning: control reaches end of 
non-void function
drivers/ieee1394/pcilynx.c: In function `send_next':
drivers/ieee1394/pcilynx.c:471: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:472: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:473: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:474: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:475: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:486: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:486: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:490: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:493: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:495: warning: unreachable code at beginning 
of switch statement
drivers/ieee1394/pcilynx.c:505: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c: In function `lynx_transmit':
drivers/ieee1394/pcilynx.c:521: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:522: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:527: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:536: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:530: warning: unreachable code at beginning 
of switch statement
drivers/ieee1394/pcilynx.c:541: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:542: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:543: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:548: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:549: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:550: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c: In function `lynx_devctl':
drivers/ieee1394/pcilynx.c:625: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:563: warning: `packet' might be used 
uninitialized in this function
drivers/ieee1394/pcilynx.c: In function `lynx_irq_handler':
drivers/ieee1394/pcilynx.c:1128: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1131: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1132: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1134: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1160: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1163: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1164: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1166: dereferencing pointer to incomplete type
drivers/ieee1394/pcilynx.c:1121: warning: `packet' might be used 
uninitialized in this function
drivers/ieee1394/pcilynx.c:1155: warning: `packet' might be used 
uninitialized in this function
  gcc -Wp,-MD,./.ohci1394.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=ohci1394 -DEXPORT_SYMTAB  -c -o 
ohci1394.o ohci1394.c
In file included from ohci1394.c:116:
drivers/ieee1394/ieee1394_core.h:72: parse error before `task_queue'
drivers/ieee1394/ieee1394_core.h:72: warning: no semicolon at end of 
struct or union
drivers/ieee1394/ieee1394_core.h:78: parse error before `}'
drivers/ieee1394/ieee1394_core.h: In function `driver_packet':
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:82: warning: type defaults to `int' in 
declaration of `__mptr'
drivers/ieee1394/ieee1394_core.h:82: warning: initialization from 
incompatible pointer type
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:83: warning: control reaches end of 
non-void function
drivers/ieee1394/ohci1394.c: In function `insert_packet':
drivers/ieee1394/ohci1394.c:636: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:636: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:638: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:640: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:641: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:643: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:644: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:646: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:647: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:648: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:649: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:654: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:662: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:667: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:668: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:673: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:673: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:677: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:678: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:690: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:696: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:703: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:713: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:714: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:715: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:726: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:728: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:729: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:758: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c: In function `dma_trm_flush':
drivers/ieee1394/ohci1394.c:778: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:783: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:771: warning: `z' might be used 
uninitialized in this function
drivers/ieee1394/ohci1394.c: In function `ohci_transmit':
drivers/ieee1394/ohci1394.c:816: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:818: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:824: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:831: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c: In function `dma_trm_reset':
drivers/ieee1394/ohci1394.c:1018: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c: In function `dma_trm_tasklet':
drivers/ieee1394/ohci1394.c:1461: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:1462: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:1512: dereferencing pointer to incomplete type
drivers/ieee1394/ohci1394.c:1452: warning: `packet' might be used 
uninitialized in this function
  gcc -Wp,-MD,./.video1394.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=video1394   -c -o video1394.o 
video1394.c
In file included from video1394.c:52:
drivers/ieee1394/ieee1394_core.h:72: parse error before `task_queue'
drivers/ieee1394/ieee1394_core.h:72: warning: no semicolon at end of 
struct or union
drivers/ieee1394/ieee1394_core.h:78: parse error before `}'
drivers/ieee1394/ieee1394_core.h: In function `driver_packet':
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:82: warning: type defaults to `int' in 
declaration of `__mptr'
drivers/ieee1394/ieee1394_core.h:82: warning: initialization from 
incompatible pointer type
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:83: warning: control reaches end of 
non-void function
  gcc -Wp,-MD,./.sbp2.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=sbp2   -c -o sbp2.o sbp2.c
In file included from sbp2.c:344:
drivers/ieee1394/ieee1394_core.h:72: parse error before `task_queue'
drivers/ieee1394/ieee1394_core.h:72: warning: no semicolon at end of 
struct or union
drivers/ieee1394/ieee1394_core.h:78: parse error before `}'
drivers/ieee1394/ieee1394_core.h: In function `driver_packet':
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:82: warning: type defaults to `int' in 
declaration of `__mptr'
drivers/ieee1394/ieee1394_core.h:82: warning: initialization from 
incompatible pointer type
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:83: warning: control reaches end of 
non-void function
drivers/ieee1394/sbp2.c: In function 
`sbp2util_allocate_write_request_packet':
drivers/ieee1394/sbp2.c:767: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:768: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:768: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:768: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:768: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:769: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:770: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:771: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:775: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:775: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:790: warning: implicit declaration of function 
`queue_task'
drivers/ieee1394/sbp2.c:790: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c: In function `sbp2util_free_request_packet':
drivers/ieee1394/sbp2.c:818: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:819: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c: In function `sbp2_agent_reset':
drivers/ieee1394/sbp2.c:2034: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:2035: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c: In function `sbp2_link_orb_command':
drivers/ieee1394/sbp2.c:2344: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:2345: dereferencing pointer to incomplete type
drivers/ieee1394/sbp2.c:2346: dereferencing pointer to incomplete type
  gcc -Wp,-MD,./.dv1394.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=dv1394   -c -o dv1394.o dv1394.c
In file included from dv1394.c:113:
drivers/ieee1394/ieee1394_core.h:72: parse error before `task_queue'
drivers/ieee1394/ieee1394_core.h:72: warning: no semicolon at end of 
struct or union
drivers/ieee1394/ieee1394_core.h:78: parse error before `}'
drivers/ieee1394/ieee1394_core.h: In function `driver_packet':
drivers/ieee1394/ieee1394_core.h:82: dereferen
cing pointer to incomplete type
drivers/ieee1394/ieee1394_core.h:82: warning: type defaults to `int' in 
declaration of `__mptr'
drivers/ieee1394/ieee1394_core.h:82: warning: initialization from 
incompatible pointer type
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:83: warning: control reaches end of 
non-void function
  gcc -Wp,-MD,./.eth1394.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=eth1394   -c -o eth1394.o eth1394.c
In file included from eth1394.c:64:
drivers/ieee1394/ieee1394_core.h:72: parse error before `task_queue'
drivers/ieee1394/ieee1394_core.h:72: warning: no semicolon at end of 
struct or union
drivers/ieee1394/ieee1394_core.h:78: parse error before `}'
drivers/ieee1394/ieee1394_core.h: In function `driver_packet':
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:82: warning: type defaults to `int' in 
declaration of `__mptr'
drivers/ieee1394/ieee1394_core.h:82: warning: initialization from 
incompatible pointer type
drivers/ieee1394/ieee1394_core.h:82: dereferencing pointer to incomplete 
type
drivers/ieee1394/ieee1394_core.h:83: warning: control reaches end of 
non-void function
make[2]: Leaving directory `/usr/src/linux-2.5.40/drivers/ieee1394'


And a bit down with i20:

make[3]: Entering directory `/usr/src/linux-2.5.40/drivers/message/i2o'
  gcc -Wp,-MD,./.i2o_block.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=i2o_block   -c -o i2o_block.o 
i2o_block.c
drivers/message/i2o/i2o_block.c:43: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_block.c: In function `i2ob_send':
drivers/message/i2o/i2o_block.c:324: warning: comparison between pointer 
and integer
drivers/message/i2o/i2o_block.c: In function `i2ob_install_device':
drivers/message/i2o/i2o_block.c:1236: structure has no member named 
`queue_buggy'
drivers/message/i2o/i2o_block.c:1239: structure has no member named 
`queue_buggy'
drivers/message/i2o/i2o_block.c:1323: incompatible type for argument 1 
of `set_capacity'
fixdep: ./.i2o_block.o.d: No such file or directory
make[3]: *** [i2o_block.o] Error 2
make[3]: Leaving directory `/usr/src/linux-2.5.40/drivers/message/i2o'
make[2]: *** [i2o] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.40/drivers/message'
make[1]: *** [message] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.40/drivers'
make: *** [drivers] Error 2


Will re-try without ieee1394 and see what happens.


Cheers,


Rudy

