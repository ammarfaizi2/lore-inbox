Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278397AbRJMUXW>; Sat, 13 Oct 2001 16:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278398AbRJMUXN>; Sat, 13 Oct 2001 16:23:13 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:54287 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S278397AbRJMUXB>; Sat, 13 Oct 2001 16:23:01 -0400
Date: Sat, 13 Oct 2001 22:25:18 +0200
From: Leopold Gouverneur <lgouv@planetinternet.be>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Problem with store fence fixes
Message-ID: <20011013222518.A1559@loclhost>
Reply-To: lgouv@planetinternet.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10-ac9 locks after 
	Console: colour VGA+ 80x25
	Unexpected IRQ trap at vector 75
	Calibrating delay loop ..
Only the reset button helps. 2.4.10-ac8 works perfectly, ac9 also
if I suppress the line "define_bool CONFIG_X86_PPRO_FENCE y".
Since nobody is complaining, I suppose i am doing something wrong.
My system: Abit BP6, 2 Celeron 433( not OC )

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
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
CONFIG_MICROCODE=m
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

What other information would be helpful?

Thanks!
Thanks

A

