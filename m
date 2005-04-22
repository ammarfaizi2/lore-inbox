Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVDVKqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVDVKqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVDVKqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:46:44 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:19182 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261794AbVDVKqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:46:32 -0400
In-Reply-To: <OF5975C9DE.231115EA-ON65256FEA.004A436D-65256FEA.004D0D1E@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Cc: akpm@osdl.org, vgoyal@in.ibm.com
MIME-Version: 1.0
Subject: Re: Kdump Testing
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF3AAC7ED2.37502955-ON65256FEB.0039D16D-65256FEB.003BB61C@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Fri, 22 Apr 2005 16:16:47 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 22/04/2005 16:16:14,
	Serialize complete at 22/04/2005 16:16:14
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the console boot log, before the machine jumps to BIOS 
after hang during panic kerenl boot


----------------------------------------------------
x235
x235b!login: SysRq : Trigger a crashdump
Linux version 2.6.12-rc2-mm1 (root@x235b) (gcc version 3.3.3 (SuSE Linux)) 
#2 SMP PREEMPT Tue Apr 19 08:55:24 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ffd8740 (usable)
 BIOS-e820: 000000005ffd8740 - 000000005ffe0000 (ACPI data)
 BIOS-e820: 000000005ffe0000 - 0000000060000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 0000000001518000 (usable)
 user: 00000000015b8400 - 0000000004000000 (usable)
0MB HIGHMEM available.
64MB LOWMEM available.
found SMP MP-table at 0009c140
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x0c] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 12, version 17, address 0xfec02000, GSI 32-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 04000000 (gap: 04000000:fc000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda1 init 1
vga=0x31a selinux=0 splash=silent resume=/dev/sda2 elevator=cfq showopts 
console=tty0 console=ttyS0,38400n1 memmap=exactmap memmap=640K@0K 
memmap=5216K@16384K memmap=43295K@22241K elfcorehdr=22240K
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 2795.976 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 42992k/65536k available (3523k kernel code, 6060k reserved, 1121k 
data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Booting processor 1/0 eip 3000
----------------------------------------------------
x206
SysRq : Trigger a crashdump
Linux version 2.6.12-rc2-mm1-II (root@x206h) (gcc version 3.3.3 (SuSE 
Linux)) #2 SMP PREEMPT Wed Apr 20 18:58:46 IST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009b400 (usable)
 BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d6000 - 00000000000d8000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff76000 (ACPI data)
 BIOS-e820: 000000007ff76000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 00000000014e4000 (usable)
 user: 0000000001584400 - 0000000004000000 (usable)
0MB HIGHMEM available.
64MB LOWMEM available.
found SMP MP-table at 000f6140
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 04000000 (gap: 04000000:fc000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda5 init 1 vga=0x31a selinux=0 
splash=silent acpi=oldboot resume=/dev/sda6 elevator=cfq showopts 
console=tty0 console=ttyS0,38400n1 memmap=exactmap memmap=640K@0K 
memmap=5008K@16384K memmap=43503K@22033K elfcorehdr=22032K
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 2801.477 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 43208k/65536k available (3269k kernel code, 5848k reserved, 1147k 
data, 244k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Booting processor 1/0 eip 3000


linux-kernel-owner@vger.kernel.org wrote on 21/04/2005 19:26:11:

> Hi,
> I tested the kdump tool on x235 and x206 machines and found this problem 

> where on kernel Panic, system instead of booting into the panic kernel 
> jumps into BIOS and machine restarts.
> (I have given the hardware specifications at the bottom of the mail)
> 
> Software:
> - 2.6.12-rc2-mm1
> - kexec-tools-1.101 
> - Five kdump user space patches 
>   [http://marc.theaimsgroup.com/?l=linux-kernel&m=111201661400892&w=2]
> 
> Test Procedure:
> - Built first kernel for 1M location with CONFIG_KEXEC enabled.
> - Booted into first kernel with command line options 
crashkernel=48M@16M.
> - Built second kernel for 16M location with CONFIG_CRASH_DUMP, and 
>   CONFIG_PROC_VMCORE enabled.
> - Loaded second kernel with following kexec command.
> 
>   kexec -p vmlinux-16M --args-linux --crash-dump 
--append="root=<root-dev>
>   init 1"
> 
> - Inserted a module or echo into sysrq-trigger to invoke panic.
> - System jumps  into BIOS directly instead of booting into secondary 
> kernel.
> 
> Summary Observation:
> 
> - Earlier I was able to make kdump work on x330 machine by removing 
> maxcpus=1 (as specified in kdump.txt) option during loading panic 
kernel, 
> through kexec tool. But this work around doesn't seems to work with the 
> hardware x235 and x206. On kernel panic machine jumps to BIOS rather 
than 
> to panic kernel without displaying any error message.
> 
> 
> HARDWARE SPECIFICATIONS
> ------------
> 
> A) Hardware  x330: 
> - SMP, 2way, Pentium III (Coppermine) 1 GHz, 1.3G RAM
> - Network Interface (e100)
> - Disk I/O
>   SCSI storage controller: Adaptec Ultra160 
> -----------
> B)Hardware x235
> - SMP, 2way, Xeon TM 2.8GHz, 1.5g RAM
> - Network Interface (Tigon3)
> - Disk I/O
>   SCSI storage controller: IBM Serve RAID
> -------------
> C)Hardware x206
> - SMP, 1way, Pentium IV 2.8GHz, 2g RAM
> - Network Interface (e1000)
> - Disk I/O
>   SCSI storage controller: Adaptec Ultra320
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

