Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbTIBLK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbTIBLKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:10:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7621 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261238AbTIBLJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:09:57 -0400
Message-ID: <3F547808.F7559327@eyal.emu.id.au>
Date: Tue, 02 Sep 2003 20:59:20 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22aa1: scsi/pcmcia build failures
References: <20030902020218.GB1599@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-aa/include -Wall
-Wstrict-prot
otypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-aa/include/linux/modversions.
h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogicfas -DPCMCIA
-D__NO_VE
RSION__ -c -o qlogicfas.o ../qlogicfas.c
../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of
`scsi_unregister_Ra72f3dfa' from i
ncompatible pointer type
ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
qlogicfas.o: In function `init_module':
qlogicfas.o(.text+0xe40): multiple definition of `init_module'
qlogic_stub.o(.text+0x770): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
qlogicfas.o
qlogicfas.o: In function `cleanup_module':
qlogicfas.o(.text+0xe80): multiple definition of `cleanup_module'
qlogic_stub.o(.text+0x7c0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
qlogicfas.o
make[3]: *** [qlogic_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-aa/include -Wall
-Wstrict-prot
otypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-aa/include/linux/modversions.
h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=fdomain -DPCMCIA
-D__NO_VERS
ION__ -c -o fdomain.o ../fdomain.c
../fdomain.c:565: warning: `fdomain_setup' defined but not used
ld -m elf_i386 -r -o fdomain_cs.o fdomain_stub.o fdomain.o
fdomain.o: In function `init_module':
fdomain.o(.text+0x19b0): multiple definition of `init_module'
fdomain_stub.o(.text+0x6a0): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
fdomain.o
fdomain.o: In function `cleanup_module':
fdomain.o(.text+0x19f0): multiple definition of `cleanup_module'
fdomain_stub.o(.text+0x6f0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
fdomain.o
make[3]: *** [fdomain_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-aa/include -Wall
-Wstrict-prot
otypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-aa/include/linux/modversions.
h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=aha152x -DPCMCIA
-D__NO_VERS
ION__ -DAHA152X_STAT -c -o aha152x.o ../aha152x.c
../aha152x.c:853: warning: `do_setup' defined but not used
ld -m elf_i386 -r -o aha152x_cs.o aha152x_stub.o aha152x.o
aha152x.o: In function `init_module':
aha152x.o(.text+0x50e0): multiple definition of `init_module'
aha152x_stub.o(.text+0x740): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
aha152x.o
aha152x.o: In function `cleanup_module':
aha152x.o(.text+0x5120): multiple definition of `cleanup_module'
aha152x_stub.o(.text+0x790): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
aha152x.o
make[3]: *** [aha152x_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-aa/include -Wall
-Wstrict-prot
otypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-aa/include/linux/modversions.
h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogicfas -DPCMCIA
-D__NO_VE
RSION__ -c -o qlogicfas.o ../qlogicfas.c
../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of
`scsi_unregister_Ra72f3dfa' from i
ncompatible pointer type
ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
qlogicfas.o: In function `init_module':
qlogicfas.o(.text+0xe40): multiple definition of `init_module'
qlogic_stub.o(.text+0x770): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
qlogicfas.o
qlogicfas.o: In function `cleanup_module':
qlogicfas.o(.text+0xe80): multiple definition of `cleanup_module'
qlogic_stub.o(.text+0x7c0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
qlogicfas.o
make[3]: *** [qlogic_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-aa/include -Wall
-Wstrict-prot
otypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-aa/include/linux/modversions.
h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=fdomain -DPCMCIA
-D__NO_VERS
ION__ -c -o fdomain.o ../fdomain.c
../fdomain.c:565: warning: `fdomain_setup' defined but not used
ld -m elf_i386 -r -o fdomain_cs.o fdomain_stub.o fdomain.o
fdomain.o: In function `init_module':
fdomain.o(.text+0x19b0): multiple definition of `init_module'
fdomain_stub.o(.text+0x6a0): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
fdomain.o
fdomain.o: In function `cleanup_module':
fdomain.o(.text+0x19f0): multiple definition of `cleanup_module'
fdomain_stub.o(.text+0x6f0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
fdomain.o
make[3]: *** [fdomain_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-aa/include -Wall
-Wstrict-prot
otypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-aa/include/linux/modversions.
h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=aha152x -DPCMCIA
-D__NO_VERS
ION__ -DAHA152X_STAT -c -o aha152x.o ../aha152x.c
../aha152x.c:853: warning: `do_setup' defined but not used
ld -m elf_i386 -r -o aha152x_cs.o aha152x_stub.o aha152x.o
aha152x.o: In function `init_module':
aha152x.o(.text+0x50e0): multiple definition of `init_module'
aha152x_stub.o(.text+0x740): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
aha152x.o
aha152x.o: In function `cleanup_module':
aha152x.o(.text+0x5120): multiple definition of `cleanup_module'
aha152x_stub.o(.text+0x790): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
aha152x.o
make[3]: *** [aha152x_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
