Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVDEU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVDEU6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDEU5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:57:41 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:30401 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262033AbVDEUvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:51:22 -0400
Subject: x86_64 Opteron dual core panics on boot
From: Tom Duffy <tduffy@sun.com>
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j2qSfCySz8QDyZwKLE1O"
Date: Tue, 05 Apr 2005 13:50:07 -0700
Message-Id: <1112734207.29824.7.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j2qSfCySz8QDyZwKLE1O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am trying to get any kernel to boot on dual core Opteron.  I have
tried with kernels 2.6.9-2.6.12-rc2 all with virtually the same panic.

Here is the output with 2.6.12-rc2:

Bootdata ok (command line is ro root=3D/dev/VolGroup00/LogVol00 console=3Dt=
tyS0) Linux version 2.6.12-rc2andro (root@androdemolin1.sfbay.sun.com) (gcc=
 version 4.0.0 20050402 (Red Hat 4.0.0-0.39)) #1 SMP Tue Apr 5 12:29:41 PDT=
 2005 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)  BIOS-e820: 000000=
000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)  BIOS-e820: 0000=
000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffde000 (ACPI data)  BIOS-e820: 000=
000007ffde000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)  BIOS-e820: 0000=
0000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: PXM 2 -> APIC 4 -> Node 2
SRAT: PXM 2 -> APIC 5 -> Node 2
SRAT: PXM 3 -> APIC 6 -> Node 3
SRAT: PXM 3 -> APIC 7 -> Node 3
SRAT: Node 0 PXM 0 100000-3fffffff
SRAT: Node 1 PXM 1 40000000-7fffffff
SRAT: Node 0 PXM 0 0-3fffffff
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ffcffff
Nvidia board detected. Ignoring ACPI timer override.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
Processor #4 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
Processor #5 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] enabled)
Processor #6 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
Processor #7 15:1 APIC version 16
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfeaff000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 17, address 0xfeaff000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=3D/dev/VolGroup00/LogVol00 console=3DttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2200.043 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2054928k/2096960k available (2400k kernel code, 0k reserved, 881k d=
ata, 216k init)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0
CPU: Physical Processor ID: 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0
CPU: Physical Processor ID: 0
CPU0: AMD Athlon(tm) or Opteron(tm) CPU-model unknown stepping 00
Booting processor 1/1 rip 6000 rsp ffff81003ff85f58
Initializing CPU#1
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at timer:418
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.12-rc2andro
RIP: 0010:[<ffffffff801402c9>] <ffffffff801402c9>{cascade+41}
RSP: 0018:ffff81007ff87ef0  EFLAGS: 00010087
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810001e12ae0
RBP: ffff810001e13af8 R08: ffff810001e11800 R09: 00000000000003d1
R10: 0000000002dc55dc R11: 000000000000007d R12: ffff810001e12ae0
R13: 0000000000000000 R14: ffff81007ff87f18 R15: 000000000000000a
FS:  0000000000000000(0000) GS:ffffffff80494c80(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffff81003ff84000, task ffff81003ff80df0=
)
Stack: 0000000000000000 ffffffff80495990 ffff810001e12ae0 0000000000000080
       ffffffff80140d17 ffff81007ff87f18 ffff81007ff87f18 0000000000000011
       ffffffff80495990 ffffffff80495990
Call Trace:<IRQ> <ffffffff80140d17>{run_timer_softirq+119} <ffffffff8013ca4=
0>{__do_softirq+128}
       <ffffffff8013caf0>{do_softirq+48} <ffffffff801116dd>{do_IRQ+77}
       <ffffffff8010ef89>{ret_from_intr+0}  <EOI> <ffffffff8010c8c0>{calibr=
ate_delay+176}
       <ffffffff804aca3c>{start_secondary+172}

Code: 0f 0b ee f6 36 80 ff ff ff ff a2 01 48 8b 1b 4c 89 e7 e8 f0
RIP <ffffffff801402c9>{cascade+41} RSP <ffff81007ff87ef0>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 NMI Watchdog detected LOCKUP on CPU0CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.12-rc2andro
RIP: 0010:[<ffffffff801fb078>] <ffffffff801fb078>{__delay+8}
RSP: 0000:ffff81007ff81e80  EFLAGS: 00000283
RAX: 000000004bb67273 RBX: 000000000000c1f7 RCX: 000000004bb42bf0
RDX: 0000000000000029 RSI: 0000000000000246 RDI: 0000000000034fa8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000036
R10: 00000000ffffffee R11: 0000000000000010 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffffffff80494c00(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000f047c1 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff81007ff80000, task ffff81003ff814d0=
)
Stack: ffffffff804ad11e ffffffffffffffff 0000000000000001 0000000800000283
       0000000400000001 0100000000000003 00000000000000ff 00000000ffffffff
       0000000000000000 ffffffffffffffff
Call Trace:<ffffffff804ad11e>{smp_prepare_cpus+1438} <ffffffff8010c089>{ini=
t+57}
       <ffffffff8010f59b>{child_rip+8} <ffffffff8010c050>{init+0}
       <ffffffff8010f593>{child_rip+0}

Code: 29 c8 48 39 f8 72 f5 f3 c3 66 66 66 90 66 66 66 90 66 66 66
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


--=-j2qSfCySz8QDyZwKLE1O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCUvn/dY502zjzwbwRAumhAJ98MX9LljIOo/keF0QtWYoXzb9HAgCfdGdn
3l2ygfGYB5iRvVIo63e3Q+g=
=Bp50
-----END PGP SIGNATURE-----

--=-j2qSfCySz8QDyZwKLE1O--
