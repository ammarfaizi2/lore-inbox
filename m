Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264750AbSKEKE1>; Tue, 5 Nov 2002 05:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264751AbSKEKE1>; Tue, 5 Nov 2002 05:04:27 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:36514 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S264750AbSKEKE0>;
	Tue, 5 Nov 2002 05:04:26 -0500
Date: Tue, 5 Nov 2002 11:10:25 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PROBLEM] 2.5.46: linker failed when I compile AFS
Message-ID: <20021105101024.GB22948@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I have problem with linking of kernel 2.5.46 when I try to compile
support for AFS:

        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  usr/built-in.o
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
fs/built-in.o(.text+0x4a573): In function `afs_exit':
: undefined reference to `afs_fs_exit'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [vmlinux] Error 2

Have you any suggestion, how it can be repaired?

Thanks.

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
