Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSJ1P1m>; Mon, 28 Oct 2002 10:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJ1P1m>; Mon, 28 Oct 2002 10:27:42 -0500
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:1296 "EHLO debian.lan")
	by vger.kernel.org with ESMTP id <S261291AbSJ1P1l>;
	Mon, 28 Oct 2002 10:27:41 -0500
Date: Mon, 28 Oct 2002 16:32:37 +0100
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Compile Error with the 2.5.44-ac5 and the P4
Message-ID: <20021028153237.GA19602@debian.lan>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is an error.

make -f arch/i386/kernel/Makefile 
make -f arch/i386/kernel/cpu/Makefile 
make -f arch/i386/kernel/cpu/cpufreq/Makefile 
make -f arch/i386/kernel/cpu/mcheck/Makefile 
  gcc -Wp,-MD,arch/i386/kernel/cpu/mcheck/.p4.o.d -D__KERNEL__ -Iinclude
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
  -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -p
  -Iarch/i386/mach-voyager -nostdinc -iwithprefix include 
  -DKBUILD_BASENAME=p4   -c -o arch/i386/kernel/cpu/mcheck/p4.o
  arch/i386/kernel/cpu/mcheck/p4.c
  arch/i386/kernel/cpu/mcheck/p4.c: In function `intel_thermal_interrupt':
  arch/i386/kernel/cpu/mcheck/p4.c:51: warning: implicit declaration of function `ack_APIC_irq'
  arch/i386/kernel/cpu/mcheck/p4.c: In function `intel_init_thermal': 
  arch/i386/kernel/cpu/mcheck/p4.c:91: warning: implicit declaration of function `apic_read'
  arch/i386/kernel/cpu/mcheck/p4.c:105: `THERMAL_APIC_VECTOR' undeclared (first use in this function)
  arch/i386/kernel/cpu/mcheck/p4.c:105: (Each undeclared identifier is reported only once
  arch/i386/kernel/cpu/mcheck/p4.c:105: for each function it appears in.)
  arch/i386/kernel/cpu/mcheck/p4.c:107: warning: implicit declaration of function `apic_write_around'
  make[3]: *** [arch/i386/kernel/cpu/mcheck/p4.o] Error 1
  make[2]: *** [arch/i386/kernel/cpu/mcheck] Error 2
  make[1]: *** [arch/i386/kernel/cpu] Error 2
  make: *** [arch/i386/kernel] Error 2
  
  
Best regards,


Stephane Wirtel

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7

