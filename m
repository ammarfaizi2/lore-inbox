Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269712AbRHIKbw>; Thu, 9 Aug 2001 06:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269751AbRHIKbk>; Thu, 9 Aug 2001 06:31:40 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:20752 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S269712AbRHIKb3>; Thu, 9 Aug 2001 06:31:29 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Aug 2001 12:31:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: FYI (2.4.4) on a HP Netserver LD Pro
Message-ID: <3B728283.10458.105A5C8@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/3.47+2.4+2.03.072+02 July 2001+64930@20010809.102139Z
X-Content-Conformance: LittleSister-2.11/0.0.100644.20010806.060350Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some odd boot messages (new since switching from kernel 2.2 to 
2.4) for the HP Netserver LD Pro (Pentium Pro 200MHz). I'd like to know 
if there is a hardware or configuration problem, or whether it's "just 
normal" (the "reserved twice").

Messages:
<4>Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3 
20010315 \
(SuSE)) #1 Wed May 16 00:37:55 GMT 2001
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
<4> BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f1cb4 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff1cb4 - 0000000100000000 (reserved)
<4>Scan SMP from c0000000 for 1024 bytes.
<4>Scan SMP from c009fc00 for 1024 bytes.
<4>Scan SMP from c00f0000 for 65536 bytes.
<4>found SMP MP-table at 000fd8d0
<4>hm, page 000fd000 reserved twice.
<4>hm, page 000fe000 reserved twice.
<4>hm, page 0009e000 reserved twice.
<4>hm, page 0009f000 reserved twice.
<4>On node 0 totalpages: 16384
<4>zone(0): 4096 pages.
<4>zone(1): 12288 pages.
<4>zone(2): 0 pages.
<4>Intel MultiProcessor Specification v1.1
<4>    Virtual Wire compatibility mode.
<4>OEM ID: HP       Product ID: LH Pro       APIC at: 0xFEE00000
<4>Processor #0 Pentium(tm) Pro APIC version 17
<4>    Floating point unit present.
<4>    Machine Exception supported.
<4>    64 bit compare & exchange supported.
<4>    Internal APIC present.
<4>    SEP present.
<4>    MTRR  present.
<4>    PGE  present.
<4>    MCA  present.
<4>    CMOV  present.
<4>    Bootup CPU
<4>Bus #0 is PCI
<4>Bus #1 is PCI
<4>Bus #2 is EISA
<4>I/O APIC #1 Version 17 at 0xFEC00000.
<4>Int: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID 1, APIC INT 00
...
<4>Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 1, APIC INT 0f
<4>Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
<4>Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
<4>Processors: 1
<4>mapped APIC to ffffe000 (fee00000)
<4>mapped IOAPIC to ffffd000 (fec00000)

Regards,
Ulrich

