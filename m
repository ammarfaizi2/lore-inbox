Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTH2Pmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbTH2Pmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:42:38 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:1937 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S261305AbTH2PlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:41:12 -0400
Date: Fri, 29 Aug 2003 08:41:01 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829154101.GB16319@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:35:10AM +0100, Jamie Lokier wrote:
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.

Results for Alpha, IA64, MIPS, ARM, PARISC, PPC, MIPSEL, X86, SPARC

If you care, I also have freebsd (v2, v3, v4), netbsd 1.5, openbsd 3.0 (all
bsd systems are x86, mostly celerons), hpux 10.20, sco, solaris, solaris/x86,
Irix, MacOS X, AIX, Tru64 and probably some others.

====== alpha.bitmover.com ======
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
Linux alpha.bitmover.com 2.4.21-pre5 #2 Thu Mar 20 07:54:03 PST 2003 alpha unknown
cpu			: Alpha
cpu model		: EV56
cpu variation		: 7
cpu revision		: 0
cpu serial number	: 
system type		: EB164
system variation	: PC164
system revision		: 0
system serial number	: 
cycle frequency [Hz]	: 500000000 
timer frequency [Hz]	: 1024.00
page size [bytes]	: 8192
phys. address bits	: 40
max. addr. space #	: 127
BogoMIPS		: 992.88
kernel unaligned acc	: 0 (pc=0,va=0)
user unaligned acc	: 0 (pc=0,va=0)
platform string		: Digital AlphaPC 164 500 MHz
cpus detected		: 1

====== ia64.bitmover.com ======
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
Linux ia64.bitmover.com 2.4.9-18smp #1 SMP Tue Dec 11 12:59:00 EST 2001 ia64 unknown
processor  : 0
vendor     : GenuineIntel
arch       : IA-64
family     : Itanium
model      : 0
revision   : 7
archrev    : 0
features   : standard
cpu number : 0
cpu regs   : 4
cpu MHz    : 799.486992
itc MHz    : 799.486992
BogoMIPS   : 796.91

processor  : 1
vendor     : GenuineIntel
arch       : IA-64
family     : Itanium
model      : 0
revision   : 7
archrev    : 0
features   : standard
cpu number : 0
cpu regs   : 4
cpu MHz    : 799.486992
itc MHz    : 799.486992
BogoMIPS   : 796.91


====== mips.bitmover.com ======
Test separation: 4096 bytes: FAIL - too slow
Test separation: 8192 bytes: FAIL - too slow
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)
Linux mips 2.4.18-r4k-ip22 #1 Sun Jun 23 15:30:50 CEST 2002 mips unknown
system type		: SGI Indy
processor		: 0
cpu model		: R4000SC V6.0  FPU V0.0
BogoMIPS		: 86.83
byteorder		: big endian
wait instruction	: no
microsecond timers	: yes
tlb_entries		: 48
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: 2955114
VCEI exceptions		: 0

====== netwinder.bitmover.com ======
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: FAIL - cache not coherent
Test separation: 32768 bytes: FAIL - cache not coherent
Test separation: 65536 bytes: FAIL - cache not coherent
Test separation: 131072 bytes: FAIL - cache not coherent
Test separation: 262144 bytes: FAIL - cache not coherent
Test separation: 524288 bytes: FAIL - cache not coherent
Test separation: 1048576 bytes: FAIL - cache not coherent
Test separation: 2097152 bytes: FAIL - cache not coherent
Test separation: 4194304 bytes: FAIL - cache not coherent
Test separation: 8388608 bytes: FAIL - cache not coherent
Test separation: 16777216 bytes: FAIL - cache not coherent
VM page alias coherency test: failed; will use copy buffers instead
Linux netwinder 2.2.12-19991020 #1 Wed Oct 20 13:09:07 EDT 1999 armv4l unknown
Processor	: Intel sa110 rev 3
BogoMips	: 262.14
Hardware	: Rebel-NetWinder
Serial #	: 3464
Revision	: 52ff

====== parisc.bitmover.com ======
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: FAIL - cache not coherent
Test separation: 32768 bytes: FAIL - cache not coherent
Test separation: 65536 bytes: FAIL - cache not coherent
Test separation: 131072 bytes: FAIL - cache not coherent
Test separation: 262144 bytes: FAIL - store buffer not coherent
Test separation: 524288 bytes: FAIL - store buffer not coherent
Test separation: 1048576 bytes: FAIL - store buffer not coherent
Test separation: 2097152 bytes: FAIL - store buffer not coherent
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 4194304 (1024 pages)
Linux parisc 2.4.17-64 #1 Sat Mar 16 17:31:44 MST 2002 parisc64 unknown
processor	: 0
cpu family	: PA-RISC 2.0
cpu		: PA8600 (PCX-W+)
cpu MHz		: 550.000000
model		: 9000/800/A500-5X
model name	: Crescendo 550
hversion	: 0x00005d50
sversion	: 0x00000491
I-cache		: 512 KB
D-cache		: 1024 KB (WB)
ITLB entries	: 160
DTLB entries	: 160 - shared with ITLB
bogomips	: 1097.72
software id	: 580790518


====== ppc.bitmover.com ======
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
Linux ppc.bitmover.com 2.4.6-pre2 #2 Sun Jun 10 20:21:17 PDT 2001 ppc unknown
processor	: 0
cpu		: 750
temperature 	: 0 C
clock		: 333MHz
revision	: 2.2
bogomips	: 665.69
zero pages	: total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine		: iMac,1
motherboard	: iMac MacRISC Power Macintosh
L2 cache	: 512K unified
memory		: 160MB
pmac-generation	: NewWorld

====== qube.bitmover.com ======
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)
0.31user 0.10system 0:00.40elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (116major+34minor)pagefaults 0swaps
Linux qube.bitmover.com 2.0.34 #1 Thu Jan 28 03:03:03 PST 1999 mips unknown
cpu			: MIPS
cpu model		: Nevada V10.0
system type		: Cobalt Microserver 27
BogoMIPS		: 249.86
byteorder		: little endian
unaligned accesses	: 16
wait instruction	: yes
microsecond timers	: yes
extra interrupt vector	: yes
hardware watchpoint	: no

====== redhat71.bitmover.com ======
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
Linux redhat71.bitmover.com 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 467.739
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 933.88


====== sparc.bitmover.com ======
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (2 pages)
0.29user 0.02system 0:00.31elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (107major+36minor)pagefaults 0swaps
Linux sparc.bitmover.com 2.2.18 #2 Thu Dec 21 18:53:16 PST 2000 sparc64 unknown
cpu		: TI UltraSparc IIi
fpu		: UltraSparc IIi integrated FPU
promlib		: Version 3 Revision 11
prom		: 3.11.12
type		: sun4u
ncpus probed	: 1
ncpus active	: 1
BogoMips	: 539.03
MMU Type	: Spitfire

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
