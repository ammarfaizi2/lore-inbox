Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWCLCEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWCLCEp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 21:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWCLCEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 21:04:45 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:34189 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S1750791AbWCLCEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 21:04:44 -0500
Date: Sun, 12 Mar 2006 03:04:40 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-ID: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1986964122-1142129080=:14567"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1986964122-1142129080=:14567
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello,

After upgrading to 2.6.16-rc6 I noticed this strange message:

More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.

This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so with=
=20
totoal of 4 logical CPUs).

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=3Dy
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_SMP=3Dy
CONFIG_NR_CPUS=3D4
CONFIG_SCHED_SMT=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_X86_MCE_P4THERMAL=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=3Dy
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set


Best regards,

 =09=09=09Krzysztof Ol=EAdzki
---187430788-1986964122-1142129080=:14567--
