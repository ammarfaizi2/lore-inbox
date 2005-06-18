Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVFRSrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVFRSrN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVFRSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:47:12 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:58117 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262175AbVFRSqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:46:49 -0400
Message-ID: <42B46C18.2030101@superbug.demon.co.uk>
Date: Sat, 18 Jun 2005 19:46:48 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc6-mm1 oops on startup.
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090500070203000705080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500070203000705080109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have used the kernel.org normal kernel, and it compiles and boots fine.
I then use exactly the same .config file for the 2.6.12-rc6-mm1 and it
fails to boot.

I attach the oops.txt that I captures via the serial port.

Can anybody help, because I wish to test the PCMCIA code.

Thank you

James

--------------090500070203000705080109
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Linux version 2.6.12-rc6-mm1 (root@new) (gcc version 3.4.4 (Gentoo 3.4.4, ssp-3.                                                                                
4.4-1.0, pie-8.7.8)) #1 SMP Sat Jun 18 17:07:03 BST 2005                                                        
BIOS-provided physical RAM map:                               
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)                                                        
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)                                                          
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)                                                          
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)                                                        
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)                                                          
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI d                                                      
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)                                                          
127MB HIGHMEM available.                        
896MB LOWMEM available.                       
found SMP MP-table at 000f5d50                              
DMI 2.2 present.                
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)                                                  
Processor #0 15:2 APIC version 20                                 
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)                                                  
Processor #1 15:2 APIC version 20                                 
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])                                                   
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])                                                   
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])                                                       
IOAPIC[0]: apic_id 2, version 32                               
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)                                                        
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)                                                           
Enabling APIC mode:  Flat.  Using 1 I/O APICs                                             
Using ACPI (MADT) for SMP configuration information                                                   
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)                                                                      
Built 1 zonelists                 
Initializing CPU#0                  
Kernel command line: root=/dev/hdd5 console=tty0 console=ttyS0,9600 nmi_watchdog                                                                                
=1  
PID hash table entries: 4096 (order: 12, 65536 bytes)                                                     
Detected 2806.614 MHz processor.                                
Using tsc for high-res t                      
Console: colour VGA+ 80x25                          
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)                                                                
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)                                                              
Memory: 1033612k/1048512k available (2522k kernel code, 14064k reserved, 948k da                                                                                
ta, 208k init, 131008k highmem)                               
Checking if this processor honours the WP bit even in supervisor mode... Ok.                                                                            
Calibrating delay using timer specific routine.. 5620.79 BogoMIPS (lpj=11241599)                                                                                

Security Framework v1.0.0 initialized                                     
Capability LSM initialized                          
Mount-cache hash table en                        
CPU: Trace cache: 12K uops, L1 D cache: 8K                                          
CPU: L2 cache: 512K                   
CPU: Physical Processor ID: 0                             
Intel machine check architecture supported.                                           
Intel machine check reporting enabled on CPU#0.                                               
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available                                                    
CPU0: Thermal monitoring enabled                                
Enabling fast FPU save and restore... done.                                           
Enabling unmasked SIMD FPU exception support... done.                                                     
Checking 'hlt' instruction... OK.                                 
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09                                                   
Booting processor 1/1 eip 2000                              
Initializing CPU#1                  
Calibrating delay using timer specific routine.. 5613.20 BogoMIPS (lpj=11226408)                                                                                

CPU: Trace cache: 12K uops, L1 D cache: 8K                                          
CPU: L2 cache: 512K                   
CPU: Physical Processor ID: 0                             
Intel machine check architecture supported.                                           
Intel machine check reporting enabled on CPU#1.                                               
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available                                                    
CPU1: Thermal monitoring enabled                                
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09                                                   
Total of 2 processors activated (11234.00 BogoMIPS).                                                    
ENABLING IO-APIC IRQs                     
..TIMER: vector=0x31 pin1=2 pin2=-1                                   
checking TSC synchronization across 2 CPUs: passed.                                                   
softlockup thread 0 started up.                               
Brought up 2 CPUs                 
softlockup thread 1 started up.                               
NET: Registered protocol family 16                                  
PCI: PCI BIOS revision 2.10 entry at 0xfba10, last bus=3                                                        
PCI: Using configuration type 1                               
mtrr: v2.0 (20020519)                     
ACPI: Subsystem revision 20050309                                 
ACPI: Interpreter enabled                         
ACPI: Using IOAPIC for interrupt routing                                        
ACPI: PCI Root Bridge [PCI0] (0000:00)                                      
PCI: Probing PCI hardware (bus 00)                                  
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2                                                   
Unable to handle kernel paging request at virtual address f7f29b8c                                                                  
 printing eip:              
c011f704        
*pde = 00538067               
Oops: 0000 [#1]               
PREEMPT SMP DEBUG_PAGEALLOC                           
Modules linked in:                  
CPU:    0         
EIP:    0060:[<c011f704>]    Not tainted VLI                                    
EFLAGS: 00010286   (2.6.12-rc6-mm1)
EIP is at do_fork+0xd4/0x20e
eax: c1a76000   ebx: f7f29af0   ecx: c1a77e30   edx: c19a6af0
esi: 00004000   edi: 00000051   ebp: c1a77eb4   esp: c1a77e58
ds: 007b   es: 007b   ss: 0068
Process khelper (pid: 10, threadinfo=c1a76000 task=c19a6af0)
Stack: 00804111 00000000 c1a77ed4 00000000 00000000 00000000 00000051 00000000
       00000001 dead4ead 00000000 00000069 00000000 00000001 dead4ead 00000000
       c1a77e98 c1a77e98 c1811e80 c1811520 c19bbe4c c19a5df8 00000000 c1a77f18
Call Trace:
 [<c01040df>] show_stack+0x7f/0xa0
 [<c0104284>] show_registers+0x164/0x1e0
 [<c01044cd>] die+0x10d/0x1a0
 [<c011731c>] do_page_fault+0x4bc/0x6b8
 [<c0103d0f>] error_code+0x4f/0x54
 [<c01012a9>] kernel_thread+0x79/0x80
 [<c0131de9>] __call_usermodehelper+0x59/0x70
 [<c01322b5>] worker_thread+0x1d5/0x260
 [<c0136e4d>] kthread+0xad/0xf0
 [<c0101225>] kernel_thread_helper+0x5/0x10
Code: 84 b5 00 00 00 c7 03 04 00 00 00 8b 45 c0 85 c0 0f 85 0f 01 00 00 81 e6 00
 40 00 00 0f 85 a6 00 00 00 b8 00 e0 ff ff 21 e0 8b 10 <8b> 83 9c 00 00 00 89 44
 24 0c 8b 83 a0 00 00 00 89 44 24 08 8b

--------------090500070203000705080109--
