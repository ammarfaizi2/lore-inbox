Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292169AbSCAPWN>; Fri, 1 Mar 2002 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293022AbSCAPVx>; Fri, 1 Mar 2002 10:21:53 -0500
Received: from sebula.traumatized.org ([193.121.72.130]:35265 "EHLO
	sebula.traumatized.org") by vger.kernel.org with ESMTP
	id <S292169AbSCAPVv>; Fri, 1 Mar 2002 10:21:51 -0500
X-NoSPAM: http://traumatized.org/nospam/
Message-ID: <3C7F8B80.1010007@pophost.eunet.be>
Date: Fri, 01 Mar 2002 15:09:04 +0100
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux sparc64; en-US; rv:0.9.8) Gecko/20020220
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre2 - USB - sparc64 compile problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i just tried to update my kernel to the latest pre2, but i ran into sone 
problems regarding USB.

fyi; 2.4.19pre1 works just nicely.

root@sparkie:/usr/src/linux# sparc64-linux-gcc --version
egcs-2.92.11

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux2419pre2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc 
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 
-Wno-sign-compare -Wa,--undeclared-regs   -DKBUILD_BASENAME=hcd 
-DEXPORT_SYMTAB -c hcd.c
hcd.c: In function `usb_hcd_pci_probe':
hcd.c:627: `irq' undeclared (first use in this function)
hcd.c:627: (Each undeclared identifier is reported only once
hcd.c:627: for each function it appears in.)
make[3]: *** [hcd.o] Error 1
make[3]: Leaving directory `/usr/src/linux2419pre2/drivers/usb'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux2419pre2/drivers/usb'
make[1]: *** [_subdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux2419pre2/drivers'
make: *** [_dir_drivers] Error 2



ps: i'm not subscribed to the mailing list, but i read the linux.kernel 
newsgroup on a regular base.


regards,
Jurgen.

