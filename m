Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTJNOiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTJNOiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:38:46 -0400
Received: from 200-171-26-122.mondonet.com.br ([200.171.26.122]:39136 "EHLO
	mail.mondonet.com.br") by vger.kernel.org with ESMTP
	id S262577AbTJNOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:38:32 -0400
Message-ID: <3F8BFB27.3080504@michel.eti.br>
Date: Tue, 14 Oct 2003 11:33:27 -0200
From: Michel Angelo da Silva Pereira <michel@michel.eti.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.25 freezes with IBM Netfinity 7100 4x Xeon
Content-Type: multipart/mixed;
 boundary="------------030609090302010801080405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609090302010801080405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

	Hi, I've got a problem to solve and don't known what to do anymore.
	We'have a 4 Xeon IBM Netfinity 7100 with 2GB RAM and one IBM ServeRAID, 
when the load of machine goes down, we're hitted with a freeze (even 
Alt+SysRq works). I'm attaching some information about the machine.
	If you need more information, please ask. Someone from IBM can help me?
-- 
===================================================================
Especialista em Segurança da Informação
Solaris Certified System Administrator - Conectiva Linux Specialist
Mondonet Network Solutions - www.mondonet.com.br - (016) 3911-5323
===================================================================

--------------030609090302010801080405
Content-Type: text/plain;
 name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo"

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.376
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.376
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.376
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.376
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1094.45


--------------030609090302010801080405
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

