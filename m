Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132049AbRDGW4y>; Sat, 7 Apr 2001 18:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbRDGW4o>; Sat, 7 Apr 2001 18:56:44 -0400
Received: from hose.mail.pipex.net ([158.43.128.58]:25491 "HELO
	hose.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132049AbRDGW41>; Sat, 7 Apr 2001 18:56:27 -0400
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Sat, 07 Apr 2001 23:56:51
Subject: Re: P-III Oddity.
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010407225637Z132049-494+49@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Apr 2001 19:58:15, Dave Jones <davej@suse.de> wrote:

> On Sat, 7 Apr 2001, Rogier Wolff wrote:
> 
> > One machine regularly crashes.
> > Linux version 2.2.16-3 (root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Jun 19 19:11:44 EDT 2000
> 
> Probably unrelated to the issue below. Try a more recent 2.2 ?
> 
> > cpuid level     : 2
> 
> CPU serial number disabled.
> 
> > cpuid level     : 3
> 
> CPU serial number enabled.

I've got this on my dual processor P-III 600MHz. One of the cpus in 
this box reports cpuid level 2, the other 3. Serial number is disabled
in the BIOS.

> You should be able to confirm this with my x86info tool.
> ftp://ftp.suse.com/pub/people/davej/x86info/x86info-1.0.tgz
> 
> If this isn't the case, can you send me the output of
> x86info -a on both CPUs ?

x86info v1.0.  Dave Jones 2001
Feedback to <davej@suse.de>.

Found 2 CPU
seax in: 0, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 
49656e69
eax in: 1, eax = 00000673 ebx = 00000000 ecx = 00000000 edx = 0383fbff
eax in: 2, eax = 03020101 ebx = 00000000 ecx = 00000000 edx = 0c040843
Vendor ID: "GenuineIntel"; Max CPUID level 2

Intel-specific functions
Family: 6 Model: 7 Type 0 [Pentium III/Pentium III Xeon Original OEM]
Stepping: 3
Reserved: 0

Feature flags 0383fbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and 
enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
XMM    Streaming SIMD Extensions instruction set
Instruction TLB: 4KB pages, 4-way set assoc, 32 entries
Instruction TLB: 4MB pages, fully assoc, 2 entries
Data TLB: 4KB pages, 4-way set assoc, 64 entries
L2 unified cache: 512KB, 4-way set assoc, 32 byte line size
Instruction cache: 16KB, 4-way set assoc, 32 byte line size
Data TLB: 4MB pages, 4-way set assoc, 8 entries
Data cache: 16KB, 2-way or 4-way set assoc, 32 byte line size
eax in: 0, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 1, eax = 00000673 ebx = 00000000 ecx = 00000000 edx = 0383fbff
eax in: 2, eax = 03020101 ebx = 00000000 ecx = 00000000 edx = 0c040843
Vendor ID: "GenuineIntel"; Max CPUID level 2

Intel-specific functions
Family: 6 Model: 7 Type 0 [Pentium III/Pentium III Xeon Original OEM]
Stepping: 3
Reserved: 0

Feature flags 0383fbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and 
enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
XMM    Streaming SIMD Extensions instruction set
Instruction TLB: 4KB pages, 4-way set assoc, 32 entries
Instruction TLB: 4MB pages, fully assoc, 2 entries
Data TLB: 4KB pages, 4-way set assoc, 64 entries
L2 unified cache: 512KB, 4-way set assoc, 32 byte line size
Instruction cache: 16KB, 4-way set assoc, 32 byte line size
Data TLB: 4MB pages, 4-way set assoc, 8 entries
Data cache: 16KB, 2-way or 4-way set assoc, 32 byte line size

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 598.407
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1192.75

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 598.407
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1196.03

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
