Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276377AbRJKOG0>; Thu, 11 Oct 2001 10:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276370AbRJKOGS>; Thu, 11 Oct 2001 10:06:18 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:38824 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S276381AbRJKOF6>; Thu, 11 Oct 2001 10:05:58 -0400
From: Cristian CONSTANTIN <constantin@fokus.gmd.de>
Date: Thu, 11 Oct 2001 16:06:28 +0200
To: linux-kernel@vger.kernel.org
Subject: scsi/hdd problem...
Message-ID: <20011011160628.D29704@terix.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

scsi gurus please help! today my kernel barked like:

Oct 11 15:05:07 terix kernel: Recovery code sleeping
Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Abort Tag Message Sent
Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): SCB 116 - Abort Tag Completed.
Oct 11 15:05:07 terix kernel: Recovery SCB completes
Oct 11 15:05:07 terix kernel: Recovery code awake
Oct 11 15:05:07 terix kernel: aic7xxx_abort returns 8194
Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Attempting to queue an ABORT mes=
sage
Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Queuing a recovery SCB
Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Device is disconnected, re-queui=
ng SCB
Oct 11 15:05:07 terix kernel: Recovery code sleeping
Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Abort Tag Message Sent
Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): SCB 107 - Abort Tag Completed.
Oct 11 15:05:07 terix kernel: Recovery SCB completes
Oct 11 15:05:07 terix kernel: Recovery code awake
Oct 11 15:05:07 terix kernel: aic7xxx_abort returns 8194
Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Attempting to queue an ABORT mes=
sage
Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Queuing a recovery SCB
Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Device is disconnected, re-queui=
ng SCB

and the machine froze for a couple of minutes. in short I have
a Tyan motherbaord with Athlon SMP support and ADAPTEC SCSI onboard,=20
kernel version :

2.4.10-xfs #1 SMP Wed Sep 26 09:44:28 CEST 2001 i686 unknown

I attach some more descriptive dumps of my config from kern.log.
(pls. don't tell me my hdd is broken; this would be the third
one I change in only ONE month)

thanx in advance!
bye now!
--=20
 _          | LISP is worth learning for the profound enlightenment=20
