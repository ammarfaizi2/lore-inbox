Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTI3AQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTI3AQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:16:38 -0400
Received: from locke.ispvip.biz ([209.118.182.151]:3990 "HELO mail0.ispvip.biz")
	by vger.kernel.org with SMTP id S263082AbTI3AQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:16:26 -0400
Message-ID: <3F78931E.2070501@kernel.org>
Date: Mon, 29 Sep 2003 16:16:30 -0400
From: "Michael J. Cohen" <mjc@kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030929 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6-mm1 ALSA OSS emulation panic
Content-Type: multipart/mixed;
 boundary="------------020807080003080400020405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807080003080400020405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

numerous things seem to cause it, not sure exactly why.

ksymoops and dmesg log attached.

--------------020807080003080400020405
Content-Type: text/plain;
 name="alsalog1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsalog1"

Linux version 2.6.0-test6-mm1 (root@localhost) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #3 Mon Sep 29 06:52:42 Local time zone must be set--see zic manu
Video mode to be used for restore is 318
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffcc000 (usable)
 BIOS-e820: 000000001ffcc000 - 000000001ffd0000 (reserved)
 BIOS-e820: 000000001ffd0000 - 000000001ffe0000 (ACPI data)
 BIOS-e820: 000000001ffe0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131020
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126924 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f0180
ACPI: RSDT (v001 TOSHIB 5200     0x20030327 TASM 0x04010000) @ 0x1ffd0000
ACPI: FADT (v002 TOSHIB 5200     0x20021230 TASM 0x04010000) @ 0x1ffd0058
ACPI: DBGP (v001 TOSHIB 5200     0x20030327 TASM 0x04010000) @ 0x1ffd00dc
ACPI: BOOT (v001 TOSHIB 5200     0x20030327 TASM 0x04010000) @ 0x1ffd0030
ACPI: DSDT (v001 TOSHIB 5200     0x20030327 MSFT 0x0100000a) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 vga=0x318
No local APIC present or hardware disabled
current: c0411a60
current->thread_info: c04a2000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2394.392 MHz processor.
Console: colour dummy device 80x25
Memory: 513912k/524080k available (2693k kernel code, 9376k reserved, 1019k data, 176k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 4734.97 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcf0c, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030916
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xd0000000, mapped to 0xe0808000, size 16384k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e140
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (58 C)
Toshiba Laptop ACPI Extras version 0.16
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK6022GAX, ATA DISK drive
hdb: MATSHITADVD-RAM UJ-810, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 128x48
PCI: Enabling device 0000:02:0a.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:02:0a.0 [12a3:ab01]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
spurious 8259A interrupt: IRQ7.
Yenta: ISA IRQ list 0000, PCI irq11
Socket status: 30000010
PCI: Enabling device 0000:02:0b.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:02:0b.0 [1179:0001]
Yenta: ISA IRQ list 0008, PCI irq10
Socket status: 30000007
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49420 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0x1000, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
cpufreq: No CPUs supporting ACPI performance management found.
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0008:000a
eth1: Looks like a Lucent/Agere firmware version 8.10
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:81:A3:E8
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
eth1: New link status: Connected (0001)
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
Unable to handle kernel paging request at virtual address e1962000
 printing eip:
c0305009
*pde = 1fde9067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0305009>]    Not tainted VLI
EFLAGS: 00010206
EIP is at snd_pcm_format_set_silence+0x9c/0x1d6
eax: 00000000   ebx: 00000002   ecx: 000013ee   edx: 00005fb8
esi: 00002fdc   edi: e1962000   ebp: de8e39e0   esp: da8b3f14
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 4699, threadinfo=da8b2000 task=db63d310)
Stack: 00000002 0809723f 00002fdc dc3cb400 c178ec80 c02f21df 00000002 e1961000 
       00002fdc d61e6b00 de8e39e0 c1792600 d61e6b00 c02f3641 de8e39e0 d61e6b00 
       d61e6b00 00000000 dffc06c0 c1671c80 c015bba2 c1671c80 d61e6b00 c167c680 
Call Trace:
 [<c02f21df>] snd_pcm_oss_sync+0x69/0x15f
 [<c02f3641>] snd_pcm_oss_release+0x22/0xc3
 [<c015bba2>] __fput+0x10c/0x11e
 [<c015a273>] filp_close+0x59/0x86
 [<c016bcc4>] sys_dup2+0xe6/0x124
 [<c03a0b8f>] syscall_call+0x7/0xb

Code: 24 e8 8d fe ff ff 89 f1 8b 7c 24 1c eb ea 89 1c 24 e8 7d fe ff ff 66 85 c0 89 c2 75 1f 8d 14 36 31 c0 8b 7c 24 1c 89 d1 c1 e9 02 <f3> ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa eb be 89 f0 83 ee 
 

--------------020807080003080400020405
Content-Type: text/plain;
 name="alsalog2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsalog2"

ksymoops 2.4.9 on i686 2.6.0-test6-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test6-mm1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
Unable to handle kernel paging request at virtual address e1962000
c0305009
*pde = 1fde9067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0305009>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000002   ecx: 000013ee   edx: 00005fb8
esi: 00002fdc   edi: e1962000   ebp: de8e39e0   esp: da8b3f14
ds: 007b   es: 007b   ss: 0068
Stack: 00000002 0809723f 00002fdc dc3cb400 c178ec80 c02f21df 00000002 e1961000 
       00002fdc d61e6b00 de8e39e0 c1792600 d61e6b00 c02f3641 de8e39e0 d61e6b00 
       d61e6b00 00000000 dffc06c0 c1671c80 c015bba2 c1671c80 d61e6b00 c167c680 
