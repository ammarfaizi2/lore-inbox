Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTFLOCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFLOCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:02:54 -0400
Received: from ns0.eris.dera.gov.uk ([128.98.1.1]:32389 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S264827AbTFLOCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:02:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Dave Jones <davej@codemonkey.org.uk>, John Goerzen <jgoerzen@complete.org>
Subject: Re: cpufreq on Pentium M
Date: Thu, 12 Jun 2003 15:10:01 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <87n0go3pcp.fsf@complete.org> <20030612061803.GA21509@suse.de>
In-Reply-To: <20030612061803.GA21509@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306121510.01876.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Thought this may help:
- From a Dell D600 w/ 1.6Ghz Pentium M cpu...

Mark.


cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 1598.671
cache size      : 0 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm
bogomips        : 3191.60




x86info v1.11.  Dave Jones 2001, 2002
Feedback to <davej@suse.de>.

Found 1 CPU
eax in: 0x00000000, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 0x00000001, eax = 00000695 ebx = 00000816 ecx = 00000180 edx = a7e9f9bf
eax in: 0x00000002, eax = 02b3b001 ebx = 00000000 ecx = 00000000 edx = 2c043087

eax in: 0x80000000, eax = 80000004 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000001, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000002, eax = 20202020 ebx = 20202020 ecx = 65746e49 edx = 2952286c
eax in: 0x80000003, eax = 6e655020 ebx = 6d756974 ecx = 20295228 edx = 7270204d
eax in: 0x80000004, eax = 7365636f ebx = 20726f73 ecx = 30303631 edx = 007a484d

Family: 6 Model: 9 Stepping: 5 Type: 0
CPU Model: Unknown CPU Original OEM
Feature flags:
        Onboard FPU
        Virtual Mode Extensions
        Debugging Extensions
        Page Size Extensions
        Time Stamp Counter
        Model-Specific Registers
        Machine Check Architecture
        CMPXCHG8 instruction
        SYSENTER/SYSEXIT
        Memory Type Range Registers
        Page Global Enable
        Machine Check Architecture
        CMOV instruction
        Page Attribute Table
        CLFLUSH instruction
        Debug Trace Store
        ACPI via MSR
        MMX support
        FXSAVE and FXRESTORE instructions
        SSE support
        SSE2 support
        Automatic clock Control
        Pending Break Enable


unknown TLB/cache descriptor:
        0xb0
unknown TLB/cache descriptor:
        0xb3
Instruction TLB: 4MB pages, fully associative, 2 entries
unknown TLB/cache descriptor:
        0x87
unknown TLB/cache descriptor:
        0x30
Data TLB: 4MB pages, 4-way associative, 8 entries
unknown TLB/cache descriptor:
        0x2c

/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device

MTRR registers:
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
/dev/cpu/0/msr: No such device
MTRRcap (0xfe): MTRRphysBase0 (0x200): MTRRphysMask0 (0x201): MTRRphysBase1 (0x202): MTRRphysMask1 (0x203): MTRRphysBase2 (0x204): MTRRphysMask2 (0x205): MTRRphysBase3 (0x206): MTRRphysMask3 (0x207): MTRRphysBase4 (0x208): MTRRphysMask4 (0x209): MTRRphysBase5 (0x20a): MTRRphysMask5 (0x20b): MTRRphysBase6 (0x20c): MTRRphysMask6 (0x20d): MTRRphysBase7 (0x20e): MTRRphysMask7 (0x20f): MTRRfix64K_00000 (0x250): MTRRfix16K_80000 (0x258): MTRRfix16K_A0000 (0x259): MTRRfix4K_C8000 (0x269): MTRRfix4K_D0000 0x26a: MTRRfix4K_D8000 0x26b: MTRRfix4K_E0000 0x26c: MTRRfix4K_E8000 0x26d: MTRRfix4K_F0000 0x26e: MTRRfix4K_F8000 0x26f: MTRRdefType (0x2ff):

1598.66 MHz processor (estimate).




- -- 
Mark Watts
Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6Im5Bn4EFUVUIO0RApBZAKCMhyv/g89z/3q86HgHyVCMbK19jwCgr6d7
ADZKclFpLmbiyvhHsrpNBCI=
=XSHX
-----END PGP SIGNATURE-----