(_'_        | experience you will have when you finally get it.=20
  (_'rist   |              --Eric Steven Raymond
GPG public key at https://www.mobile-ip.de/~crist/constantin.key

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log.dump"
Content-Transfer-Encoding: quoted-printable

Oct  8 12:00:20 xxx kernel: klogd 1.4.1#2, log source =3D /proc/kmsg starte=
d.
Oct  8 12:00:20 xxx kernel: Inspecting /boot/System.map-2.4.10-xfs
Oct  8 12:00:20 xxx kernel: Loaded 18265 symbols from /boot/System.map-2.4.=
10-xfs.
Oct  8 12:00:20 xxx kernel: Symbols match kernel version 2.4.10.
Oct  8 12:00:20 xxx kernel: Loaded 5 symbols from 1 module.
Oct  8 12:00:20 xxx kernel: Linux version 2.4.10-xfs (cco@xxx.fokus.gmd.de)=
 (gcc version 2.95.4 20010902 (Debian prerelease)) #1 SMP Wed Sep 26 09:44:=
28 CEST 2001
Oct  8 12:00:20 xxx kernel: BIOS-provided physical RAM map:
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 0000000000000000 - 000000000009f400=
 (usable)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 000000000009f400 - 00000000000a0000=
 (reserved)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 00000000000e4800 - 0000000000100000=
 (reserved)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000=
 (usable)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 000000001fff0000 - 000000001ffffc00=
 (ACPI data)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 000000001ffffc00 - 0000000020000000=
 (ACPI NVS)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000=
 (reserved)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000=
 (reserved)
Oct  8 12:00:20 xxx kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000=
 (reserved)
Oct  8 12:00:20 xxx kernel: found SMP MP-table at 000f74e0
Oct  8 12:00:20 xxx kernel: hm, page 000f7000 reserved twice.
Oct  8 12:00:20 xxx kernel: hm, page 000f8000 reserved twice.
Oct  8 12:00:20 xxx kernel: hm, page 0009f000 reserved twice.
Oct  8 12:00:20 xxx kernel: hm, page 000a0000 reserved twice.
Oct  8 12:00:20 xxx kernel: On node 0 totalpages: 131056
Oct  8 12:00:20 xxx kernel: zone(0): 4096 pages.
Oct  8 12:00:20 xxx kernel: zone(1): 126960 pages.
Oct  8 12:00:20 xxx kernel: zone(2): 0 pages.
Oct  8 12:00:20 xxx kernel: Intel MultiProcessor Specification v1.4
Oct  8 12:00:20 xxx kernel:     Virtual Wire compatibility mode.
Oct  8 12:00:20 xxx kernel: OEM ID: TYAN     Product ID: GUINNESS     APIC =
at: 0xFEE00000
Oct  8 12:00:20 xxx kernel: Processor #1 Pentium(tm) Pro APIC version 16
Oct  8 12:00:20 xxx kernel: Processor #0 Pentium(tm) Pro APIC version 16
Oct  8 12:00:20 xxx kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Oct  8 12:00:20 xxx kernel: Processors: 2
Oct  8 12:00:20 xxx kernel: Kernel command line: mem=3D524224K
Oct  8 12:00:20 xxx kernel: Initializing CPU#0
Oct  8 12:00:20 xxx kernel: Detected 1194.684 MHz processor.
Oct  8 12:00:20 xxx kernel: Console: colour VGA+ 80x25
Oct  8 12:00:20 xxx kernel: Calibrating delay loop... 2385.51 BogoMIPS
Oct  8 12:00:20 xxx kernel: Memory: 512704k/524224k available (1858k kernel=
 code, 11132k reserved, 427k data, 224k init, 0k highmem)
Oct  8 12:00:20 xxx kernel: Dentry-cache hash table entries: 65536 (order: =
7, 524288 bytes)
Oct  8 12:00:20 xxx kernel: Inode-cache hash table entries: 32768 (order: 6=
, 262144 bytes)
Oct  8 12:00:20 xxx kernel: Mount-cache hash table entries: 8192 (order: 4,=
 65536 bytes)
Oct  8 12:00:20 xxx kernel: Buffer-cache hash table entries: 32768 (order: =
5, 131072 bytes)
Oct  8 12:00:20 xxx kernel: Page-cache hash table entries: 131072 (order: 7=
, 524288 bytes)
Oct  8 12:00:20 xxx kernel: CPU: Before vendor init, caps: 0383fbff c1c7fbf=
f 00000000, vendor =3D 2
Oct  8 12:00:20 xxx kernel: Intel machine check architecture supported.
Oct  8 12:00:20 xxx kernel: Intel machine check reporting enabled on CPU#0.
Oct  8 12:00:20 xxx kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 6=
4K (64 bytes/line)
Oct  8 12:00:20 xxx kernel: CPU: L2 Cache: 256K (64 bytes/line)
Oct  8 12:00:20 xxx kernel: CPU: After vendor init, caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU:     After generic, caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU:             Common caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: Enabling fast FPU save and restore... done.
Oct  8 12:00:20 xxx kernel: Enabling unmasked SIMD FPU exception support...=
 done.
Oct  8 12:00:20 xxx kernel: Checking 'hlt' instruction... OK.
Oct  8 12:00:20 xxx kernel: POSIX conformance testing by UNIFIX
Oct  8 12:00:20 xxx kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@at=
nf.csiro.au)
Oct  8 12:00:20 xxx kernel: mtrr: detected mtrr type: Intel
Oct  8 12:00:20 xxx kernel: CPU: Before vendor init, caps: 0383fbff c1c7fbf=
f 00000000, vendor =3D 2
Oct  8 12:00:20 xxx kernel: Intel machine check reporting enabled on CPU#0.
Oct  8 12:00:20 xxx kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 6=
4K (64 bytes/line)
Oct  8 12:00:20 xxx kernel: CPU: L2 Cache: 256K (64 bytes/line)
Oct  8 12:00:20 xxx kernel: CPU: After vendor init, caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU:     After generic, caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU:             Common caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU0: AMD Athlon(tm) Processor stepping 01
Oct  8 12:00:20 xxx kernel: per-CPU timeslice cutoff: 731.41 usecs.
Oct  8 12:00:20 xxx kernel: enabled ExtINT on CPU#0
Oct  8 12:00:20 xxx kernel: ESR value before enabling vector: 00000000
Oct  8 12:00:20 xxx kernel: ESR value after enabling vector: 00000000
Oct  8 12:00:20 xxx kernel: Booting processor 1/0 eip 2000
Oct  8 12:00:20 xxx kernel: Initializing CPU#1
Oct  8 12:00:20 xxx kernel: masked ExtINT on CPU#1
Oct  8 12:00:20 xxx kernel: ESR value before enabling vector: 00000000
Oct  8 12:00:20 xxx kernel: ESR value after enabling vector: 00000000
Oct  8 12:00:20 xxx kernel: Calibrating delay loop... 2385.51 BogoMIPS
Oct  8 12:00:20 xxx kernel: CPU: Before vendor init, caps: 0383fbff c1c7fbf=
f 00000000, vendor =3D 2
Oct  8 12:00:20 xxx kernel: Intel machine check reporting enabled on CPU#1.
Oct  8 12:00:20 xxx kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 6=
4K (64 bytes/line)
Oct  8 12:00:20 xxx kernel: CPU: L2 Cache: 256K (64 bytes/line)
Oct  8 12:00:20 xxx kernel: CPU: After vendor init, caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU:     After generic, caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU:             Common caps: 0383fbff c1c7fbff=
 00000000 00000000
Oct  8 12:00:20 xxx kernel: CPU1: AMD Athlon(tm) Processor stepping 01
Oct  8 12:00:20 xxx kernel: Total of 2 processors activated (4771.02 BogoMI=
PS).
Oct  8 12:00:20 xxx kernel: ENABLING IO-APIC IRQs
Oct  8 12:00:20 xxx kernel: ...changing IO-APIC physical APIC ID to 2 ... o=
k.
Oct  8 12:00:20 xxx kernel: init IO_APIC IRQs
Oct  8 12:00:20 xxx kernel:  IO-APIC (apicid-pin) 2-0, 2-3, 2-5, 2-10, 2-11=
, 2-20, 2-21, 2-22, 2-23 not connected.
Oct  8 12:00:20 xxx kernel: ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
Oct  8 12:00:20 xxx kernel: number of MP IRQ sources: 19.
Oct  8 12:00:20 xxx kernel: number of IO-APIC #2 registers: 24.
Oct  8 12:00:20 xxx kernel: testing the IO APIC.......................
Oct  8 12:00:20 xxx kernel:=20
Oct  8 12:00:20 xxx kernel: IO APIC #2......
Oct  8 12:00:20 xxx kernel: .... register #00: 02000000
Oct  8 12:00:20 xxx kernel: .......    : physical APIC id: 02
Oct  8 12:00:20 xxx kernel: .... register #01: 00170011
Oct  8 12:00:20 xxx kernel: .......     : max redirection entries: 0017
Oct  8 12:00:20 xxx kernel: .......     : IO APIC version: 0011
Oct  8 12:00:20 xxx kernel: .... register #02: 00000000
Oct  8 12:00:20 xxx kernel: .......     : arbitration: 00
Oct  8 12:00:20 xxx kernel: .... IRQ redirection table:
Oct  8 12:00:20 xxx kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Ve=
ct:  =20
Oct  8 12:00:20 xxx kernel:  00 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  01 003 03  0    0    0   0   0    1    1    39
Oct  8 12:00:20 xxx kernel:  02 003 03  0    0    0   0   0    1    1    31
Oct  8 12:00:20 xxx kernel:  03 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  04 003 03  0    0    0   0   0    1    1    41
Oct  8 12:00:20 xxx kernel:  05 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  06 003 03  0    0    0   0   0    1    1    49
Oct  8 12:00:20 xxx kernel:  07 003 03  0    0    0   0   0    1    1    51
Oct  8 12:00:20 xxx kernel:  08 003 03  0    0    0   0   0    1    1    59
Oct  8 12:00:20 xxx kernel:  09 003 03  0    0    0   0   0    1    1    61
Oct  8 12:00:20 xxx kernel:  0a 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  0b 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  0c 003 03  0    0    0   0   0    1    1    69
Oct  8 12:00:20 xxx kernel:  0d 003 03  0    0    0   0   0    1    1    71
Oct  8 12:00:20 xxx kernel:  0e 003 03  0    0    0   0   0    1    1    79
Oct  8 12:00:20 xxx kernel:  0f 003 03  0    0    0   0   0    1    1    81
Oct  8 12:00:20 xxx kernel:  10 003 03  1    1    0   1   0    1    1    89
Oct  8 12:00:20 xxx kernel:  11 003 03  1    1    0   1   0    1    1    91
Oct  8 12:00:20 xxx kernel:  12 003 03  1    1    0   1   0    1    1    99
Oct  8 12:00:20 xxx kernel:  13 003 03  1    1    0   1   0    1    1    A1
Oct  8 12:00:20 xxx kernel:  14 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  15 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  16 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel:  17 000 00  1    0    0   0   0    0    0    00
Oct  8 12:00:20 xxx kernel: IRQ to pin mappings:
Oct  8 12:00:20 xxx kernel: IRQ0 -> 0:2
Oct  8 12:00:20 xxx kernel: IRQ1 -> 0:1
Oct  8 12:00:20 xxx kernel: IRQ4 -> 0:4
Oct  8 12:00:20 xxx kernel: IRQ6 -> 0:6
Oct  8 12:00:20 xxx kernel: IRQ7 -> 0:7
Oct  8 12:00:20 xxx kernel: IRQ8 -> 0:8
Oct  8 12:00:20 xxx kernel: IRQ9 -> 0:9
Oct  8 12:00:20 xxx kernel: IRQ12 -> 0:12
Oct  8 12:00:20 xxx kernel: IRQ13 -> 0:13
Oct  8 12:00:20 xxx kernel: IRQ14 -> 0:14
Oct  8 12:00:20 xxx kernel: IRQ15 -> 0:15
Oct  8 12:00:20 xxx kernel: IRQ16 -> 0:16
Oct  8 12:00:20 xxx kernel: IRQ17 -> 0:17
Oct  8 12:00:20 xxx kernel: IRQ18 -> 0:18
Oct  8 12:00:20 xxx kernel: IRQ19 -> 0:19
Oct  8 12:00:20 xxx kernel: .................................... done.
Oct  8 12:00:20 xxx kernel: Using local APIC timer interrupts.
Oct  8 12:00:20 xxx kernel: calibrating APIC timer ...
Oct  8 12:00:20 xxx kernel: ..... CPU clock speed is 1194.6643 MHz.
Oct  8 12:00:20 xxx kernel: ..... host bus clock speed is 265.4808 MHz.
Oct  8 12:00:20 xxx kernel: cpu: 0, clocks: 2654808, slice: 884936
Oct  8 12:00:20 xxx kernel: CPU0<T0:2654800,T1:1769856,D:8,S:884936,C:26548=
08>
Oct  8 12:00:20 xxx kernel: cpu: 1, clocks: 2654808, slice: 884936
Oct  8 12:00:20 xxx kernel: CPU1<T0:2654800,T1:884928,D:0,S:884936,C:265480=
8>
Oct  8 12:00:20 xxx kernel: checking TSC synchronization across CPUs: passe=
d.
Oct  8 12:00:20 xxx kernel: mtrr: your CPUs had inconsistent fixed MTRR set=
tings
Oct  8 12:00:20 xxx kernel: mtrr: probably your BIOS does not setup all CPUs
Oct  8 12:00:20 xxx kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, l=
ast bus=3D1
Oct  8 12:00:20 xxx kernel: PCI: Using configuration type 1
Oct  8 12:00:20 xxx kernel: PCI: Probing PCI hardware
Oct  8 12:00:20 xxx kernel: Unknown bridge resource 0: assuming transparent
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B0,I13,P0) -> 16
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B0,I13,P1) -> 17
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 18
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B0,I16,P0) -> 19
Oct  8 12:00:20 xxx kernel: PCI->APIC IRQ transform: (B1,I5,P0) -> 17
Oct  8 12:00:20 xxx kernel: isapnp: Scanning for PnP cards...
Oct  8 12:00:20 xxx kernel: isapnp: No Plug & Play device found
Oct  8 12:00:20 xxx kernel: Linux NET4.0 for Linux 2.4
Oct  8 12:00:20 xxx kernel: Based upon Swansea University Computer Society =
NET3.039
Oct  8 12:00:20 xxx kernel: Initializing RT netlink socket
Oct  8 12:00:20 xxx kernel: apm: BIOS not found.
Oct  8 12:00:20 xxx kernel: Starting kswapd
Oct  8 12:00:20 xxx kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Oct  8 12:00:20 xxx kernel: SGI XFS with ACLs, EAs, DMAPI, quota, no debug =
enabled
Oct  8 12:00:20 xxx kernel: pty: 256 Unix98 ptys configured
Oct  8 12:00:20 xxx kernel: Serial driver version 5.05c (2001-07-08) with M=
ANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Oct  8 12:00:20 xxx kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Oct  8 12:00:20 xxx kernel: block: 128 slots per queue, batch=3D16
Oct  8 12:00:20 xxx kernel: Uniform Multi-Platform E-IDE driver Revision: 6=
.31
Oct  8 12:00:20 xxx kernel: ide: Assuming 33MHz system bus speed for PIO mo=
des; override with idebus=3Dxx
Oct  8 12:00:20 xxx kernel: AMD7411: IDE controller on PCI bus 00 dev 39
Oct  8 12:00:20 xxx kernel: PCI: Enabling device 00:07.1 (0000 -> 0001)
Oct  8 12:00:20 xxx kernel: AMD7411: chipset revision 1
Oct  8 12:00:20 xxx kernel: AMD7411: not 100%% native mode: will probe irqs=
 later
