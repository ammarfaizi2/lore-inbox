Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTHLNDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTHLNDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:03:33 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:62701 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S267517AbTHLNDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:03:30 -0400
Date: Tue, 12 Aug 2003 16:03:28 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test3mm1 + gcc 3.2.3 | gcc3.3 compile error (Input/output error)
Message-ID: <Pine.LNX.4.56.0308121603010.8716@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have some problems to compile 2.6.0test3mm1.

I had no problem compiling 2.6.0test1 and test2 and all mm patches.

My config:
Linux Dino 2.6.0-test2-mm4 #1 Mon Aug 4 12:48:32 EEST 2003 i686 unknown
unknown GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
jfsutils               1.1.2
reiserfsprogs          3.6.8
xfsprogs               2.3.9
quota-tools            3.08.
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.4
Procps                 2.0.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0


The error is:

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o
sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o
.tmp_vmlinux1
arch/i386/kernel/built-in.o: could not read symbols: Input/output error
make: *** [.tmp_vmlinux1] Error 1


Any hints?
It may be that I upgrade binutils?

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
