Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135805AbREECSB>; Fri, 4 May 2001 22:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135890AbREECRv>; Fri, 4 May 2001 22:17:51 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:48324 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S135805AbREECRl>; Fri, 4 May 2001 22:17:41 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Date: Sat, 5 May 2001 04:28:03 +0200
X-Mailer: KMail [version 1.2]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01050504280300.03550@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What still stands out is that exactly _zero_ people have reported the same
> problem with non VIA chipset Athlons.

Sorry Alan, but...

My (very) old Athlon 550 (model 1, stepping 2) show it on my MSI MS-6167 (AMD 
Irongate C4) with your 2.4.4-ac5, now :-(
Even with or without apm/acpi enabled.
It freezes during "Freeing unused kernel memory: 172k freed".
Never saw this before.

I am open for any test fixes...

-Dieter

SuSE 7.1 (glibc-2.2, gcc-2.95.2)

Linux version 2.4.4 (root@SunWave1) (gcc version 2.95.2 19991024 (release)) 
#1 Sun Apr 29 02:30:34 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
 BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 81904
zone(0): 4096 pages.
zone(1): 77808 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01555000)

SunWave1>cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 548.950
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1094.45

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