Oct  8 12:00:20 xxx kernel: AMD7411: disabling single-word DMA support (rev=
ision < C4)
Oct  8 12:00:20 xxx kernel: AMD7411: simplex device: DMA will fail!!
Oct  8 12:00:20 xxx kernel: AMD7411: neither IDE port enabled (BIOS)
Oct  8 12:00:20 xxx kernel: Floppy drive(s): fd0 is 1.44M
Oct  8 12:00:20 xxx kernel: FDC 0 is a post-1991 82077
Oct  8 12:00:20 xxx kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Oct  8 12:00:20 xxx kernel: agpgart: Maximum main memory to use for agp mem=
ory: 439M
Oct  8 12:00:20 xxx kernel: agpgart: Detected AMD AMD 760MP chipset
Oct  8 12:00:20 xxx kernel: agpgart: AGP aperture is 64M @ 0xec000000
Oct  8 12:00:20 xxx kernel: SCSI subsystem driver Revision: 1.00
Oct  8 12:00:20 xxx kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA D=
RIVER, Rev 6.2.1
Oct  8 12:00:20 xxx kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Oct  8 12:00:20 xxx kernel:         aic7899: Ultra160 Wide Channel A, SCSI =
Id=3D7, 32/255 SCBs
Oct  8 12:00:20 xxx kernel:=20
Oct  8 12:00:20 xxx kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA D=
RIVER, Rev 6.2.1
Oct  8 12:00:20 xxx kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Oct  8 12:00:20 xxx kernel:         aic7899: Ultra160 Wide Channel B, SCSI =
Id=3D7, 32/255 SCBs
Oct  8 12:00:20 xxx kernel:=20
Oct  8 12:00:20 xxx kernel:   Vendor: IBM       Model: DDYS-T36950N      Re=
v: S93E
Oct  8 12:00:20 xxx kernel:   Type:   Direct-Access                      AN=
SI SCSI revision: 03
Oct  8 12:00:20 xxx kernel: (scsi0:A:3): 160.000MB/s transfers (80.000MHz D=
T, offset 63, 16bit)
Oct  8 12:00:20 xxx kernel: scsi0:0:3:0: Tagged Queuing enabled.  Depth 253
Oct  8 12:00:20 xxx kernel:   Vendor: HP        Model: CD-Writer+ 9600   Re=
v: 1.0a
Oct  8 12:00:20 xxx kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 04
Oct  8 12:00:20 xxx kernel: (scsi1:A:4): 10.000MB/s transfers (10.000MHz, o=
ffset 15)
Oct  8 12:00:20 xxx kernel: Attached scsi disk sda at scsi0, channel 0, id =
3, lun 0
Oct  8 12:00:20 xxx kernel: SCSI device sda: 71687340 512-byte hdwr sectors=
 (36704 MB)
