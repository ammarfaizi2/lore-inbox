Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276601AbRI2UAz>; Sat, 29 Sep 2001 16:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276604AbRI2UAo>; Sat, 29 Sep 2001 16:00:44 -0400
Received: from pD900F0CE.dip.t-dialin.net ([217.0.240.206]:25095 "EHLO
	neon.hh59.org") by vger.kernel.org with ESMTP id <S276601AbRI2UAh>;
	Sat, 29 Sep 2001 16:00:37 -0400
Date: Sat, 29 Sep 2001 22:02:07 +0200 (CEST)
From: Axel Siebenwirth <axel@hh59.org>
To: Kernel Ml <linux-kernel@vger.kernel.org>
Subject: compilation error with 2.4.10 (gcc 3.1)
Message-ID: <Pine.LNX.4.33.0109292144280.5924-100000@neon.hh59.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have tried to compile official kernel 2.4.10 with gcc 3.1 from CVS and
get the following error:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
[...]
init/main.o: In function `check_fpu':
init/main.o(.text.init+0x51): undefined reference to `__buggy_fxsr_alignment'

I'm aware that this might possibly related to the "too" new gcc version.
Due to lack of knowledge about c programming, I cannot have a look to
solve it myself.
Any solution or help would be deeply appreciated.

Thanks for reading,
Axel



P.S. An excerpt from my .config:

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y


