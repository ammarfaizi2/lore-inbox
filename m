Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVDBDbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVDBDbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVDBDby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:31:54 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:31093 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262982AbVDBDan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:30:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IXQh4QQA5r6EAwOnGbmNeRGznmXSwrsF1z4YLxVL5ddWsPqprlHjey711rixhVQDQqO7AGDN7W3Ekhh4N89CNgWpAd9djD+eFk2cR9DGfsS2zXFMyOeSVHAGPHJXAD9eJak5uvS6GUZvyATXlxMSx8quqavz76tLnYzYe7NWS5I=
Message-ID: <9e47339105040119302e6bb405@mail.gmail.com>
Date: Fri, 1 Apr 2005 22:30:42 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: initramfs linus tree breakage in last day
In-Reply-To: <9e473391050401181824d9e50f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <9e473391050401181824d9e50f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I see on boot.

-- 
Jon Smirl
jonsmirl@gmail.com

Linux version 2.6.12-rc1 (jonsmirl@jonsmirl.smirl.net) (gcc version
3.4.2 200410
17 (Red Hat 3.4.2-6.fc3)) #21 SMP Fri Apr 1 22:09:28 EST 2005
BIOS-provided physical RAM map:                               
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)
 BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)
 BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)
 BIOS-e820: 000000003ff97000 - 0000000040000000 (
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.                        
896MB LOWMEM available.                       
found SMP MP-table at 000fe710                              
DMI 2.3 present.                
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20                                 
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01]                                       
Processor #1 15:2 APIC version 20                                 
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000
Built 1 zonelists                 
Kernel command line: ro root=LABEL=/  console=ttyS0,115200n8
Initializing CPU#0                  
CPU 0 irqstacks, hard=c03ad000 soft=c03ab000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2793.105 MHz processor.                                
Using tsc for high-res timesource                                 
Console: colour VGA+ 80x25                          
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034920k/1048016k available (1567k kernel code, 12372k
reserved, 955k da
ta, 184k init, 130                
Checking if this processor honours the WP bit even in supervisor
mode... Ok.
Security Framework v1.0.0 initialized                                     
Mount-cache hash table entries: 512                                   
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
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c03ae000 soft=c03ac000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11091.96 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 318k freed