Call Trace:
 [<c02f21df>] snd_pcm_oss_sync+0x69/0x15f
 [<c02f3641>] snd_pcm_oss_release+0x22/0xc3
 [<c015bba2>] __fput+0x10c/0x11e
 [<c015a273>] filp_close+0x59/0x86
 [<c016bcc4>] sys_dup2+0xe6/0x124
 [<c03a0b8f>] syscall_call+0x7/0xb
Code: 24 e8 8d fe ff ff 89 f1 8b 7c 24 1c eb ea 89 1c 24 e8 7d fe ff ff 66 85 c0 89 c2 75 1f 8d 14 36 31 c0 8b 7c 24 1c 89 d1 c1 e9 02 <f3> ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa eb be 89 f0 83 ee 


>>EIP; c0305009 <snd_pcm_format_set_silence+9c/1d6>   <=====

>>edx; 00005fb8 <__crc_ide_cmd_ioctl+47d2/34adda>
>>esi; 00002fdc <__crc_ide_cmd_ioctl+17f6/34adda>
>>edi; e1962000 <__crc_snd_component_add+2d018e/7434f6>
>>ebp; de8e39e0 <__crc_mpage_readpages+afd2e/102408>
>>esp; da8b3f14 <__crc_sock_setsockopt+10cd10/156291>

Trace; c02f21df <snd_pcm_oss_sync+69/15f>
Trace; c02f3641 <snd_pcm_oss_release+22/c3>
Trace; c015bba2 <__fput+10c/11e>
Trace; c015a273 <filp_close+59/86>
Trace; c016bcc4 <sys_dup2+e6/124>
Trace; c03a0b8f <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0304fde <snd_pcm_format_set_silence+71/1d6>
00000000 <_EIP>:
Code;  c0304fde <snd_pcm_format_set_silence+71/1d6>
   0:   24 e8                     and    $0xe8,%al
Code;  c0304fe0 <snd_pcm_format_set_silence+73/1d6>
   2:   8d                        lea    (bad),%edi
Code;  c0304fe1 <snd_pcm_format_set_silence+74/1d6>
   3:   fe                        (bad)  
Code;  c0304fe2 <snd_pcm_format_set_silence+75/1d6>
   4:   ff                        (bad)  
Code;  c0304fe3 <snd_pcm_format_set_silence+76/1d6>
   5:   ff 89 f1 8b 7c 24         decl   0x247c8bf1(%ecx)
Code;  c0304fe9 <snd_pcm_format_set_silence+7c/1d6>
   b:   1c eb                     sbb    $0xeb,%al
Code;  c0304feb <snd_pcm_format_set_silence+7e/1d6>
   d:   ea 89 1c 24 e8 7d fe      ljmp   $0xfe7d,$0xe8241c89
Code;  c0304ff2 <snd_pcm_format_set_silence+85/1d6>
  14:   ff                        (bad)  
Code;  c0304ff3 <snd_pcm_format_set_silence+86/1d6>
  15:   ff 66 85                  jmp    *0xffffff85(%esi)
Code;  c0304ff6 <snd_pcm_format_set_silence+89/1d6>
  18:   c0 89 c2 75 1f 8d 14      rorb   $0x14,0x8d1f75c2(%ecx)
Code;  c0304ffd <snd_pcm_format_set_silence+90/1d6>
  1f:   36                        ss
Code;  c0304ffe <snd_pcm_format_set_silence+91/1d6>
  20:   31 c0                     xor    %eax,%eax
Code;  c0305000 <snd_pcm_format_set_silence+93/1d6>
  22:   8b 7c 24 1c               mov    0x1c(%esp,1),%edi
Code;  c0305004 <snd_pcm_format_set_silence+97/1d6>
  26:   89 d1                     mov    %edx,%ecx
Code;  c0305006 <snd_pcm_format_set_silence+99/1d6>
  28:   c1 e9 02                  shr    $0x2,%ecx

This decode from eip onwards should be reliable

Code;  c0305009 <snd_pcm_format_set_silence+9c/1d6>
00000000 <_EIP>:
Code;  c0305009 <snd_pcm_format_set_silence+9c/1d6>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c030500b <snd_pcm_format_set_silence+9e/1d6>
   2:   f6 c2 02                  test   $0x2,%dl
Code;  c030500e <snd_pcm_format_set_silence+a1/1d6>
   5:   74 02                     je     9 <_EIP+0x9>
Code;  c0305010 <snd_pcm_format_set_silence+a3/1d6>
   7:   66 ab                     stos   %ax,%es:(%edi)
Code;  c0305012 <snd_pcm_format_set_silence+a5/1d6>
   9:   f6 c2 01                  test   $0x1,%dl
Code;  c0305015 <snd_pcm_format_set_silence+a8/1d6>
   c:   74 01                     je     f <_EIP+0xf>
Code;  c0305017 <snd_pcm_format_set_silence+aa/1d6>
   e:   aa                        stos   %al,%es:(%edi)
Code;  c0305018 <snd_pcm_format_set_silence+ab/1d6>
   f:   eb be                     jmp    ffffffcf <_EIP+0xffffffcf>
Code;  c030501a <snd_pcm_format_set_silence+ad/1d6>
  11:   89 f0                     mov    %esi,%eax
Code;  c030501c <snd_pcm_format_set_silence+af/1d6>
  13:   83                        .byte 0x83
Code;  c030501d <snd_pcm_format_set_silence+b0/1d6>
  14:   ee                        out    %al,(%dx)


1 warning and 1 error issued.  Results may not be reliable.

--------------020807080003080400020405--

