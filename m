Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbRLMWYe>; Thu, 13 Dec 2001 17:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285227AbRLMWYY>; Thu, 13 Dec 2001 17:24:24 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:31944
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285226AbRLMWYJ>; Thu, 13 Dec 2001 17:24:09 -0500
Date: Thu, 13 Dec 2001 17:13:58 -0500
Message-Id: <200112132213.fBDMDwc17766@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: rmk@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: State of Configure.help
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're down to just 14 missing entries:

ARM port:

CPU_ARM1020_CPU_IDLE: arch/arm/mm/proc-arm1020.S
CPU_ARM1020_FORCE_WRITE_THROUGH: arch/arm/config.in arch/arm/mm/proc-arm1020.S
CPU_ARM1020_ROUND_ROBIN: arch/arm/config.in arch/arm/mm/proc-arm1020.S
CPU_ARM920_CPU_IDLE: arch/arm/config.in arch/arm/mm/proc-arm920.S
CPU_ARM926_CPU_IDLE: arch/arm/config.in arch/arm/mm/proc-arm926.S
CPU_ARM926_ROUND_ROBIN: arch/arm/config.in arch/arm/mm/proc-arm926.S
CPU_FREQ: drivers/video/sa1100fb.c drivers/video/sa1100fb.h drivers/pcmcia/sa1100_generic.c arch/arm/config.in arch/arm/mach-sa1100/Makefile arch/arm/mach-sa1100/generic.c arch/arm/mach-integrator/cpu.c
MTD_ARM_INTEGRATOR: drivers/mtd/maps/Config.in drivers/mtd/maps/Makefile

S390 port:

DASD_AUTO_DIAG: drivers/s390/Config.in drivers/s390/block/dasd.c
DASD_AUTO_ECKD: drivers/s390/Config.in drivers/s390/block/dasd.c
DASD_AUTO_FBA: drivers/s390/Config.in drivers/s390/block/dasd.c
HWC_CPI: drivers/s390/Config.in drivers/s390/char/Makefile
PFAULT: arch/s390/config.in arch/s390/kernel/smp.c arch/s390/kernel/traps.c arch/s390/mm/fault.c arch/s390x/config.in arch/s390x/kernel/smp.c arch/s390x/kernel/traps.c arch/s390x/mm/fault.c
SHARED_KERNEL: arch/s390/Makefile arch/s390/config.in arch/s390/kernel/head.S arch/s390x/Makefile arch/s390x/config.in arch/s390x/kernel/head.S

Martin, you said you had asked some person named "Carsten" to write
the S390 entries.  Would you give me his email address, please?

ARM guys, I got nine entries from one of your people recently, but as
you can see there is still a little work to be done.  Please help me
wrap this up.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

[The disarming of citizens] has a double effect, it palsies the hand
and brutalizes the mind: a habitual disuse of physical forces totally
destroys the moral [force]; and men lose at once the power of
protecting themselves, and of discerning the cause of their
oppression.
        -- Joel Barlow, "Advice to the Privileged Orders", 1792-93
