Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130980AbRA2KhF>; Mon, 29 Jan 2001 05:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131786AbRA2Kg4>; Mon, 29 Jan 2001 05:36:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16649 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130980AbRA2Kgq>; Mon, 29 Jan 2001 05:36:46 -0500
Date: Mon, 29 Jan 2001 11:36:42 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Can't compile 2.2.18
Message-ID: <20010129113642.A5234@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clock@ghost:~$ gcc --version
2.95.2.1

libc5 

make -C  arch/i386/kernel
make[1]: Entering directory `/usr/src/linux-2.2.18/arch/i386/kernel'
cc -D__KERNEL__ -I/usr/src/linux-2.2.18/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586   -DEXPORT_SYMTAB -c i386_ksyms.c
i386_ksyms.c:37: `__ioremap' undeclared here (not in a function)
i386_ksyms.c:37: initializer element is not constant
i386_ksyms.c:37: (near initialization for `__ksymtab___ioremap.value')
i386_ksyms.c:38: `iounmap' undeclared here (not in a function)
i386_ksyms.c:38: initializer element is not constant
i386_ksyms.c:38: (near initialization for `__ksymtab_iounmap.value')
make[1]: *** [i386_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.2.18/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

Clock

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
