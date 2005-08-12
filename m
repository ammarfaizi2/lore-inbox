Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVHLOPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVHLOPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVHLOPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:15:48 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:50300 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751189AbVHLOPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:15:48 -0400
Message-ID: <42FCAF02.3050805@masoud.ir>
Date: Fri, 12 Aug 2005 10:15:30 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: System shutdown with during reboot with 2.6.13-pre6
References: <42FB89D1.1060007@masoud.ir> <42FBA220.8020508@gmail.com> <42FBB37E.6070607@masoud.ir> <42FC0269.4020307@gmail.com>
In-Reply-To: <42FC0269.4020307@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Jiri Slaby wrote:

> Masoud Sharbiani napsal(a):
>
>> Is this a known issue with 2.6.latest ACPI or is it that my mainboard 
>> is broken?
>
>
> No, I don't know about anybody, who has the same problem (it doesn't 
> mean, that it couldn't be).
> Did it work before? Could you accurate version of kernel, where it 
> stops working?
>
It does work with 2.6.12; With 2.6.13-rc2, it crashes on boot (see the 
end of this mail for the serial capture); 2.6.13-rc4 shuts down on 
(cold) reboot.
BTW, I am subscribed to the list.
cheers,
Masoud
PS: The dmesg of 2.6.12-rc2 crash:
Linux version 2.6.13-rc2 (root@dual) (gcc version 3.3.5 (Debian 
1:3.3.5-8ubuntu2)) #1 SMP Fri Aug 12 09:47:11 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000f5fd0
DMI 2.2 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro console=ttyS0,9600n8 console=tty0 
CONSOLE=/dev/ttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 868.687 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773836k/786368k available (3007k kernel code, 12020k reserved, 
1233k data, 244k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1739.94 BogoMIPS 
(lpj=8699726)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1737.35 BogoMIPS 
(lpj=8686784)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3477.30 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: d0000000-d3ffffff
  PREFETCH window: d4000000-d5ffffff
audit: initializing netlink socket (disabled)
audit(1123855554.380:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 
sec (nowayout= 0)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin 
is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Unable to handle kernel paging request<6>serio: i8042 AUX port at 
0x60,0x64 irq
12
serio: i8042 KBD port at 0x60,0x64 irq 1
 at virtual address ffffffff
 printing eip:
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA parallel port disabled in BIOS
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
ffffffff
*pde = 00003067
io scheduler cfq registered
*pte = 00000000
Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    1
EIP:    0060:[<ffffffff>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13-rc2)
EIP is at 0xffffffff
eax: 00000000   ebx: ffffe000   ecx: c160c2df   edx: c0100d30
esi: effa0000   edi: c055f380   ebp: c0561300   esp: effa1fa8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=effa0000 task=effd2520)
Stack: c0100e10 00000002 00000000 00000000 00000000 00000000 00000000 
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
       00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<c0100e10>] cpu_idle+0x70/0x80
Code:  Bad EIP value.
 <0>Kernel panic - not syncing: Attempted to kill the idle task!


                                             


