Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSJ1Pty>; Mon, 28 Oct 2002 10:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJ1Pty>; Mon, 28 Oct 2002 10:49:54 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63416 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261313AbSJ1Ptx>;
	Mon, 28 Oct 2002 10:49:53 -0500
Date: Mon, 28 Oct 2002 15:56:01 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile Error with the 2.5.44-ac5 and the P4
Message-ID: <20021028155601.GA12705@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021028153237.GA19602@debian.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028153237.GA19602@debian.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 04:32:37PM +0100, Stephane Wirtel wrote:
 > here is an error.
 > 
 > make -f arch/i386/kernel/Makefile 
 > make -f arch/i386/kernel/cpu/Makefile 
 > make -f arch/i386/kernel/cpu/cpufreq/Makefile 
 > make -f arch/i386/kernel/cpu/mcheck/Makefile 
 >   gcc -Wp,-MD,arch/i386/kernel/cpu/mcheck/.p4.o.d -D__KERNEL__ -Iinclude
 >   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
 >   -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -p
 >   -Iarch/i386/mach-voyager -nostdinc -iwithprefix include 
 >   -DKBUILD_BASENAME=p4   -c -o arch/i386/kernel/cpu/mcheck/p4.o
 >   arch/i386/kernel/cpu/mcheck/p4.c
 >   arch/i386/kernel/cpu/mcheck/p4.c: In function `intel_thermal_interrupt':
 >   arch/i386/kernel/cpu/mcheck/p4.c:51: warning: implicit declaration of function `ack_APIC_irq'
 >   arch/i386/kernel/cpu/mcheck/p4.c: In function `intel_init_thermal': 
 >   arch/i386/kernel/cpu/mcheck/p4.c:91: warning: implicit declaration of function `apic_read'
 >   arch/i386/kernel/cpu/mcheck/p4.c:105: `THERMAL_APIC_VECTOR' undeclared (first use in this function)
 >   arch/i386/kernel/cpu/mcheck/p4.c:105: (Each undeclared identifier is reported only once
 >   arch/i386/kernel/cpu/mcheck/p4.c:105: for each function it appears in.)
 >   arch/i386/kernel/cpu/mcheck/p4.c:107: warning: implicit declaration of function `apic_write_around'
 >   make[3]: *** [arch/i386/kernel/cpu/mcheck/p4.o] Error 1
 >   make[2]: *** [arch/i386/kernel/cpu/mcheck] Error 2
 >   make[1]: *** [arch/i386/kernel/cpu] Error 2
 >   make: *** [arch/i386/kernel] Error 2

mail me (offlist) your .config, and I'll take a look.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