Oct 14 06:56:41 xeon7100 syslogd 1.3-3: restart.
Oct 14 06:56:41 xeon7100 syslog: syslogd startup succeeded
Oct 14 06:56:41 xeon7100 kernel: klogd 1.3-3, log source = /proc/kmsg started.
Oct 14 06:56:41 xeon7100 kernel: Inspecting /boot/System.map
Oct 14 06:56:41 xeon7100 syslog: klogd startup succeeded
Oct 14 06:56:41 xeon7100 kernel: Loaded 6523 symbols from /boot/System.map.
Oct 14 06:56:41 xeon7100 kernel: Symbols match kernel version 2.2.25.
Oct 14 06:56:41 xeon7100 kernel: Loaded 97 symbols from 3 modules.
Oct 14 06:56:41 xeon7100 kernel: Linux version 2.2.25 (root@xeon7100.altamogiana.net) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Thu Oct 9 22:15:37 BRST 2003 
Oct 14 06:56:41 xeon7100 kernel: BIOS-provided physical RAM map: 
Oct 14 06:56:41 xeon7100 kernel:  BIOS-e820: 0009c000 @ 00000000 (usable) 
Oct 14 06:56:41 xeon7100 kernel:  BIOS-e820: 7fefa480 @ 00100000 (usable) 
Oct 14 06:56:41 xeon7100 kernel: Warning only 1984MB will be used. 
Oct 14 06:56:41 xeon7100 kernel: Intel MultiProcessor Specification v1.4 
Oct 14 06:56:41 xeon7100 kernel:     Virtual Wire compatibility mode. 
Oct 14 06:56:41 xeon7100 kernel: OEM ID: IBM ENSW Product ID: Mohawk  SMP  APIC at: 0xFEE00000 
Oct 14 06:56:41 xeon7100 kernel: Processor #3 Pentium(tm) Pro APIC version 17 
Oct 14 06:56:41 xeon7100 kernel: Processor #0 Pentium(tm) Pro APIC version 17 
Oct 14 06:56:41 xeon7100 kernel: Processor #1 Pentium(tm) Pro APIC version 17 
Oct 14 06:56:41 xeon7100 kernel: Processor #2 Pentium(tm) Pro APIC version 17 
Oct 14 06:56:41 xeon7100 kernel: I/O APIC #14 Version 17 at 0xFEC00000. 
Oct 14 06:56:41 xeon7100 kernel: I/O APIC #13 Version 17 at 0xFEC01000. 
Oct 14 06:56:41 xeon7100 kernel: Processors: 4 
Oct 14 06:56:41 xeon7100 kernel: WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems! 
Oct 14 06:56:41 xeon7100 kernel: mapped APIC to ffffe000 (fee00000) 
Oct 14 06:56:41 xeon7100 kernel: mapped IOAPIC to ffffd000 (fec00000) 
Oct 14 06:56:41 xeon7100 kernel: mapped IOAPIC to ffffc000 (fec01000) 
Oct 14 06:56:41 xeon7100 kernel: Detected 549376 kHz processor. 
Oct 14 06:56:41 xeon7100 kernel: Console: colour VGA+ 80x25 
Oct 14 06:56:41 xeon7100 kernel: Calibrating delay loop... 1094.45 BogoMIPS 
Oct 14 06:56:41 xeon7100 kernel: Memory: 2009744k/2031616k available (1048k kernel code, 432k reserved, 20332k data, 60k init) 
Oct 14 06:56:41 xeon7100 kernel: Dentry hash table entries: 262144 (order 9, 2048k) 
Oct 14 06:56:41 xeon7100 kernel: Buffer cache hash table entries: 524288 (order 9, 2048k) 
Oct 14 06:56:41 xeon7100 kernel: Page cache hash table entries: 524288 (order 9, 2048k) 
Oct 14 06:56:41 xeon7100 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 14 06:56:41 xeon7100 kernel: CPU: L2 cache: 512K 
Oct 14 06:56:41 xeon7100 identd: identd startup succeeded
Oct 14 06:56:41 xeon7100 kernel: CPU serial number disabled. 
Oct 14 06:56:41 xeon7100 kernel: Intel machine check architecture supported. 
Oct 14 06:56:41 xeon7100 kernel: Intel machine check reporting enabled on CPU#3. 
Oct 14 06:56:41 xeon7100 kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting. 
Oct 14 06:56:41 xeon7100 kernel: Checking 'hlt' instruction... OK. 
Oct 14 06:56:41 xeon7100 kernel: POSIX conformance testing by UNIFIX 
Oct 14 06:56:41 xeon7100 kernel: mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au) 
Oct 14 06:56:41 xeon7100 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 14 06:56:41 xeon7100 kernel: CPU: L2 cache: 512K 
Oct 14 06:56:41 xeon7100 kernel: Intel machine check reporting enabled on CPU#3. 
Oct 14 06:56:41 xeon7100 kernel: per-CPU timeslice cutoff: 99.97 usecs. 
Oct 14 06:56:41 xeon7100 kernel: CPU3: Intel Pentium III (Katmai) stepping 03 
Oct 14 06:56:41 xeon7100 kernel: calibrating APIC timer ...  
Oct 14 06:56:41 xeon7100 kernel: ..... CPU clock speed is 549.3505 MHz. 
Oct 14 06:56:41 xeon7100 kernel: ..... system bus clock speed is 99.8817 MHz. 
Oct 14 06:56:41 xeon7100 kernel: Booting processor 0 eip 2000 
Oct 14 06:56:41 xeon7100 kernel: Calibrating delay loop... 1097.72 BogoMIPS 
Oct 14 06:56:41 xeon7100 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 14 06:56:41 xeon7100 kernel: CPU: L2 cache: 512K 
Oct 14 06:56:41 xeon7100 kernel: CPU serial number disabled. 
Oct 14 06:56:41 xeon7100 kernel: Intel machine check reporting enabled on CPU#0. 
Oct 14 06:56:41 xeon7100 kernel: OK. 
Oct 14 06:56:41 xeon7100 kernel: CPU0: Intel Pentium III (Katmai) stepping 03 
Oct 14 06:56:41 xeon7100 kernel: Booting processor 1 eip 2000 
Oct 14 06:56:41 xeon7100 kernel: Calibrating delay loop... 1097.72 BogoMIPS 
Oct 14 06:56:41 xeon7100 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 14 06:56:41 xeon7100 kernel: CPU: L2 cache: 512K 
Oct 14 06:56:41 xeon7100 kernel: CPU serial number disabled. 
Oct 14 06:56:41 xeon7100 kernel: Intel machine check reporting enabled on CPU#1. 
Oct 14 06:56:41 xeon7100 kernel: OK. 
Oct 14 06:56:41 xeon7100 kernel: CPU1: Intel Pentium III (Katmai) stepping 03 
Oct 14 06:56:41 xeon7100 kernel: Booting processor 2 eip 2000 
Oct 14 06:56:41 xeon7100 kernel: Calibrating delay loop... 1097.72 BogoMIPS 
Oct 14 06:56:41 xeon7100 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 14 06:56:41 xeon7100 kernel: CPU: L2 cache: 512K 
Oct 14 06:56:41 xeon7100 kernel: CPU serial number disabled. 
Oct 14 06:56:41 xeon7100 kernel: Intel machine check reporting enabled on CPU#2. 
Oct 14 06:56:41 xeon7100 kernel: OK. 
Oct 14 06:56:41 xeon7100 kernel: CPU2: Intel Pentium III (Katmai) stepping 03 
Oct 14 06:56:41 xeon7100 kernel: Total of 4 processors activated (4387.63 BogoMIPS). 
Oct 14 06:56:41 xeon7100 kernel: enabling symmetric IO mode... ...done. 
Oct 14 06:56:41 xeon7100 kernel: ENABLING IO-APIC IRQs 
Oct 14 06:56:41 xeon7100 kernel: init IO_APIC IRQs 
Oct 14 06:56:41 xeon7100 kernel:  IO-APIC (apicid-pin) 14-0, 14-10, 14-11, 13-3, 13-4, 13-11, 13-12, 13-13, 13-14, 13-15 not connected. 
Oct 14 06:56:41 xeon7100 kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC 
Oct 14 06:56:41 xeon7100 kernel: ...trying to set up timer as ExtINT...  failed. 
Oct 14 06:56:41 xeon7100 kernel: ...trying to set up timer as BP IRQ... works. 
Oct 14 06:56:41 xeon7100 kernel: number of MP IRQ sources: 32. 
Oct 14 06:56:41 xeon7100 kernel: number of IO-APIC #14 registers: 16. 
Oct 14 06:56:41 xeon7100 kernel: number of IO-APIC #13 registers: 16. 
Oct 14 06:56:41 xeon7100 kernel: testing the IO APIC....................... 
Oct 14 06:56:41 xeon7100 kernel:  
Oct 14 06:56:41 xeon7100 kernel: IO APIC #14...... 
Oct 14 06:56:41 xeon7100 kernel: .... register #00: 0E000000 
Oct 14 06:56:41 xeon7100 kernel: .......    : physical APIC id: 0E 
Oct 14 06:56:41 xeon7100 kernel: .... register #01: 000F0011 
Oct 14 06:56:41 xeon7100 kernel: .......     : max redirection entries: 000F 
Oct 14 06:56:41 xeon7100 kernel: .......     : IO APIC version: 0011 
Oct 14 06:56:41 xeon7100 kernel: .... register #02: 01000000 
Oct 14 06:56:41 xeon7100 kernel: .......     : arbitration: 01 
Oct 14 06:56:41 xeon7100 kernel: .... IRQ redirection table: 
Oct 14 06:56:41 xeon7100 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 14 06:56:41 xeon7100 kernel:  00 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  01 0FF 0F  1    0    0   0   0    1    1    59 
Oct 14 06:56:41 xeon7100 kernel:  02 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  03 0FF 0F  1    0    0   0   0    1    1    61 
Oct 14 06:56:41 xeon7100 kernel:  04 0FF 0F  1    0    0   0   0    1    1    69 
Oct 14 06:56:41 xeon7100 atd: atd startup succeeded
Oct 14 06:56:41 xeon7100 kernel:  05 0FF 0F  1    1    0   1   0    1    1    71 
Oct 14 06:56:41 xeon7100 kernel:  06 0FF 0F  1    0    0   0   0    1    1    79 
Oct 14 06:56:41 xeon7100 kernel:  07 0FF 0F  1    0    0   0   0    1    1    81 
Oct 14 06:56:41 xeon7100 kernel:  08 0FF 0F  1    0    0   0   0    1    1    89 
Oct 14 06:56:41 xeon7100 kernel:  09 0FF 0F  1    1    0   1   0    1    1    91 
Oct 14 06:56:41 xeon7100 kernel:  0a 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0b 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0c 0FF 0F  1    0    0   0   0    1    1    99 
Oct 14 06:56:41 xeon7100 kernel:  0d 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0e 0FF 0F  1    0    0   0   0    1    1    A1 
Oct 14 06:56:41 xeon7100 kernel:  0f 0FF 0F  1    1    0   1   0    1    1    A9 
Oct 14 06:56:41 xeon7100 kernel:  
Oct 14 06:56:41 xeon7100 kernel: IO APIC #13...... 
Oct 14 06:56:41 xeon7100 kernel: .... register #00: 0D000000 
Oct 14 06:56:41 xeon7100 kernel: .......    : physical APIC id: 0D 
Oct 14 06:56:41 xeon7100 kernel: .... register #01: 000F0011 
Oct 14 06:56:41 xeon7100 kernel: .......     : max redirection entries: 000F 
Oct 14 06:56:41 xeon7100 kernel: .......     : IO APIC version: 0011 
Oct 14 06:56:41 xeon7100 kernel: .... register #02: 0F000000 
Oct 14 06:56:41 xeon7100 kernel: .......     : arbitration: 0F 
Oct 14 06:56:41 xeon7100 kernel: .... IRQ redirection table: 
Oct 14 06:56:41 xeon7100 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 14 06:56:41 xeon7100 kernel:  00 0FF 0F  1    1    0   1   0    1    1    B1 
Oct 14 06:56:41 xeon7100 kernel:  01 0FF 0F  1    1    0   1   0    1    1    B9 
Oct 14 06:56:41 xeon7100 kernel:  02 0FF 0F  1    1    0   1   0    1    1    C1 
Oct 14 06:56:41 xeon7100 kernel:  03 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  04 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  05 0FF 0F  1    1    0   1   0    1    1    C9 
Oct 14 06:56:41 xeon7100 kernel:  06 0FF 0F  1    1    0   1   0    1    1    D1 
Oct 14 06:56:41 xeon7100 kernel:  07 0FF 0F  1    1    0   1   0    1    1    D9 
Oct 14 06:56:41 xeon7100 kernel:  08 0FF 0F  1    1    0   1   0    1    1    E1 
Oct 14 06:56:41 xeon7100 kernel:  09 0FF 0F  1    1    0   1   0    1    1    E9 
Oct 14 06:56:41 xeon7100 kernel:  0a 0FF 0F  1    1    0   1   0    1    1    F1 
Oct 14 06:56:41 xeon7100 kernel:  0b 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0c 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0d 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0e 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel:  0f 000 00  1    0    0   0   0    0    0    00 
Oct 14 06:56:41 xeon7100 kernel: .................................... done. 
Oct 14 06:56:41 xeon7100 kernel: checking TSC synchronization across CPUs: passed. 
Oct 14 06:56:41 xeon7100 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd5cc 
Oct 14 06:56:41 xeon7100 kernel: PCI: Using configuration type 1 
Oct 14 06:56:41 xeon7100 kernel: PCI: Probing PCI hardware 
Oct 14 06:56:41 xeon7100 kernel: PCI: 00:00 [1166/0008]: Scanning peer host bridges 
Oct 14 06:56:41 xeon7100 kernel: PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/00 
Oct 14 06:56:41 xeon7100 kernel: PCI: 00:01 [1166/0008]: Scanning peer host bridges 
Oct 14 06:56:41 xeon7100 kernel: PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/01 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B0,I1,P0) -> 17 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B0,I1,P0) -> 17 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B0,I5,P0) -> 16 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 26 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B1,I2,P0) -> 21 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B2,I3,P0) -> 22 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B2,I4,P0) -> 23 
Oct 14 06:56:41 xeon7100 kernel: PCI->APIC IRQ transform: (B2,I6,P0) -> 25 
Oct 14 06:56:41 xeon7100 kernel: Linux NET4.0 for Linux 2.2 
Oct 14 06:56:41 xeon7100 kernel: Based upon Swansea University Computer Society NET3.039 
Oct 14 06:56:41 xeon7100 kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0. 
Oct 14 06:56:41 xeon7100 kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Oct 14 06:56:41 xeon7100 kernel: IP Protocols: ICMP, UDP, TCP 
Oct 14 06:56:41 xeon7100 kernel: TCP: Hash tables configured (ehash 524288 bhash 65536) 
Oct 14 06:56:41 xeon7100 kernel: Starting kswapd v 1.5  
Oct 14 06:56:41 xeon7100 kernel: Detected PS/2 Mouse Port. 
Oct 14 06:56:41 xeon7100 kernel: Serial driver version 4.27 with no serial options enabled 
Oct 14 06:56:41 xeon7100 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Oct 14 06:56:41 xeon7100 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Oct 14 06:56:41 xeon7100 kernel: pty: 256 Unix98 ptys configured 
Oct 14 06:56:41 xeon7100 kernel: Real Time Clock Driver v1.09 
Oct 14 06:56:41 xeon7100 kernel: PCI_IDE: unknown IDE controller on PCI bus 00 device 79, VID=1166, DID=0211 
Oct 14 06:56:41 xeon7100 kernel: PCI_IDE: not 100%% native mode: will probe irqs later 
Oct 14 06:56:41 xeon7100 kernel:     ide0: BM-DMA at 0x0840-0x0847, BIOS settings: hda:DMA, hdb:DMA 
Oct 14 06:56:41 xeon7100 kernel:     ide1: BM-DMA at 0x0848-0x084f, BIOS settings: hdc:pio, hdd:pio 
Oct 14 06:56:41 xeon7100 kernel: hda: LTN403, ATAPI CDROM drive 
Oct 14 06:56:41 xeon7100 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Oct 14 06:56:41 xeon7100 kernel: hda: ATAPI 40X CD-ROM drive, 120kB Cache 
Oct 14 06:56:41 xeon7100 kernel: Uniform CD-ROM driver Revision: 3.11 
Oct 14 06:56:41 xeon7100 kernel: Floppy drive(s): fd0 is 1.44M 
Oct 14 06:56:41 xeon7100 kernel: FDC 0 is a National Semiconductor PC87306 
Oct 14 06:56:41 xeon7100 kernel: (scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/1/0 
Oct 14 06:56:41 xeon7100 kernel: (scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs 
Oct 14 06:56:41 xeon7100 kernel: (scsi0) Downloading sequencer code... 393 instructions downloaded 
Oct 14 06:56:41 xeon7100 kernel: (scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/1/1 
Oct 14 06:56:41 xeon7100 kernel: (scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs 
Oct 14 06:56:41 xeon7100 kernel: (scsi1) Downloading sequencer code... 393 instructions downloaded 
Oct 14 06:56:41 xeon7100 kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4 
Oct 14 06:56:41 xeon7100 kernel:        <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> 
Oct 14 06:56:41 xeon7100 kernel: scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4 
Oct 14 06:56:41 xeon7100 kernel:        <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> 
Oct 14 06:56:41 xeon7100 kernel: scsi2 : IBM PCI ServeRAID 4.20.20  <ServeRAID 3H> 
Oct 14 06:56:41 xeon7100 kernel: scsi : 3 hosts. 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel: Detected scsi disk sda at scsi2, channel 0, id 0, lun 0 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel: Detected scsi disk sdb at scsi2, channel 0, id 1, lun 0 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel: Detected scsi disk sdc at scsi2, channel 0, id 2, lun 0 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel: Detected scsi disk sdd at scsi2, channel 0, id 3, lun 0 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel: Detected scsi disk sde at scsi2, channel 0, id 4, lun 0 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel: Detected scsi disk sdf at scsi2, channel 0, id 5, lun 0 
Oct 14 06:56:41 xeon7100 kernel:   Vendor:  IBM      Model:  SERVERAID        Rev:  1.0 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Processor                          ANSI SCSI revision: 01 
Oct 14 06:56:41 xeon7100 kernel:   Vendor: IBM       Model: LnRv1.5V S 80     Rev: B004 
Oct 14 06:56:41 xeon7100 kernel:   Type:   Processor                          ANSI SCSI revision: 02 
Oct 14 06:56:41 xeon7100 kernel: scsi : detected 6 SCSI disks total. 
Oct 14 06:56:41 xeon7100 kernel: SCSI device sda: hdwr sector= 512 bytes. Sectors= 17772544 [8678 MB] [8.7 GB] 
Oct 14 06:56:41 xeon7100 kernel: SCSI device sdb: hdwr sector= 512 bytes. Sectors= 35547136 [17357 MB] [17.4 GB] 
Oct 14 06:56:41 xeon7100 kernel: SCSI device sdc: hdwr sector= 512 bytes. Sectors= 35547136 [17357 MB] [17.4 GB] 
Oct 14 06:56:41 xeon7100 kernel: SCSI device sdd: hdwr sector= 512 bytes. Sectors= 71094272 [34714 MB] [34.7 GB] 
Oct 14 06:56:41 xeon7100 kernel: SCSI device sde: hdwr sector= 512 bytes. Sectors= 35547136 [17357 MB] [17.4 GB] 
Oct 14 06:56:41 xeon7100 kernel: SCSI device sdf: hdwr sector= 512 bytes. Sectors= 35547136 [17357 MB] [17.4 GB] 
Oct 14 06:56:41 xeon7100 kernel: Partition check: 
Oct 14 06:56:41 xeon7100 kernel:  sda: sda1 sda2 < sda5 sda6 > 
Oct 14 06:56:41 xeon7100 kernel:  sdb: sdb1 
Oct 14 06:56:41 xeon7100 kernel:  sdc: sdc1 
Oct 14 06:56:41 xeon7100 kernel:  sdd: sdd1 
Oct 14 06:56:41 xeon7100 kernel:  sde: sde1 
Oct 14 06:56:41 xeon7100 kernel:  sdf: sdf1 
Oct 14 06:56:41 xeon7100 kernel: apm: BIOS not found. 
Oct 14 06:56:41 xeon7100 kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Oct 14 06:56:41 xeon7100 kernel: Freeing unused kernel memory: 60k freed 
Oct 14 06:56:41 xeon7100 kernel: Adding Swap: 528024k swap-space (priority -1) 
Oct 14 06:56:41 xeon7100 kernel: pcnet32.c: PCI bios is present, checking for devices... 
Oct 14 06:56:41 xeon7100 kernel: Found PCnet/PCI at 0x2200, irq 16. 
Oct 14 06:56:41 xeon7100 kernel: eth0: PCnet/FAST III 79C975 at 0x2200, 00 06 29 55 07 6a assigned IRQ 16. 
Oct 14 06:56:41 xeon7100 kernel: pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de 
Oct 14 06:56:41 xeon7100 kernel: 3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vortex.html 
Oct 14 06:56:41 xeon7100 kernel: eth1: 3Com 3c905B Cyclone 100baseTx at 0x2280,  00:01:02:ce:93:c4, IRQ 23 
Oct 14 06:56:41 xeon7100 kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface. 
Oct 14 06:56:41 xeon7100 kernel:   MII transceiver found at address 24, status 786d. 
Oct 14 06:56:41 xeon7100 kernel:   Enabling bus-master transmits and whole-frame receives. 
Oct 14 06:56:41 xeon7100 kernel: eth1: Initial media type Autonegotiate. 
Oct 14 06:56:41 xeon7100 kernel: eth1: MII #24 status 786d, link partner capability 41e1, setting full-duplex. 
Oct 14 06:56:41 xeon7100 kernel: Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension (NICE) ver. 2.0.32 (01/02/02) 
Oct 14 06:56:41 xeon7100 kernel: eth2: 3Com 3C996B Gigabit Server NIC found at mem f7ff0000, IRQ 21, node addr 000476db37ee 
Oct 14 06:56:41 xeon7100 kernel: eth2: Broadcom BCM5701 Integrated Copper transceiver found 
Oct 14 06:56:41 xeon7100 kernel: eth2: Rx Checksum ON 

--------------030609090302010801080405
Content-Type: text/plain;
 name="uptime"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uptime"

11:39am  up  4:46,  2 users,  load average: 4.00, 2.82, 3.29

--------------030609090302010801080405--

