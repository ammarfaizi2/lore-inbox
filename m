Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130586AbQKLNYP>; Sun, 12 Nov 2000 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130542AbQKLNYF>; Sun, 12 Nov 2000 08:24:05 -0500
Received: from ns01.rockhopper.com ([216.37.139.10]:2319 "EHLO
	cgpro.rockhopper.com") by vger.kernel.org with ESMTP
	id <S130547AbQKLNXx>; Sun, 12 Nov 2000 08:23:53 -0500
Mime-Version: 1.0
Message-Id: <a05001903b634498aa981@[216.37.139.198]>
Date: Sun, 12 Nov 2000 08:22:27 -0500
To: linux-kernel@vger.kernel.org
From: Barrie Selack <barrie@rockhopper.com>
Subject: unknown bus type 130 & can't decode I/O address space 0xbc00 in
 multibus PCI
Content-Type: multipart/alternative; boundary="============_-1238087135==_ma============"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--============_-1238087135==_ma============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"


I had posted this to the newsgroup.. then realized I should post to 
the mailing list (which I joined)

messages from boot with test11-pre (same results with test10)

Seems to be problems identifying the bus (there are 4 plug-in 4 slot
pci chambers) The machine is a NetFrame 9016 with 2 GB ram. The system
runs, but has problems identifying cards in the various chambers. For
example the ethernet (tulip) card is identified in all chambers, but
only function correctly in the first chamber. The QLogic 1041 is
identified in all, but doesn't work in any.

Any advice or help would be appreciated.

Regards,

Barrie Selack



Nov 10 22:27:25 netframe syslogd 1.3-3: restart.
Nov 10 22:27:25 netframe syslog: syslogd startup succeeded
Nov 10 22:27:25 netframe kernel: klogd 1.3-3, log source = /proc/kmsg
started.
Nov 10 22:27:25 netframe kernel: Inspecting /boot/System.map
Nov 10 22:27:25 netframe syslog: klogd startup succeeded
Nov 10 22:27:25 netframe kernel: Symbol table has incorrect version
number.
Nov 10 22:27:25 netframe kernel: Cannot find map file.
Nov 10 22:27:25 netframe kernel: No module symbols loaded.
Nov 10 22:27:25 netframe kernel: Linux version 2.4.0-test11
(root@netframe.rockhopper.com) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #6 SMP Fri Nov 10 22:03:51 EST
2000
Nov 10 22:27:25 netframe kernel: BIOS-provided physical RAM map:
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 000000000009fc00 @
0000000000000000 (usable)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 0000000000000400 @
000000000009fc00 (reserved)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 0000000000007670 @
00000000000e716f (reserved)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 000000000000dccc @
00000000000f2334 (reserved)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 000000007ff00000 @
0000000000100000 (usable)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 0000000000100000 @
00000000fec00000 (reserved)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 0000000000100000 @
00000000fee00000 (reserved)
Nov 10 22:27:25 netframe kernel:  BIOS-e820: 000000000000dccc @
00000000ffff2334 (reserved)
Nov 10 22:27:25 netframe kernel: 1152MB HIGHMEM available.
Nov 10 22:27:25 netframe identd: identd startup succeeded
Nov 10 22:27:25 netframe kernel: Scan SMP from c0000000 for 1024
bytes.
Nov 10 22:27:26 netframe kernel: Scan SMP from c009fc00 for 1024
bytes.
Nov 10 22:27:26 netframe kernel: Scan SMP from c00f0000 for 65536
bytes.
Nov 10 22:27:26 netframe kernel: found SMP MP-table at 000fbd20
Nov 10 22:27:26 netframe kernel: hm, page 000fb000 reserved twice.
Nov 10 22:27:26 netframe kernel: hm, page 000fc000 reserved twice.
Nov 10 22:27:26 netframe kernel: hm, page 0009f000 reserved twice.
Nov 10 22:27:26 netframe kernel: hm, page 000a0000 reserved twice.
Nov 10 22:27:26 netframe atd: atd startup succeeded
Nov 10 22:27:26 netframe kernel: On node 0 totalpages: 524288
Nov 10 22:27:26 netframe kernel: zone(0): 4096 pages.
Nov 10 22:27:26 netframe kernel: zone(1): 225280 pages.
Nov 10 22:27:26 netframe kernel: zone(2): 294912 pages.
Nov 10 22:27:26 netframe kernel: Intel MultiProcessor Specification
v1.4
Nov 10 22:27:26 netframe kernel:     Virtual Wire compatibility mode.
Nov 10 22:27:26 netframe kernel: OEM ID: INTEL    Product ID: ORION
APIC at: 0xFEE00000
Nov 10 22:27:26 netframe kernel: Processor #1 Pentium(tm) Pro APIC
version 17
Nov 10 22:27:26 netframe kernel:     Floating point unit present.
Nov 10 22:27:26 netframe kernel:     Machine Exception supported.
Nov 10 22:27:26 netframe kernel:     64 bit compare & exchange
supported.
Nov 10 22:27:11 netframe rc.sysinit: Mounting proc filesystem
succeeded
Nov 10 22:27:26 netframe kernel:     Internal APIC present.
Nov 10 22:27:11 netframe sysctl: net.ipv4.ip_forward = 0
Nov 10 22:27:26 netframe kernel:     Bootup CPU
Nov 10 22:27:11 netframe sysctl: net.ipv4.conf.all.rp_filter = 1
Nov 10 22:27:26 netframe kernel: Processor #0 Pentium(tm) Pro APIC
version 17
Nov 10 22:27:11 netframe sysctl: error: 'net.ipv4.ip_always_defrag' is
an unknown key
Nov 10 22:27:26 netframe kernel:     Floating point unit present.
Nov 10 22:27:11 netframe sysctl: error: 'kernel.sysrq' is an unknown
key
Nov 10 22:27:26 netframe kernel:     Machine Exception supported.
Nov 10 22:27:26 netframe crond: crond startup succeeded
Nov 10 22:27:11 netframe rc.sysinit: Configuring kernel parameters
succeeded
Nov 10 22:27:26 netframe kernel:     64 bit compare & exchange
supported.
Nov 10 22:27:11 netframe date: Fri Nov 10 22:27:10 EST 2000
Nov 10 22:27:27 netframe kernel:     Internal APIC present.
Nov 10 22:27:27 netframe pcmcia: Starting PCMCIA services:
Nov 10 22:27:11 netframe rc.sysinit: Setting clock : Fri Nov 10
22:27:10 EST 2000 succeeded
Nov 10 22:27:27 netframe kernel: Bus #0 is PCI   
Nov 10 22:27:27 netframe pcmcia:  modules cardmgr.
Nov 10 22:27:11 netframe rc.sysinit: Loading default keymap succeeded
Nov 10 22:27:27 netframe cardmgr[473]: starting, version is 3.1.8
Nov 10 22:27:27 netframe kernel: Bus #1 is PCI   
Nov 10 22:27:27 netframe pcmcia:
/lib/modules/2.4.0-test11/pcmcia/pcmcia_core.o:
/lib/modules/2.4.0-test11/pcmcia/pcmcia_core.o: No such file or
directory
Nov 10 22:27:11 netframe rc.sysinit: Activating swap partitions
succeeded
Nov 10 22:27:27 netframe kernel: Bus #2 is PCI   
Nov 10 22:27:27 netframe pcmcia:
/lib/modules/2.4.0-test11/pcmcia/tcic.o:
/lib/modules/2.4.0-test11/pcmcia/tcic.o: No such file or directory
Nov 10 22:27:27 netframe cardmgr[473]: no pcmcia driver in
/proc/devices
Nov 10 22:27:11 netframe rc.sysinit: Setting hostname
netframe.rockhopper.com succeeded
Nov 10 22:27:27 netframe kernel: Bus #35 is PCI   
Nov 10 22:27:27 netframe pcmcia:
/lib/modules/2.4.0-test11/pcmcia/ds.o:
/lib/modules/2.4.0-test11/pcmcia/ds.o: No such file or directory
Nov 10 22:27:27 netframe cardmgr[473]: exiting
Nov 10 22:27:11 netframe fsck: /dev/sda5: clean, 67262/263296 files,
299668/526120 blocks
Nov 10 22:27:27 netframe kernel: Bus #128 is PCI   
Nov 10 22:27:28 netframe rc: Starting pcmcia succeeded
Nov 10 22:27:11 netframe rc.sysinit: Checking root filesystem
succeeded
Nov 10 22:27:28 netframe kernel: Bus #130 is PCI   
Nov 10 22:27:11 netframe rc.sysinit: Remounting root filesystem in
read-write mode succeeded
Nov 10 22:27:28 netframe kernel: Bus #163 is PCI   
Nov 10 22:27:11 netframe rc.sysinit: Finding module dependencies
succeeded
Nov 10 22:27:28 netframe inet: inetd startup succeeded
Nov 10 22:27:28 netframe kernel: Bus #176 is ISA   
Nov 10 22:27:11 netframe fsck: /dev/sda2: clean, 34/14056 files,
11119/56227 blocks
Nov 10 22:27:28 netframe kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Nov 10 22:27:11 netframe rc.sysinit: Checking filesystems succeeded
Nov 10 22:27:28 netframe kernel: I/O APIC #3 Version 17 at 0xFEC01000.
Nov 10 22:27:11 netframe rc.sysinit: Mounting local filesystems
succeeded
Nov 10 22:27:28 netframe lpd[501]: restarted
Nov 10 22:27:28 netframe kernel: I/O APIC #4 Version 17 at 0xFEC02000.
Nov 10 22:27:28 netframe lpd: lpd startup succeeded
Nov 10 22:27:11 netframe rc.sysinit: Turning on user and group quotas
for local filesystems succeeded
Nov 10 22:27:28 netframe kernel: Int: type 3, pol 1, trig 1, bus 176,
IRQ 02, APIC ID 2, APIC INT 02
Nov 10 22:27:12 netframe rc.sysinit: Enabling swap space succeeded
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 01, APIC ID 2, APIC INT 01
Nov 10 22:27:29 netframe keytable: Loading keymap:
Nov 10 22:27:12 netframe init: Entering runlevel: 3
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 00, APIC ID 2, APIC INT 00
Nov 10 22:27:29 netframe keytable: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Nov 10 22:27:22 netframe kudzu:  succeeded
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 03, APIC ID 2, APIC INT 03
Nov 10 22:27:29 netframe keytable: Loading system font:
Nov 10 22:27:23 netframe sysctl: net.ipv4.ip_forward = 0
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 04, APIC ID 2, APIC INT 04
Nov 10 22:27:29 netframe rc: Starting keytable succeeded
Nov 10 22:27:23 netframe sysctl: net.ipv4.conf.all.rp_filter = 1
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 05, APIC ID 2, APIC INT 05
Nov 10 22:27:23 netframe sysctl: error: 'net.ipv4.ip_always_defrag' is
an unknown key
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 06, APIC ID 2, APIC INT 06
Nov 10 22:27:23 netframe sysctl: error: 'kernel.sysrq' is an unknown
key
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 07, APIC ID 2, APIC INT 07
Nov 10 22:27:23 netframe network: Setting network parameters succeeded
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 08, APIC ID 2, APIC INT 08
Nov 10 22:27:23 netframe network: Bringing up interface lo succeeded
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 09, APIC ID 2, APIC INT 09
Nov 10 22:27:24 netframe network: Bringing up interface eth0 succeeded
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 0c, APIC ID 2, APIC INT 0c
Nov 10 22:27:24 netframe portmap: portmap startup succeeded
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 0d, APIC ID 2, APIC INT 0d
Nov 10 22:27:24 netframe rpc.lockd: lockdsvc: Invalid argument
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus 176,
IRQ 0f, APIC ID 2, APIC INT 0f
Nov 10 22:27:24 netframe nfslock: rpc.lockd startup failed
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 3, bus 0,
IRQ 0c, APIC ID 2, APIC INT 0e
Nov 10 22:27:24 netframe nfslock: rpc.statd startup succeeded
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 2,
IRQ 10, APIC ID 3, APIC INT 03
Nov 10 22:27:24 netframe random: Initializing random number generator
succeeded
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 2,
IRQ 14, APIC ID 3, APIC INT 04
Nov 10 22:27:25 netframe netfs: Mounting other filesystems succeeded
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 2,
IRQ 18, APIC ID 3, APIC INT 05
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 2,
IRQ 1c, APIC ID 3, APIC INT 06
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 35,
IRQ 10, APIC ID 3, APIC INT 09
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 35,
IRQ 14, APIC ID 3, APIC INT 0a
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 35,
IRQ 18, APIC ID 3, APIC INT 0b
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 35,
IRQ 1c, APIC ID 3, APIC INT 0c
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 130,
IRQ 10, APIC ID 4, APIC INT 03
Nov 10 22:27:31 netframe sendmail: sendmail startup succeeded
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 130,
IRQ 14, APIC ID 4, APIC INT 04
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 130,
IRQ 18, APIC ID 4, APIC INT 05
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 130,
IRQ 1c, APIC ID 4, APIC INT 06
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 163,
IRQ 10, APIC ID 4, APIC INT 09
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus 163,
IRQ 14, APIC ID 4, APIC INT 0a
Nov 10 22:27:32 netframe kernel: Int: type 0, pol 1, trig 3, bus 163,
IRQ 18, APIC ID 4, APIC INT 0b
Nov 10 22:27:32 netframe kernel: Int: type 0, pol 1, trig 3, bus 163,
IRQ 1c, APIC ID 4, APIC INT 0c
Nov 10 22:27:32 netframe gpm: gpm startup succeeded
Nov 10 22:27:32 netframe kernel: Lint: type 3, pol 1, trig 1, bus 176,
IRQ 00, APIC ID ff, APIC LINT 00
Nov 10 22:27:32 netframe kernel: Lint: type 1, pol 1, trig 1, bus 176,
IRQ 00, APIC ID ff, APIC LINT 01
Nov 10 22:27:32 netframe kernel: Processors: 2
Nov 10 22:27:32 netframe kernel: mapped APIC to ffffe000 (fee00000)
Nov 10 22:27:32 netframe kernel: mapped IOAPIC to ffffd000 (fec00000)
Nov 10 22:27:32 netframe kernel: mapped IOAPIC to ffffc000 (fec01000)
Nov 10 22:27:32 netframe kernel: mapped IOAPIC to ffffb000 (fec02000)
Nov 10 22:27:32 netframe kernel: Kernel command line:
BOOT_IMAGE=linux-2.4-pre2 ro root=805
Nov 10 22:27:32 netframe kernel: Initializing CPU#0
Nov 10 22:27:32 netframe kernel: Detected 199.449 MHz processor.
Nov 10 22:27:32 netframe kernel: Console: colour VGA+ 80x25
Nov 10 22:27:32 netframe kernel: Calibrating delay loop... 397.31
BogoMIPS
Nov 10 22:27:32 netframe kernel: Memory: 2059244k/2097152k available
(1883k kernel code, 37520k reserved, 104k data, 216k init, 1179648k
highmem)
Nov 10 22:27:32 netframe kernel: Dentry-cache hash table entries:
262144 (order: 9, 2097152 bytes)
Nov 10 22:27:32 netframe kernel: Buffer-cache hash table entries:
131072 (order: 7, 524288 bytes)
Nov 10 22:27:32 netframe kernel: Page-cache hash table entries: 524288
(order: 9, 2097152 bytes)
Nov 10 22:27:32 netframe kernel: Inode-cache hash table entries:
131072 (order: 8, 1048576 bytes)
Nov 10 22:27:32 netframe kernel: Checking 'hlt' instruction... OK.
Nov 10 22:27:32 netframe kernel: POSIX conformance testing by UNIFIX
Nov 10 22:27:33 netframe kernel: mtrr: v1.36 (20000221) Richard Gooch
(rgooch@atnf.csiro.au)
Nov 10 22:27:33 netframe kernel: Intel machine check architecture
supported.
Nov 10 22:27:33 netframe kernel: Intel machine check reporting enabled
on CPU#0.
Nov 10 22:27:33 netframe kernel: CPU0: Intel Pentium Pro stepping 09
Nov 10 22:27:33 netframe kernel: per-CPU timeslice cutoff: 2920.65
usecs.
Nov 10 22:27:33 netframe kernel: Getting VERSION: 40011
Nov 10 22:27:33 netframe kernel: Getting VERSION: 40011
Nov 10 22:27:33 netframe kernel: Getting ID: 1000000
Nov 10 22:27:33 netframe kernel: Getting ID: e000000
Nov 10 22:27:33 netframe kernel: Getting LVT0: 700
Nov 10 22:27:33 netframe kernel: Getting LVT1: 400
Nov 10 22:27:33 netframe kernel: enabled ExtINT on CPU#0
Nov 10 22:27:33 netframe kernel: ESR value before enabling vector:
00000000
Nov 10 22:27:33 netframe kernel: ESR value after enabling vector:
00000000
Nov 10 22:27:33 netframe kernel: CPU present map: 3
Nov 10 22:27:33 netframe kernel: Booting processor 1/0 eip 2000
Nov 10 22:27:33 netframe kernel: Setting warm reset code and vector.
Nov 10 22:27:33 netframe kernel: 1.
Nov 10 22:27:33 netframe kernel: 2.
Nov 10 22:27:33 netframe kernel: 3.
Nov 10 22:27:33 netframe kernel: Asserting INIT.
Nov 10 22:27:33 netframe kernel: Waiting for send to finish...
Nov 10 22:27:33 netframe kernel: +Deasserting INIT.
Nov 10 22:27:33 netframe kernel: Waiting for send to finish...
Nov 10 22:27:33 netframe kernel: +#startup loops: 2.
Nov 10 22:27:34 netframe kernel: Sending STARTUP #1.
Nov 10 22:27:34 netframe kernel: After apic_write.
Nov 10 22:27:34 netframe xfs: xfs startup succeeded
Nov 10 22:27:34 netframe kernel: Startup point 1.
Nov 10 22:27:34 netframe xfs: Warning: The directory
"/usr/share/fonts/default/TrueType" does not exist.
Nov 10 22:27:34 netframe kernel: Waiting for send to finish...
Nov 10 22:27:34 netframe xfs:          Entry deleted from font path.
Nov 10 22:27:34 netframe kernel: +Initializing CPU#1
Nov 10 22:27:34 netframe kernel: CPU#1 (phys ID: 0) waiting for
CALLOUT
Nov 10 22:27:34 netframe linuxconf: Linuxconf final setup
Nov 10 22:27:34 netframe kernel: Sending STARTUP #2.
Nov 10 22:27:34 netframe kernel: After apic_write.
Nov 10 22:27:34 netframe kernel: Startup point 1.
Nov 10 22:27:34 netframe kernel: Waiting for send to finish...
Nov 10 22:27:34 netframe kernel: +After Startup.
Nov 10 22:27:35 netframe kernel: Before Callout 1.
Nov 10 22:27:35 netframe kernel: After Callout 1.
Nov 10 22:27:35 netframe kernel: CALLIN, before setup_local_APIC().
Nov 10 22:27:35 netframe kernel: masked ExtINT on CPU#1
Nov 10 22:27:35 netframe kernel: ESR value before enabling vector:
00000000
Nov 10 22:27:35 netframe kernel: ESR value after enabling vector:
00000000
Nov 10 22:27:35 netframe kernel: Calibrating delay loop... 398.13
BogoMIPS
Nov 10 22:27:35 netframe kernel: Stack at about c3229fbc
Nov 10 22:27:35 netframe kernel: Intel machine check reporting enabled
on CPU#1.
Nov 10 22:27:35 netframe kernel: OK.
Nov 10 22:27:35 netframe kernel: CPU1: Intel Pentium Pro stepping 09
Nov 10 22:27:35 netframe kernel: CPU has booted.
Nov 10 22:27:35 netframe kernel: Before bogomips.
Nov 10 22:27:35 netframe kernel: Total of 2 processors activated
(795.44 BogoMIPS).
Nov 10 22:27:36 netframe kernel: Before bogocount - setting
activated=1.
Nov 10 22:27:36 netframe kernel: Boot done.
Nov 10 22:27:36 netframe kernel: ENABLING IO-APIC IRQs
Nov 10 22:27:36 netframe kernel: ...changing IO-APIC physical APIC ID
to 2 ... ok.
Nov 10 22:27:36 netframe kernel: ...changing IO-APIC physical APIC ID
to 3 ... ok.
Nov 10 22:27:36 netframe kernel: ...changing IO-APIC physical APIC ID
to 4 ... ok.
Nov 10 22:27:36 netframe kernel: Synchronizing Arb IDs.
Nov 10 22:27:36 netframe kernel: unknown bus type 130.
Nov 10 22:27:36 netframe last message repeated 2 times
Nov 10 22:27:36 netframe kernel: , 4-7, 4-8<3>unknown bus type 130.
Nov 10 22:27:36 netframe kernel: unknown bus type 130.
Nov 10 22:27:37 netframe last message repeated 14 times
Nov 10 22:27:37 netframe kernel: , 4-13, 4-14, 4-15 not connected.
Nov 10 22:27:37 netframe kernel: ..TIMER: vector=49 pin1=0 pin2=-1
Nov 10 22:27:37 netframe kernel: activating NMI Watchdog ... done.
Nov 10 22:27:37 netframe kernel: testing the IO
APIC.......................
Nov 10 22:27:37 netframe kernel: 
Nov 10 22:27:37 netframe last message repeated 2 times
Nov 10 22:27:37 netframe kernel: ....................................
done.
Nov 10 22:27:37 netframe kernel: calibrating APIC timer ...
Nov 10 22:27:37 netframe kernel: ..... CPU clock speed is 199.4448
MHz.
Nov 10 22:27:37 netframe kernel: ..... host bus clock speed is 66.4814
MHz.
Nov 10 22:27:37 netframe kernel: cpu: 0, clocks: 664814, slice: 221604
Nov 10 22:27:37 netframe kernel:
CPU0<T0:664800,T1:443184,D:12,S:221604,C:664814>
Nov 10 22:27:37 netframe kernel: cpu: 1, clocks: 664814, slice: 221604
Nov 10 22:27:37 netframe kernel:
CPU1<T0:664800,T1:221584,D:8,S:221604,C:664814>
Nov 10 22:27:37 netframe kernel: checking TSC synchronization across
CPUs: passed.
Nov 10 22:27:37 netframe kernel: Setting commenced=1, go go go
Nov 10 22:27:37 netframe kernel: PCI: PCI BIOS revision 2.10 entry at
0xf5c0d, last bus=254
Nov 10 22:27:37 netframe kernel: PCI: Using configuration type 1
Nov 10 22:27:37 netframe kernel: PCI: Probing PCI hardware
Nov 10 22:27:37 netframe rc: Starting linuxconf succeeded
Nov 10 22:27:37 netframe kernel: PCI: i440KX/GX host bridge 00:19.0:
secondary bus 00
Nov 10 22:27:37 netframe kernel: PCI: i440KX/GX host bridge 00:1a.0:
secondary bus 01
Nov 10 22:27:37 netframe kernel: PCI: i440KX/GX host bridge 00:1b.0:
secondary bus 81
Nov 10 22:27:37 netframe kernel: PCI->APIC IRQ transform: (B0,I3,P0)
-> 14
Nov 10 22:27:37 netframe kernel: PCI->APIC IRQ transform: (B2,I5,P0)
-> 20
Nov 10 22:27:37 netframe kernel: PCI->APIC IRQ transform: (B2,I6,P0)
-> 21
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource region
9 of bridge 01:02.0
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource region
9 of bridge 01:03.0
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource region
9 of bridge 81:02.0
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource region
9 of bridge 81:03.0
Nov 10 22:27:37 netframe kernel: isapnp: Scanning for Pnp cards...
Nov 10 22:27:37 netframe kernel: isapnp: No Plug & Play device found
Nov 10 22:27:37 netframe kernel: Linux NET4.0 for Linux 2.4
Nov 10 22:27:37 netframe kernel: Based upon Swansea University
Computer Society NET3.039
Nov 10 22:27:37 netframe kernel: Starting kswapd v1.8
Nov 10 22:27:37 netframe kernel: pty: 256 Unix98 ptys configured
Nov 10 22:27:37 netframe kernel: RAMDISK driver initialized: 16 RAM
disks of 4096K size 1024 blocksize
Nov 10 22:27:37 netframe kernel: loop: enabling 8 loop devices
Nov 10 22:27:37 netframe kernel: Floppy drive(s): fd0 is 1.44M
Nov 10 22:27:37 netframe kernel: FDC 0 is a post-1991 82077
Nov 10 22:27:37 netframe kernel: LVM version 0.8final  by Heinz
Mauelshagen  (15/02/2000)
Nov 10 22:27:37 netframe kernel: lvm -- Driver successfully
initialized
Nov 10 22:27:37 netframe kernel: Loading I2O Core - (c) Copyright 1999
Red Hat Software
Nov 10 22:27:37 netframe kernel: Linux I2O PCI support (c) 1999 Red
Hat Software.
Nov 10 22:27:37 netframe kernel: i2o: Checking for PCI I2O
controllers...
Nov 10 22:27:37 netframe kernel: I2O configuration manager v 0.04.
Nov 10 22:27:37 netframe kernel:   (C) Copyright 1999 Red Hat Software
Nov 10 22:27:37 netframe kernel: I2O Block Storage OSM v0.9
Nov 10 22:27:37 netframe kernel:    (c) Copyright 1999, 2000 Red Hat
Software.
Nov 10 22:27:37 netframe kernel: I2O LAN OSM (C) 1999 University of
Helsinki.
Nov 10 22:27:37 netframe kernel: udf: registering filesystem
Nov 10 22:27:37 netframe kernel: Serial driver version 5.02
(2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Nov 10 22:27:37 netframe kernel: ttyS00 at 0x03f8 (irq = 4) is a
16550A
Nov 10 22:27:38 netframe kernel: ttyS01 at 0x02f8 (irq = 3) is a
16550A
Nov 10 22:27:38 netframe kernel: Linux Tulip driver version 0.9.11
(November 3, 2000)
Nov 10 22:27:38 netframe kernel: eth0: Lite-On 82c168 PNIC rev 32 at
0xb800, 00:A0:CC:55:60:9D, IRQ 21.
Nov 10 22:27:38 netframe kernel: eth0:  MII transceiver #1 config 3000
status 7829 advertising 01e1.
Nov 10 22:27:38 netframe kernel: [drm] Initialized tdfx 1.0.0 20000928
on minor 63
Nov 10 22:27:38 netframe kernel: SCSI subsystem driver Revision: 1.00
Nov 10 22:27:38 netframe kernel: (scsi0) <Adaptec AIC-7870 SCSI host
adapter> found at PCI 0/3/0
Nov 10 22:27:38 netframe kernel: (scsi0) Wide Channel, SCSI ID=7,
16/255 SCBs
Nov 10 22:27:38 netframe kernel: (scsi0) Downloading sequencer code...
415 instructions downloaded
Nov 10 22:27:38 netframe kernel: scsi0 : Adaptec AHA274x/284x/294x
(EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Nov 10 22:27:38 netframe kernel:        <Adaptec AIC-7870 SCSI host
adapter>
Nov 10 22:27:38 netframe kernel: (scsi0:0:0:0) Synchronous at 10.0
Mbyte/sec, offset 15.
Nov 10 22:27:38 netframe kernel:   Vendor: SEAGATE   Model: ST15150N
Rev: 0023
Nov 10 22:27:38 netframe kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Nov 10 22:27:38 netframe kernel: (scsi0:0:5:0) Synchronous at 5.7
Mbyte/sec, offset 15.
Nov 10 22:27:38 netframe kernel:   Vendor: PLEXTOR   Model: CD-ROM
PX-4XCE    Rev: 1.04
Nov 10 22:27:38 netframe kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
Nov 10 22:27:38 netframe kernel: qlogicisp : new isp1020 revision ID
(5)
Nov 10 22:27:38 netframe kernel: qlogicisp : can't decode I/O address
space 0xbc00
Nov 10 22:27:38 netframe kernel: Detected scsi disk sda at scsi0,
channel 0, id 0, lun 0
Nov 10 22:27:38 netframe kernel: SCSI device sda: 8388315 512-byte
hdwr sectors (4295 MB)
Nov 10 22:27:38 netframe kernel: Partition check:
Nov 10 22:27:38 netframe kernel:  sda: sda1 sda2 sda3 < sda5 sda6 >
Nov 10 22:27:38 netframe kernel: Detected scsi CD-ROM sr0 at scsi0,
channel 0, id 5, lun 0
Nov 10 22:27:38 netframe kernel: Uniform CD-ROM driver Revision: 3.11
Nov 10 22:27:38 netframe kernel: i2o_scsi.c: Version 0.0.1
Nov 10 22:27:38 netframe kernel:   chain_pool: 0 bytes @ c322dba0
Nov 10 22:27:38 netframe kernel:   (512 byte buffers X 4 can_queue X 0
i2o controllers)
Nov 10 22:27:38 netframe kernel: md driver 0.90.0 MAX_MD_DEVS=256,
MAX_REAL=12
Nov 10 22:27:38 netframe kernel: raid1 personality registered
Nov 10 22:27:38 netframe kernel: md.c: sizeof(mdp_super_t) = 4096
Nov 10 22:27:38 netframe kernel: autodetecting RAID arrays
Nov 10 22:27:38 netframe kernel: autorun ...
Nov 10 22:27:38 netframe kernel: ... autorun DONE.
Nov 10 22:27:38 netframe kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 10 22:27:38 netframe kernel: IP Protocols: ICMP, UDP, TCP
Nov 10 22:27:38 netframe kernel: IP: routing cache hash table of 16384
buckets, 128Kbytes
Nov 10 22:27:38 netframe kernel: TCP: Hash tables configured
(established 131072 bind 65536)
Nov 10 22:27:38 netframe kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Nov 10 22:27:38 netframe kernel: kmem_create: Forcing size word
alignment - nfs_fh
Nov 10 22:27:38 netframe kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Nov 10 22:27:38 netframe kernel: Freeing unused kernel memory: 216k
freed
Nov 10 22:27:38 netframe kernel: Adding Swap: 530104k swap-space
(priority -1)
-- 
------------------------------------------------------------------

Rockhopper Communications, Inc.         bselack@rockhopper.com
280 Pleasant Hill Road                  http://www.rockhopper.com/
Lewisberry, PA 17339                    717 938-1581

--============_-1238087135==_ma============
Content-Type: text/html; charset="us-ascii"

<!doctype html public "-//W3C//DTD W3 HTML//EN">
<html><head><style type="text/css"><!--
blockquote, dl, ul, ol, li { margin-top: 0 ; margin-bottom: 0 }
 --></style><title>unknown bus type 130 &amp; can't decode I/O address
space</title></head><body>
<div><tt><font color="#000000"><br>
I had posted this to the newsgroup.. then realized I should post to
the mailing list (which I joined)</font></tt></div>
<div><tt><font color="#000000"><br></font></tt></div>
<div><tt><font color="#000000">messages from boot with test11-pre
(same results with test10)<br>
<br>
Seems to be problems identifying the bus (there are 4 plug-in 4
slot<br>
pci chambers) The machine is a NetFrame 9016 with 2 GB ram. The
system</font></tt></div>
<div><tt><font color="#000000">runs, but has problems identifying
cards in the various chambers. For</font></tt></div>
<div><tt><font color="#000000">example the ethernet (tulip) card is
identified in all chambers, but<br>
only function correctly in the first chamber. The QLogic 1041 is<br>
identified in all, but doesn't work in any.<br>
<br>
Any advice or help would be appreciated.<br>
<br>
Regards,<br>
<br>
Barrie Selack<br>
<br>
<br>
<br>
Nov 10 22:27:25 netframe syslogd 1.3-3: restart.<br>
Nov 10 22:27:25 netframe syslog: syslogd startup succeeded<br>
Nov 10 22:27:25 netframe kernel: klogd 1.3-3, log source =
/proc/kmsg<br>
started.<br>
Nov 10 22:27:25 netframe kernel: Inspecting /boot/System.map<br>
Nov 10 22:27:25 netframe syslog: klogd startup succeeded<br>
Nov 10 22:27:25 netframe kernel: Symbol table has incorrect
version<br>
number.<br>
Nov 10 22:27:25 netframe kernel: Cannot find map file.<br>
Nov 10 22:27:25 netframe kernel: No module symbols loaded.<br>
Nov 10 22:27:25 netframe kernel: Linux version 2.4.0-test11<br>
(root@netframe.rockhopper.com) (gcc version egcs-2.91.66<br>
19990314/Linux (egcs-1.1.2 release)) #6 SMP Fri Nov 10 22:03:51
EST<br>
2000<br>
Nov 10 22:27:25 netframe kernel: BIOS-provided physical RAM map:<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 000000000009fc00
@<br>
0000000000000000 (usable)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 0000000000000400
@<br>
000000000009fc00 (reserved)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 0000000000007670
@<br>
00000000000e716f (reserved)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 000000000000dccc
@<br>
00000000000f2334 (reserved)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 000000007ff00000
@<br>
0000000000100000 (usable)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 0000000000100000
@<br>
00000000fec00000 (reserved)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 0000000000100000
@<br>
00000000fee00000 (reserved)<br>
Nov 10 22:27:25 netframe kernel:&nbsp; BIOS-e820: 000000000000dccc
@<br>
00000000ffff2334 (reserved)<br>
Nov 10 22:27:25 netframe kernel: 1152MB HIGHMEM available.<br>
Nov 10 22:27:25 netframe identd: identd startup succeeded<br>
Nov 10 22:27:25 netframe kernel: Scan SMP from c0000000 for 1024<br>
bytes.<br>
Nov 10 22:27:26 netframe kernel: Scan SMP from c009fc00 for 1024<br>
bytes.<br>
Nov 10 22:27:26 netframe kernel: Scan SMP from c00f0000 for 65536<br>
bytes.<br>
Nov 10 22:27:26 netframe kernel: found SMP MP-table at 000fbd20<br>
Nov 10 22:27:26 netframe kernel: hm, page 000fb000 reserved twice.<br>
Nov 10 22:27:26 netframe kernel: hm, page 000fc000 reserved twice.<br>
Nov 10 22:27:26 netframe kernel: hm, page 0009f000 reserved twice.<br>
Nov 10 22:27:26 netframe kernel: hm, page 000a0000 reserved twice.<br>
Nov 10 22:27:26 netframe atd: atd startup succeeded<br>
Nov 10 22:27:26 netframe kernel: On node 0 totalpages: 524288<br>
Nov 10 22:27:26 netframe kernel: zone(0): 4096 pages.<br>
Nov 10 22:27:26 netframe kernel: zone(1): 225280 pages.<br>
Nov 10 22:27:26 netframe kernel: zone(2): 294912 pages.<br>
Nov 10 22:27:26 netframe kernel: Intel MultiProcessor
Specification<br>
v1.4<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Virtual Wire
compatibility mode.<br>
Nov 10 22:27:26 netframe kernel: OEM ID: INTEL&nbsp;&nbsp;&nbsp;
Product ID: ORION<br>
APIC at: 0xFEE00000<br>
Nov 10 22:27:26 netframe kernel: Processor #1 Pentium(tm) Pro APIC<br>
version 17<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Floating
point unit present.<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Machine
Exception supported.<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; 64 bit
compare &amp; exchange<br>
supported.<br>
Nov 10 22:27:11 netframe rc.sysinit: Mounting proc filesystem<br>
succeeded<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Internal APIC
present.<br>
Nov 10 22:27:11 netframe sysctl: net.ipv4.ip_forward = 0<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Bootup
CPU<br>
Nov 10 22:27:11 netframe sysctl: net.ipv4.conf.all.rp_filter = 1<br>
Nov 10 22:27:26 netframe kernel: Processor #0 Pentium(tm) Pro
APIC</font></tt></div>
<div><tt><font color="#000000">version 17<br>
Nov 10 22:27:11 netframe sysctl: error: 'net.ipv4.ip_always_defrag'
is<br>
an unknown key<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Floating
point unit present.<br>
Nov 10 22:27:11 netframe sysctl: error: 'kernel.sysrq' is an
unknown<br>
key<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Machine
Exception supported.<br>
Nov 10 22:27:26 netframe crond: crond startup succeeded<br>
Nov 10 22:27:11 netframe rc.sysinit: Configuring kernel parameters<br>
succeeded<br>
Nov 10 22:27:26 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; 64 bit
compare &amp; exchange<br>
supported.<br>
Nov 10 22:27:11 netframe date: Fri Nov 10 22:27:10 EST 2000<br>
Nov 10 22:27:27 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp; Internal APIC
present.<br>
Nov 10 22:27:27 netframe pcmcia: Starting PCMCIA services:<br>
Nov 10 22:27:11 netframe rc.sysinit: Setting clock : Fri Nov 10<br>
22:27:10 EST 2000 succeeded<br>
Nov 10 22:27:27 netframe kernel: Bus #0 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:27 netframe pcmcia:&nbsp; modules cardmgr.<br>
Nov 10 22:27:11 netframe rc.sysinit: Loading default keymap
succeeded<br>
Nov 10 22:27:27 netframe cardmgr[473]: starting, version is 3.1.8<br>
Nov 10 22:27:27 netframe kernel: Bus #1 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:27 netframe pcmcia:<br>
/lib/modules/2.4.0-test11/pcmcia/pcmcia_core.o:<br>
/lib/modules/2.4.0-test11/pcmcia/pcmcia_core.o: No such file or<br>
directory<br>
Nov 10 22:27:11 netframe rc.sysinit: Activating swap partitions<br>
succeeded<br>
Nov 10 22:27:27 netframe kernel: Bus #2 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:27 netframe pcmcia:<br>
/lib/modules/2.4.0-test11/pcmcia/tcic.o:<br>
/lib/modules/2.4.0-test11/pcmcia/tcic.o: No such file or directory<br>
Nov 10 22:27:27 netframe cardmgr[473]: no pcmcia driver in<br>
/proc/devices<br>
Nov 10 22:27:11 netframe rc.sysinit: Setting hostname<br>
netframe.rockhopper.com succeeded<br>
Nov 10 22:27:27 netframe kernel: Bus #35 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:27 netframe pcmcia:<br>
/lib/modules/2.4.0-test11/pcmcia/ds.o:<br>
/lib/modules/2.4.0-test11/pcmcia/ds.o: No such file or directory<br>
Nov 10 22:27:27 netframe cardmgr[473]: exiting<br>
Nov 10 22:27:11 netframe fsck: /dev/sda5: clean, 67262/263296
files,<br>
299668/526120 blocks<br>
Nov 10 22:27:27 netframe kernel: Bus #128 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:28 netframe rc: Starting pcmcia succeeded<br>
Nov 10 22:27:11 netframe rc.sysinit: Checking root filesystem<br>
succeeded<br>
Nov 10 22:27:28 netframe kernel: Bus #130 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:11 netframe rc.sysinit: Remounting root filesystem in<br>
read-write mode succeeded<br>
Nov 10 22:27:28 netframe kernel: Bus #163 is PCI&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:11 netframe rc.sysinit: Finding module dependencies<br>
succeeded<br>
Nov 10 22:27:28 netframe inet: inetd startup succeeded<br>
Nov 10 22:27:28 netframe kernel: Bus #176 is ISA&nbsp;&nbsp;&nbsp;<br>
Nov 10 22:27:11 netframe fsck: /dev/sda2: clean, 34/14056 files,<br>
11119/56227 blocks<br>
Nov 10 22:27:28 netframe kernel: I/O APIC #2 Version 17 at
0xFEC00000.<br>
Nov 10 22:27:11 netframe rc.sysinit: Checking filesystems
succeeded<br>
Nov 10 22:27:28 netframe kernel: I/O APIC #3 Version 17 at
0xFEC01000.<br>
Nov 10 22:27:11 netframe rc.sysinit: Mounting local filesystems<br>
succeeded<br>
Nov 10 22:27:28 netframe lpd[501]: restarted<br>
Nov 10 22:27:28 netframe kernel: I/O APIC #4 Version 17 at
0xFEC02000.<br>
Nov 10 22:27:28 netframe lpd: lpd startup succeeded<br>
Nov 10 22:27:11 netframe rc.sysinit: Turning on user and group
quotas<br>
for local filesystems succeeded<br>
Nov 10 22:27:28 netframe kernel: Int: type 3, pol 1, trig 1, bus
176,<br>
IRQ 02, APIC ID 2, APIC INT 02<br>
Nov 10 22:27:12 netframe rc.sysinit: Enabling swap space succeeded<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 01, APIC ID 2, APIC INT 01<br>
Nov 10 22:27:29 netframe keytable: Loading keymap:<br>
Nov 10 22:27:12 netframe init: Entering runlevel: 3<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 00, APIC ID 2, APIC INT 00<br>
Nov 10 22:27:29 netframe keytable: Loading<br>
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz<br>
Nov 10 22:27:22 netframe kudzu:&nbsp; succeeded<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 03, APIC ID 2, APIC INT 03<br>
Nov 10 22:27:29 netframe keytable: Loading system font:<br>
Nov 10 22:27:23 netframe sysctl: net.ipv4.ip_forward = 0<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 04, APIC ID 2, APIC INT 04<br>
Nov 10 22:27:29 netframe rc: Starting keytable
succeeded</font></tt></div>
<div><tt><font color="#000000">Nov 10 22:27:23 netframe sysctl:
net.ipv4.conf.all.rp_filter = 1<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 05, APIC ID 2, APIC INT 05<br>
Nov 10 22:27:23 netframe sysctl: error: 'net.ipv4.ip_always_defrag'
is<br>
an unknown key<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 06, APIC ID 2, APIC INT 06<br>
Nov 10 22:27:23 netframe sysctl: error: 'kernel.sysrq' is an
unknown<br>
key<br>
Nov 10 22:27:29 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 07, APIC ID 2, APIC INT 07<br>
Nov 10 22:27:23 netframe network: Setting network parameters
succeeded<br>
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 08, APIC ID 2, APIC INT 08<br>
Nov 10 22:27:23 netframe network: Bringing up interface lo
succeeded<br>
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 09, APIC ID 2, APIC INT 09<br>
Nov 10 22:27:24 netframe network: Bringing up interface eth0
succeeded<br>
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 0c, APIC ID 2, APIC INT 0c<br>
Nov 10 22:27:24 netframe portmap: portmap startup succeeded<br>
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 0d, APIC ID 2, APIC INT 0d<br>
Nov 10 22:27:24 netframe rpc.lockd: lockdsvc: Invalid argument<br>
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 1, bus
176,<br>
IRQ 0f, APIC ID 2, APIC INT 0f<br>
Nov 10 22:27:24 netframe nfslock: rpc.lockd startup failed<br>
Nov 10 22:27:30 netframe kernel: Int: type 0, pol 1, trig 3, bus
0,<br>
IRQ 0c, APIC ID 2, APIC INT 0e<br>
Nov 10 22:27:24 netframe nfslock: rpc.statd startup succeeded<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
2,<br>
IRQ 10, APIC ID 3, APIC INT 03<br>
Nov 10 22:27:24 netframe random: Initializing random number
generator<br>
succeeded<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
2,<br>
IRQ 14, APIC ID 3, APIC INT 04<br>
Nov 10 22:27:25 netframe netfs: Mounting other filesystems
succeeded<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
2,<br>
IRQ 18, APIC ID 3, APIC INT 05<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
2,<br>
IRQ 1c, APIC ID 3, APIC INT 06<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
35,<br>
IRQ 10, APIC ID 3, APIC INT 09<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
35,<br>
IRQ 14, APIC ID 3, APIC INT 0a<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
35,<br>
IRQ 18, APIC ID 3, APIC INT 0b<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
35,<br>
IRQ 1c, APIC ID 3, APIC INT 0c<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
130,<br>
IRQ 10, APIC ID 4, APIC INT 03<br>
Nov 10 22:27:31 netframe sendmail: sendmail startup succeeded<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
130,<br>
IRQ 14, APIC ID 4, APIC INT 04<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
130,<br>
IRQ 18, APIC ID 4, APIC INT 05<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
130,<br>
IRQ 1c, APIC ID 4, APIC INT 06<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
163,<br>
IRQ 10, APIC ID 4, APIC INT 09<br>
Nov 10 22:27:31 netframe kernel: Int: type 0, pol 1, trig 3, bus
163,<br>
IRQ 14, APIC ID 4, APIC INT 0a<br>
Nov 10 22:27:32 netframe kernel: Int: type 0, pol 1, trig 3, bus
163,<br>
IRQ 18, APIC ID 4, APIC INT 0b<br>
Nov 10 22:27:32 netframe kernel: Int: type 0, pol 1, trig 3, bus
163,<br>
IRQ 1c, APIC ID 4, APIC INT 0c<br>
Nov 10 22:27:32 netframe gpm: gpm startup succeeded<br>
Nov 10 22:27:32 netframe kernel: Lint: type 3, pol 1, trig 1, bus
176,<br>
IRQ 00, APIC ID ff, APIC LINT 00<br>
Nov 10 22:27:32 netframe kernel: Lint: type 1, pol 1, trig 1, bus
176,<br>
IRQ 00, APIC ID ff, APIC LINT 01<br>
Nov 10 22:27:32 netframe kernel: Processors: 2<br>
Nov 10 22:27:32 netframe kernel: mapped APIC to ffffe000
(fee00000)<br>
Nov 10 22:27:32 netframe kernel: mapped IOAPIC to ffffd000
(fec00000)<br>
Nov 10 22:27:32 netframe kernel: mapped IOAPIC to ffffc000
(fec01000)<br>
Nov 10 22:27:32 netframe kernel: mapped IOAPIC to ffffb000
(fec02000)<br>
Nov 10 22:27:32 netframe kernel: Kernel command line:<br>
BOOT_IMAGE=linux-2.4-pre2 ro root=805<br>
Nov 10 22:27:32 netframe kernel: Initializing CPU#0</font></tt></div>
<div><tt><font color="#000000">Nov 10 22:27:32 netframe kernel:
Detected 199.449 MHz processor.<br>
Nov 10 22:27:32 netframe kernel: Console: colour VGA+ 80x25<br>
Nov 10 22:27:32 netframe kernel: Calibrating delay loop... 397.31<br>
BogoMIPS<br>
Nov 10 22:27:32 netframe kernel: Memory: 2059244k/2097152k
available<br>
(1883k kernel code, 37520k reserved, 104k data, 216k init,
1179648k<br>
highmem)<br>
Nov 10 22:27:32 netframe kernel: Dentry-cache hash table entries:<br>
262144 (order: 9, 2097152 bytes)<br>
Nov 10 22:27:32 netframe kernel: Buffer-cache hash table entries:<br>
131072 (order: 7, 524288 bytes)<br>
Nov 10 22:27:32 netframe kernel: Page-cache hash table entries:
524288<br>
(order: 9, 2097152 bytes)<br>
Nov 10 22:27:32 netframe kernel: Inode-cache hash table entries:<br>
131072 (order: 8, 1048576 bytes)<br>
Nov 10 22:27:32 netframe kernel: Checking 'hlt' instruction... OK.<br>
Nov 10 22:27:32 netframe kernel: POSIX conformance testing by
UNIFIX<br>
Nov 10 22:27:33 netframe kernel: mtrr: v1.36 (20000221) Richard
Gooch<br>
(rgooch@atnf.csiro.au)<br>
Nov 10 22:27:33 netframe kernel: Intel machine check architecture<br>
supported.<br>
Nov 10 22:27:33 netframe kernel: Intel machine check reporting
enabled<br>
on CPU#0.<br>
Nov 10 22:27:33 netframe kernel: CPU0: Intel Pentium Pro stepping
09<br>
Nov 10 22:27:33 netframe kernel: per-CPU timeslice cutoff: 2920.65<br>
usecs.<br>
Nov 10 22:27:33 netframe kernel: Getting VERSION: 40011<br>
Nov 10 22:27:33 netframe kernel: Getting VERSION: 40011<br>
Nov 10 22:27:33 netframe kernel: Getting ID: 1000000<br>
Nov 10 22:27:33 netframe kernel: Getting ID: e000000<br>
Nov 10 22:27:33 netframe kernel: Getting LVT0: 700<br>
Nov 10 22:27:33 netframe kernel: Getting LVT1: 400<br>
Nov 10 22:27:33 netframe kernel: enabled ExtINT on CPU#0<br>
Nov 10 22:27:33 netframe kernel: ESR value before enabling vector:<br>
00000000<br>
Nov 10 22:27:33 netframe kernel: ESR value after enabling vector:<br>
00000000<br>
Nov 10 22:27:33 netframe kernel: CPU present map: 3<br>
Nov 10 22:27:33 netframe kernel: Booting processor 1/0 eip 2000<br>
Nov 10 22:27:33 netframe kernel: Setting warm reset code and
vector.<br>
Nov 10 22:27:33 netframe kernel: 1.<br>
Nov 10 22:27:33 netframe kernel: 2.<br>
Nov 10 22:27:33 netframe kernel: 3.<br>
Nov 10 22:27:33 netframe kernel: Asserting INIT.<br>
Nov 10 22:27:33 netframe kernel: Waiting for send to finish...<br>
Nov 10 22:27:33 netframe kernel: +Deasserting INIT.<br>
Nov 10 22:27:33 netframe kernel: Waiting for send to finish...<br>
Nov 10 22:27:33 netframe kernel: +#startup loops: 2.<br>
Nov 10 22:27:34 netframe kernel: Sending STARTUP #1.<br>
Nov 10 22:27:34 netframe kernel: After apic_write.<br>
Nov 10 22:27:34 netframe xfs: xfs startup succeeded<br>
Nov 10 22:27:34 netframe kernel: Startup point 1.<br>
Nov 10 22:27:34 netframe xfs: Warning: The directory<br>
&quot;/usr/share/fonts/default/TrueType&quot; does not exist.<br>
Nov 10 22:27:34 netframe kernel: Waiting for send to finish...<br>
Nov 10 22:27:34 netframe
xfs:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Entry
deleted from font path.<br>
Nov 10 22:27:34 netframe kernel: +Initializing CPU#1<br>
Nov 10 22:27:34 netframe kernel: CPU#1 (phys ID: 0) waiting for<br>
CALLOUT<br>
Nov 10 22:27:34 netframe linuxconf: Linuxconf final setup<br>
Nov 10 22:27:34 netframe kernel: Sending STARTUP #2.<br>
Nov 10 22:27:34 netframe kernel: After apic_write.<br>
Nov 10 22:27:34 netframe kernel: Startup point 1.<br>
Nov 10 22:27:34 netframe kernel: Waiting for send to finish...<br>
Nov 10 22:27:34 netframe kernel: +After Startup.<br>
Nov 10 22:27:35 netframe kernel: Before Callout 1.<br>
Nov 10 22:27:35 netframe kernel: After Callout 1.<br>
Nov 10 22:27:35 netframe kernel: CALLIN, before
setup_local_APIC().<br>
Nov 10 22:27:35 netframe kernel: masked ExtINT on CPU#1<br>
Nov 10 22:27:35 netframe kernel: ESR value before enabling vector:<br>
00000000<br>
Nov 10 22:27:35 netframe kernel: ESR value after enabling vector:<br>
00000000<br>
Nov 10 22:27:35 netframe kernel: Calibrating delay loop... 398.13<br>
BogoMIPS<br>
Nov 10 22:27:35 netframe kernel: Stack at about c3229fbc<br>
Nov 10 22:27:35 netframe kernel: Intel machine check reporting
enabled<br>
on CPU#1.<br>
Nov 10 22:27:35 netframe kernel: OK.<br>
Nov 10 22:27:35 netframe kernel: CPU1: Intel Pentium Pro stepping
09<br>
Nov 10 22:27:35 netframe kernel: CPU has booted.<br>
Nov 10 22:27:35 netframe kernel: Before bogomips.<br>
Nov 10 22:27:35 netframe kernel: Total of 2 processors
activated</font></tt></div>
<div><tt><font color="#000000">(795.44 BogoMIPS).<br>
Nov 10 22:27:36 netframe kernel: Before bogocount - setting<br>
activated=1.<br>
Nov 10 22:27:36 netframe kernel: Boot done.<br>
Nov 10 22:27:36 netframe kernel: ENABLING IO-APIC IRQs<br>
Nov 10 22:27:36 netframe kernel: ...changing IO-APIC physical APIC
ID<br>
to 2 ... ok.<br>
Nov 10 22:27:36 netframe kernel: ...changing IO-APIC physical APIC
ID<br>
to 3 ... ok.<br>
Nov 10 22:27:36 netframe kernel: ...changing IO-APIC physical APIC
ID<br>
to 4 ... ok.<br>
Nov 10 22:27:36 netframe kernel: Synchronizing Arb IDs.<br>
Nov 10 22:27:36 netframe kernel: unknown bus type 130.<br>
Nov 10 22:27:36 netframe last message repeated 2 times<br>
Nov 10 22:27:36 netframe kernel: , 4-7, 4-8&lt;3&gt;unknown bus type
130.<br>
Nov 10 22:27:36 netframe kernel: unknown bus type 130.<br>
Nov 10 22:27:37 netframe last message repeated 14 times<br>
Nov 10 22:27:37 netframe kernel: , 4-13, 4-14, 4-15 not connected.<br>
Nov 10 22:27:37 netframe kernel: ..TIMER: vector=49 pin1=0 pin2=-1<br>
Nov 10 22:27:37 netframe kernel: activating NMI Watchdog ... done.<br>
Nov 10 22:27:37 netframe kernel: testing the IO<br>
APIC.......................<br>
Nov 10 22:27:37 netframe kernel:&nbsp;<br>
Nov 10 22:27:37 netframe last message repeated 2 times<br>
Nov 10 22:27:37 netframe kernel:
....................................<br>
done.<br>
Nov 10 22:27:37 netframe kernel: calibrating APIC timer ...<br>
Nov 10 22:27:37 netframe kernel: ..... CPU clock speed is 199.4448<br>
MHz.<br>
Nov 10 22:27:37 netframe kernel: ..... host bus clock speed is
66.4814<br>
MHz.<br>
Nov 10 22:27:37 netframe kernel: cpu: 0, clocks: 664814, slice:
221604<br>
Nov 10 22:27:37 netframe kernel:<br>
CPU0&lt;T0:664800,T1:443184,D:12,S:221604,C:664814&gt;<br>
Nov 10 22:27:37 netframe kernel: cpu: 1, clocks: 664814, slice:
221604<br>
Nov 10 22:27:37 netframe kernel:<br>
CPU1&lt;T0:664800,T1:221584,D:8,S:221604,C:664814&gt;<br>
Nov 10 22:27:37 netframe kernel: checking TSC synchronization
across<br>
CPUs: passed.<br>
Nov 10 22:27:37 netframe kernel: Setting commenced=1, go go go<br>
Nov 10 22:27:37 netframe kernel: PCI: PCI BIOS revision 2.10 entry
at<br>
0xf5c0d, last bus=254<br>
Nov 10 22:27:37 netframe kernel: PCI: Using configuration type 1<br>
Nov 10 22:27:37 netframe kernel: PCI: Probing PCI hardware<br>
Nov 10 22:27:37 netframe rc: Starting linuxconf succeeded<br>
Nov 10 22:27:37 netframe kernel: PCI: i440KX/GX host bridge
00:19.0:<br>
secondary bus 00<br>
Nov 10 22:27:37 netframe kernel: PCI: i440KX/GX host bridge
00:1a.0:<br>
secondary bus 01<br>
Nov 10 22:27:37 netframe kernel: PCI: i440KX/GX host bridge
00:1b.0:<br>
secondary bus 81<br>
Nov 10 22:27:37 netframe kernel: PCI-&gt;APIC IRQ transform:
(B0,I3,P0)<br>
-&gt; 14<br>
Nov 10 22:27:37 netframe kernel: PCI-&gt;APIC IRQ transform:
(B2,I5,P0)<br>
-&gt; 20<br>
Nov 10 22:27:37 netframe kernel: PCI-&gt;APIC IRQ transform:
(B2,I6,P0)<br>
-&gt; 21<br>
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource
region<br>
9 of bridge 01:02.0<br>
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource
region<br>
9 of bridge 01:03.0<br>
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource
region<br>
9 of bridge 81:02.0<br>
Nov 10 22:27:37 netframe kernel: PCI: Cannot allocate resource
region<br>
9 of bridge 81:03.0<br>
Nov 10 22:27:37 netframe kernel: isapnp: Scanning for Pnp cards...<br>
Nov 10 22:27:37 netframe kernel: isapnp: No Plug &amp; Play device
found<br>
Nov 10 22:27:37 netframe kernel: Linux NET4.0 for Linux 2.4<br>
Nov 10 22:27:37 netframe kernel: Based upon Swansea University<br>
Computer Society NET3.039<br>
Nov 10 22:27:37 netframe kernel: Starting kswapd v1.8<br>
Nov 10 22:27:37 netframe kernel: pty: 256 Unix98 ptys configured<br>
Nov 10 22:27:37 netframe kernel: RAMDISK driver initialized: 16
RAM<br>
disks of 4096K size 1024 blocksize<br>
Nov 10 22:27:37 netframe kernel: loop: enabling 8 loop devices<br>
Nov 10 22:27:37 netframe kernel: Floppy drive(s): fd0 is 1.44M<br>
Nov 10 22:27:37 netframe kernel: FDC 0 is a post-1991 82077<br>
Nov 10 22:27:37 netframe kernel: LVM version 0.8final&nbsp; by
Heinz<br>
Mauelshagen&nbsp; (15/02/2000)<br>
Nov 10 22:27:37 netframe kernel: lvm -- Driver successfully<br>
initialized<br>
Nov 10 22:27:37 netframe kernel: Loading I2O Core - (c) Copyright
1999<br>
Red Hat Software<br>
Nov 10 22:27:37 netframe kernel: Linux I2O PCI support (c) 1999
Red<br>
Hat Software.<br>
Nov 10 22:27:37 netframe kernel: i2o: Checking for PCI I2O<br>
controllers...</font></tt></div>
<div><tt><font color="#000000">Nov 10 22:27:37 netframe kernel: I2O
configuration manager v 0.04.<br>
Nov 10 22:27:37 netframe kernel:&nbsp;&nbsp; (C) Copyright 1999 Red
Hat Software<br>
Nov 10 22:27:37 netframe kernel: I2O Block Storage OSM v0.9<br>
Nov 10 22:27:37 netframe kernel:&nbsp;&nbsp;&nbsp; (c) Copyright 1999,
2000 Red Hat<br>
Software.<br>
Nov 10 22:27:37 netframe kernel: I2O LAN OSM (C) 1999 University
of<br>
Helsinki.<br>
Nov 10 22:27:37 netframe kernel: udf: registering filesystem<br>
Nov 10 22:27:37 netframe kernel: Serial driver version 5.02<br>
(2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled<br>
Nov 10 22:27:37 netframe kernel: ttyS00 at 0x03f8 (irq = 4) is a<br>
16550A<br>
Nov 10 22:27:38 netframe kernel: ttyS01 at 0x02f8 (irq = 3) is a<br>
16550A<br>
Nov 10 22:27:38 netframe kernel: Linux Tulip driver version 0.9.11<br>
(November 3, 2000)<br>
Nov 10 22:27:38 netframe kernel: eth0: Lite-On 82c168 PNIC rev 32
at<br>
0xb800, 00:A0:CC:55:60:9D, IRQ 21.<br>
Nov 10 22:27:38 netframe kernel: eth0:&nbsp; MII transceiver #1 config
3000<br>
status 7829 advertising 01e1.<br>
Nov 10 22:27:38 netframe kernel: [drm] Initialized tdfx 1.0.0
20000928<br>
on minor 63<br>
Nov 10 22:27:38 netframe kernel: SCSI subsystem driver Revision:
1.00<br>
Nov 10 22:27:38 netframe kernel: (scsi0) &lt;Adaptec AIC-7870 SCSI
host<br>
adapter&gt; found at PCI 0/3/0<br>
Nov 10 22:27:38 netframe kernel: (scsi0) Wide Channel, SCSI ID=7,<br>
16/255 SCBs<br>
Nov 10 22:27:38 netframe kernel: (scsi0) Downloading sequencer
code...<br>
415 instructions downloaded<br>
Nov 10 22:27:38 netframe kernel: scsi0 : Adaptec AHA274x/284x/294x<br>
(EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;Adaptec AIC-7870 SCSI host<br>
adapter&gt;<br>
Nov 10 22:27:38 netframe kernel: (scsi0:0:0:0) Synchronous at 10.0<br>
Mbyte/sec, offset 15.<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp; Vendor: SEAGATE&nbsp;&nbsp;
Model: ST15150N<br>
Rev: 0023<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp; Type:&nbsp;&nbsp;
Direct-Access<br>
ANSI SCSI revision: 02<br>
Nov 10 22:27:38 netframe kernel: (scsi0:0:5:0) Synchronous at 5.7<br>
Mbyte/sec, offset 15.<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp; Vendor: PLEXTOR&nbsp;&nbsp;
Model: CD-ROM<br>
PX-4XCE&nbsp;&nbsp;&nbsp; Rev: 1.04<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp; Type:&nbsp;&nbsp;
CD-ROM<br>
ANSI SCSI revision: 02<br>
Nov 10 22:27:38 netframe kernel: qlogicisp : new isp1020 revision
ID<br>
(5)<br>
Nov 10 22:27:38 netframe kernel: qlogicisp : can't decode I/O
address<br>
space 0xbc00<br>
Nov 10 22:27:38 netframe kernel: Detected scsi disk sda at scsi0,<br>
channel 0, id 0, lun 0<br>
Nov 10 22:27:38 netframe kernel: SCSI device sda: 8388315 512-byte<br>
hdwr sectors (4295 MB)<br>
Nov 10 22:27:38 netframe kernel: Partition check:<br>
Nov 10 22:27:38 netframe kernel:&nbsp; sda: sda1 sda2 sda3 &lt; sda5
sda6 &gt;<br>
Nov 10 22:27:38 netframe kernel: Detected scsi CD-ROM sr0 at
scsi0,<br>
channel 0, id 5, lun 0<br>
Nov 10 22:27:38 netframe kernel: Uniform CD-ROM driver Revision:
3.11<br>
Nov 10 22:27:38 netframe kernel: i2o_scsi.c: Version 0.0.1<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp; chain_pool: 0 bytes @
c322dba0<br>
Nov 10 22:27:38 netframe kernel:&nbsp;&nbsp; (512 byte buffers X 4
can_queue X 0<br>
i2o controllers)<br>
Nov 10 22:27:38 netframe kernel: md driver 0.90.0 MAX_MD_DEVS=256,<br>
MAX_REAL=12<br>
Nov 10 22:27:38 netframe kernel: raid1 personality registered<br>
Nov 10 22:27:38 netframe kernel: md.c: sizeof(mdp_super_t) = 4096<br>
Nov 10 22:27:38 netframe kernel: autodetecting RAID arrays<br>
Nov 10 22:27:38 netframe kernel: autorun ...<br>
Nov 10 22:27:38 netframe kernel: ... autorun DONE.<br>
Nov 10 22:27:38 netframe kernel: NET4: Linux TCP/IP 1.0 for NET4.0<br>
Nov 10 22:27:38 netframe kernel: IP Protocols: ICMP, UDP, TCP<br>
Nov 10 22:27:38 netframe kernel: IP: routing cache hash table of
16384<br>
buckets, 128Kbytes<br>
Nov 10 22:27:38 netframe kernel: TCP: Hash tables configured<br>
(established 131072 bind 65536)<br>
Nov 10 22:27:38 netframe kernel: NET4: Unix domain sockets 1.0/SMP
for<br>
Linux NET4.0.<br>
Nov 10 22:27:38 netframe kernel: kmem_create: Forcing size word<br>
alignment - nfs_fh<br>
Nov 10 22:27:38 netframe kernel: VFS: Mounted root (ext2
filesystem)<br>
readonly.<br>
Nov 10 22:27:38 netframe kernel: Freeing unused kernel memory:
216k<br>
freed<br>
Nov 10 22:27:38 netframe kernel: Adding Swap: 530104k
swap-space</font></tt></div>
<div><tt><font color="#000000">(priority -1)</font></tt></div>

<div>-- <br>
------------------------------------------------------------------<br>
<br>
Rockhopper Communications,
Inc.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
bselack@rockhopper.com<br>
280 Pleasant Hill
Road&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
http://www.rockhopper.com/<br>
Lewisberry, PA
17339&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 717
938-1581<br>
</div>
</body>
</html>
--============_-1238087135==_ma============--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
