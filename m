Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVJEG5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVJEG5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 02:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJEG5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 02:57:23 -0400
Received: from web30714.mail.mud.yahoo.com ([68.142.201.252]:53093 "HELO
	web30714.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932558AbVJEG5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 02:57:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qcjQO3fX6s8q4/cU52TXctx0LJkm5rap7H4cqDgjqOLL40UPV2WS4GYJxXUO02lxfxlF7Zl2dCDqqjzXlMrhowg3CTjqcs/ZdDQ2tD8RiihYBKmQNwYTvFrgRqk7kE029O1O6wDBud/cMZR57kJGuSMsJBykhhfmPUqr4botfv4=  ;
Message-ID: <20051005065720.97938.qmail@web30714.mail.mud.yahoo.com>
Date: Tue, 4 Oct 2005 23:57:20 -0700 (PDT)
From: umesh chandak <chandak_umesh@yahoo.com>
Subject: problem regarding KGDB on FC3
To: kgdb-bugreport@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
         I have applied a KGDB patch on FC3 for kernel

2.6.10 .
         My connection is successful with command 
target remote /dev/ttyS0

After pressing C for continuing i got some messages on
console ,after that my target m/c did not start 
error messages are like this .
--------------------------------------------

(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
breakpoint () at kernel/kgdb.c:1446
1446            atomic_set(&kgdb_setting_breakpoint,
0);
(gdb) c
Continuing.
Linux version 2.6.10 (root@localhost.localdomain) (gcc
version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #7 Wed
Oct 5 11:37:32 IST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000
(usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI
NVS)
 BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI
data)
 BIOS-e820: 000000000f800000 - 0000000010000000
(reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000
(reserved)
Waiting for connection from remote gdb...
0MB HIGHMEM available.
247MB LOWMEM available.
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: ro root=/dev/hda6 rootfstype=ext3
kgdbwait kgdb8250=1,57600
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2412.550 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5,
131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
Memory: 247512k/253888k available (2441k kernel code,
5816k reserved, 623k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a20)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf9d80, last
bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10
11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10
11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10
11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10
*11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10
11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10
*11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically. 
If this
** causes a device to stop working, it is probably
because the
** driver failed to call pci_enable_device().  As a
temporary
** workaround, the "pci=routeirq" argument restores
the old
** behavior.  If this argument makes the device work
again,
** please email the output of "lspci" to
bjorn.helgaas@hp.com
** so I can fix the driver.
apm: BIOS version 1.2 Flags 0x07 (Driver version
1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1128469838.545:0): initialized
Registering GDB sysrq handler
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Processor [CPU0] (supports 2 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: Maximum main memory to use for agp memory:
196M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports,
IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Couldn't register serial port UAR1: -16
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
  


	
		
______________________________________________________ 
Yahoo! for Good 
Donate to the Hurricane Katrina relief effort. 
http://store.yahoo.com/redcross-donate3/ 