Oct  8 12:00:20 xxx kernel: Partition check:
Oct  8 12:00:20 xxx kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9=
 sda10 sda11 sda12 >
Oct  8 12:00:20 xxx kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, i=
d 4, lun 0
Oct  8 12:00:20 xxx kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/f=
orm2 cdda tray
Oct  8 12:00:20 xxx kernel: Uniform CD-ROM driver Revision: 3.12
Oct  8 12:00:20 xxx kernel: es1371: version v0.30 time 09:44:51 Sep 26 2001
Oct  8 12:00:20 xxx kernel: usb.c: registered new driver hub
Oct  8 12:00:20 xxx kernel: uhci.c: :USB Universal Host Controller Interfac=
e driver
Oct  8 12:00:20 xxx kernel: Initializing USB Mass Storage driver...
Oct  8 12:00:20 xxx kernel: usb.c: registered new driver usb-storage
Oct  8 12:00:20 xxx kernel: USB Mass Storage support registered.
Oct  8 12:00:20 xxx kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct  8 12:00:20 xxx kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Oct  8 12:00:20 xxx kernel: IP: routing cache hash table of 4096 buckets, 3=
2Kbytes
Oct  8 12:00:20 xxx kernel: TCP: Hash tables configured (established 32768 =
bind 32768)
Oct  8 12:00:20 xxx kernel: Linux IP multicast router 0.06 plus PIM-SM
Oct  8 12:00:20 xxx kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET=
4.0.
Oct  8 12:00:20 xxx kernel: VFS: Mounted root (ext2 filesystem) readonly.
Oct  8 12:00:20 xxx kernel: Freeing unused kernel memory: 224k freed
Oct  8 12:00:20 xxx kernel: Adding Swap: 746980k swap-space (priority -1)
Oct  8 12:00:20 xxx kernel: 3c59x: Donald Becker and others. www.scyld.com/=
network/vortex.html
Oct  8 12:00:20 xxx kernel: 00:0f.0: 3Com PCI 3c982 Dual Port Server Cyclon=
e at 0x1800. Vers LK1.1.16
Oct  8 12:00:20 xxx kernel: 00:10.0: 3Com PCI 3c982 Dual Port Server Cyclon=
e at 0x1880. Vers LK1.1.16
Oct  8 12:00:25 xxx kernel: eth0: Setting promiscuous mode.
Oct  8 12:00:25 xxx kernel: device eth0 entered promiscuous mode
Oct  8 12:05:16 xxx kernel: XFS mounting filesystem sd(8,12)
Oct  8 12:05:16 xxx kernel: Starting XFS recovery on filesystem: sd(8,12) (=
dev: 8/12)
Oct  8 12:05:17 xxx kernel: Ending XFS recovery on filesystem: sd(8,12) (de=
v: 8/12)

--J2SCkAp4GZ/dPZZf--

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7xadksx0Gg+/oFjURAjj9AKCCLInqU1XtaDPBGGgSBM0ygJrOhACfblje
clUF2QYUwbqni3I1AscaJRI=
=D8xO
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
