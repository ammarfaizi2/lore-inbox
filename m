Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbTIAOna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 10:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTIAOna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 10:43:30 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:52456 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262904AbTIAOnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 10:43:11 -0400
Date: Mon, 1 Sep 2003 07:43:04 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901144304.GA1327@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030901054413.GF748@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901054413.GF748@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Results for Alpha, IA64, MIPS, ARM, PARISC, PPC, MIPSEL, X86, SPARC, s390
on Linux and hpux/parisc, {freebsd, netbsd, openbsd}/x86, sco/x86, 
solaris/sparc, solaris/x86, irix/mips, osx/ppc, aix/ppc, tru64/alpha.

This is most of our test machines, it doesn't include all the Windows
boxes but I figured you didn't care.

The version of test.c is the one you posted later.  If I got it wrong
send me the latest.

work ~/jamie wc test.c
    773    3726   25064 test.c
work ~/jamie md5sum test.c
1e7b9e6fa525c21211abbb8986d7b2e7  test.c

I'm a little concerned I have the wrong test, why would a 2.1Ghz Athlon 
say it is too slow?

Format: 
    ==== host name ====
    Notes (may be blank)

    Results

    uname -a output
    /proc/cpuinfo (if there)

==== aix ====
332Mhz 604e 7043-150

Test separation: 4096 bytes: FAIL - alias map failed
Test separation: 8192 bytes: FAIL - alias map failed
Test separation: 16384 bytes: FAIL - alias map failed
Test separation: 32768 bytes: FAIL - alias map failed
Test separation: 65536 bytes: FAIL - alias map failed
Test separation: 131072 bytes: FAIL - alias map failed
Test separation: 262144 bytes: FAIL - alias map failed
Test separation: 524288 bytes: FAIL - alias map failed
Test separation: 1048576 bytes: FAIL - alias map failed
Test separation: 2097152 bytes: FAIL - alias map failed
Test separation: 4194304 bytes: FAIL - alias map failed
Test separation: 8388608 bytes: FAIL - alias map failed
Test separation: 16777216 bytes: FAIL - alias map failed
VM page alias coherency test: failed; will use copy buffers instead

AIX aix 1 4 004376804C00

==== alpha ====
PC something-164, that really common cheapo motherboard/test kit.

(512) [14,14,0] Test separation: 8192 bytes: pass
(512) [14,14,0] Test separation: 16384 bytes: pass
(512) [14,14,0] Test separation: 32768 bytes: pass
(512) [14,14,0] Test separation: 65536 bytes: pass
(512) [14,14,0] Test separation: 131072 bytes: pass
(512) [14,14,0] Test separation: 262144 bytes: pass
(512) [14,14,0] Test separation: 524288 bytes: pass
(512) [14,14,0] Test separation: 1048576 bytes: pass
(512) [14,14,0] Test separation: 2097152 bytes: pass
(512) [14,14,0] Test separation: 4194304 bytes: pass
(512) [14,14,0] Test separation: 8388608 bytes: pass
(512) [14,14,0] Test separation: 16777216 bytes: pass
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

==== disks ====
(128) [17,1,0] Test separation: 4096 bytes: FAIL - too slow
(128) [17,1,0] Test separation: 8192 bytes: FAIL - too slow
(128) [17,1,0] Test separation: 16384 bytes: FAIL - too slow
(1024) [10,13,0] Test separation: 32768 bytes: pass
(1024) [10,13,0] Test separation: 65536 bytes: pass
(1024) [10,13,0] Test separation: 131072 bytes: pass
(1024) [10,13,0] Test separation: 262144 bytes: pass
(1024) [10,13,0] Test separation: 524288 bytes: pass
(1024) [10,13,0] Test separation: 1048576 bytes: pass
(1024) [10,13,0] Test separation: 2097152 bytes: pass
(1024) [10,13,0] Test separation: 4194304 bytes: pass
(1024) [10,13,0] Test separation: 8388608 bytes: pass
(1024) [10,13,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 32768 (8 pages)

Linux disks.bitmover.com 2.4.18-14 #1 Wed Sep 4 12:13:11 EDT 2002 i686 athlon i386 GNU/Linux
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1900+
stepping	: 2
cpu MHz		: 1593.143
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3172.64

==== freebsd ====
(512) [32,32,1] Test separation: 4096 bytes: pass
(512) [32,32,1] Test separation: 8192 bytes: pass
(512) [32,32,1] Test separation: 16384 bytes: pass
(512) [32,32,1] Test separation: 32768 bytes: pass
(512) [32,32,1] Test separation: 65536 bytes: pass
(512) [32,32,1] Test separation: 131072 bytes: pass
(512) [32,32,1] Test separation: 262144 bytes: pass
(512) [32,32,1] Test separation: 524288 bytes: pass
(512) [32,32,1] Test separation: 1048576 bytes: pass
(512) [32,32,1] Test separation: 2097152 bytes: pass
(512) [32,32,1] Test separation: 4194304 bytes: pass
(512) [32,32,1] Test separation: 8388608 bytes: pass
(512) [32,32,1] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

FreeBSD freebsd.bitmover.com 2.2.8-RELEASE FreeBSD 2.2.8-RELEASE #0: Mon Nov 30 06:34:08 GMT 1998     jkh@time.cdrom.com:/usr/src/sys/compile/GENERIC  i386

==== freebsd3 ====
(64) [33,3,1] Test separation: 4096 bytes: FAIL - too slow
(64) [33,3,1] Test separation: 8192 bytes: FAIL - too slow
(512) [19,26,1] Test separation: 16384 bytes: pass
(512) [19,26,1] Test separation: 32768 bytes: pass
(512) [19,26,1] Test separation: 65536 bytes: pass
(512) [19,26,1] Test separation: 131072 bytes: pass
(512) [19,26,1] Test separation: 262144 bytes: pass
(512) [19,26,1] Test separation: 524288 bytes: pass
(512) [19,26,1] Test separation: 1048576 bytes: pass
(512) [19,26,1] Test separation: 2097152 bytes: pass
(512) [19,26,1] Test separation: 4194304 bytes: pass
(512) [19,26,1] Test separation: 8388608 bytes: pass
(512) [19,26,1] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)

FreeBSD freebsd3.bitmover.com 3.2-RELEASE FreeBSD 3.2-RELEASE #0: Fri Jun  2 11:34:52 PDT 2000     root@freebsd3.bitmover.com:/usr/src/sys/compile/DAVICOM  i386

==== freebsd4 ====
(256) [92,26,5] Test separation: 4096 bytes: FAIL - too slow
(256) [92,26,5] Test separation: 8192 bytes: FAIL - too slow
(1024) [75,101,5] Test separation: 16384 bytes: pass
(1024) [75,101,5] Test separation: 32768 bytes: pass
(1024) [75,101,5] Test separation: 65536 bytes: pass
(1024) [75,101,5] Test separation: 131072 bytes: pass
(1024) [75,101,5] Test separation: 262144 bytes: pass
(1024) [75,101,5] Test separation: 524288 bytes: pass
(1024) [75,101,5] Test separation: 1048576 bytes: pass
(1024) [75,101,5] Test separation: 2097152 bytes: pass
(1024) [75,101,5] Test separation: 4194304 bytes: pass
(1024) [75,101,5] Test separation: 8388608 bytes: pass
(1024) [75,101,5] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)

FreeBSD freebsd4.bitmover.com 4.1-RELEASE FreeBSD 4.1-RELEASE #0: Fri Jul 28 14:30:31 GMT 2000     jkh@ref4.freebsd.org:/usr/src/sys/compile/GENERIC  i386

==== hp ====
C360, HPUX 10.20

Test separation: 4096 bytes: FAIL - alias map failed
Test separation: 8192 bytes: FAIL - alias map failed
Test separation: 16384 bytes: FAIL - alias map failed
Test separation: 32768 bytes: FAIL - alias map failed
Test separation: 65536 bytes: FAIL - alias map failed
Test separation: 131072 bytes: FAIL - alias map failed
Test separation: 262144 bytes: FAIL - alias map failed
Test separation: 524288 bytes: FAIL - alias map failed
Test separation: 1048576 bytes: FAIL - alias map failed
Test separation: 2097152 bytes: FAIL - alias map failed
Test separation: 4194304 bytes: FAIL - alias map failed
Test separation: 8388608 bytes: FAIL - alias map failed
Test separation: 16777216 bytes: FAIL - alias map failed
VM page alias coherency test: failed; will use copy buffers instead

HP-UX hp B.10.20 A 9000/785 2004452144 two-user license

==== ia64 ====
(512) [17,17,0] Test separation: 16384 bytes: pass
(512) [17,17,0] Test separation: 32768 bytes: pass
(512) [17,17,0] Test separation: 65536 bytes: pass
(512) [17,17,0] Test separation: 131072 bytes: pass
(512) [17,17,0] Test separation: 262144 bytes: pass
(512) [17,17,0] Test separation: 524288 bytes: pass
(512) [17,17,0] Test separation: 1048576 bytes: pass
(512) [17,17,0] Test separation: 2097152 bytes: pass
(512) [17,17,0] Test separation: 4194304 bytes: pass
(512) [17,17,0] Test separation: 8388608 bytes: pass
(512) [17,17,0] Test separation: 16777216 bytes: pass
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

==== macos ====
Imac, OS X 10.2

(2048) [67,67,3] Test separation: 4096 bytes: pass
(2048) [67,67,3] Test separation: 8192 bytes: pass
(2048) [67,67,3] Test separation: 16384 bytes: pass
(2048) [67,67,3] Test separation: 32768 bytes: pass
(2048) [67,67,3] Test separation: 65536 bytes: pass
(2048) [67,67,3] Test separation: 131072 bytes: pass
(2048) [67,67,3] Test separation: 262144 bytes: pass
(2048) [67,67,3] Test separation: 524288 bytes: pass
(2048) [67,67,3] Test separation: 1048576 bytes: pass
(2048) [67,67,3] Test separation: 2097152 bytes: pass
(2048) [67,67,3] Test separation: 4194304 bytes: pass
(2048) [67,67,3] Test separation: 8388608 bytes: pass
(2048) [67,67,3] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

Darwin macos.bitmover.com 6.6 Darwin Kernel Version 6.6: Thu May  1 21:48:54 PDT 2003; root:xnu/xnu-344.34.obj~1/RELEASE_PPC  Power Macintosh powerpc

==== mips ====
(64) [276,11,2] Test separation: 4096 bytes: FAIL - too slow
(64) [276,11,2] Test separation: 8192 bytes: FAIL - too slow
(128) [26,43,2] Test separation: 16384 bytes: pass
(128) [26,43,2] Test separation: 32768 bytes: pass
(128) [26,43,2] Test separation: 65536 bytes: pass
(128) [26,43,2] Test separation: 131072 bytes: pass
(128) [26,43,2] Test separation: 262144 bytes: pass
(128) [26,43,2] Test separation: 524288 bytes: pass
(128) [26,43,2] Test separation: 1048576 bytes: pass
(128) [26,43,2] Test separation: 2097152 bytes: pass
(128) [26,43,2] Test separation: 4194304 bytes: pass
(128) [26,43,2] Test separation: 8388608 bytes: pass
(128) [26,43,2] Test separation: 16777216 bytes: pass
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
VCED exceptions		: 8055726
VCEI exceptions		: 0

==== netbsd ====
(1024) [53,53,4] Test separation: 4096 bytes: pass
(2048) [106,106,4] Test separation: 8192 bytes: pass
(2048) [104,105,5] Test separation: 16384 bytes: pass
(2048) [105,104,5] Test separation: 32768 bytes: pass
(2048) [105,104,5] Test separation: 65536 bytes: pass
(2048) [104,104,5] Test separation: 131072 bytes: pass
(2048) [105,105,5] Test separation: 262144 bytes: pass
(2048) [105,105,5] Test separation: 524288 bytes: pass
(1024) [53,53,4] Test separation: 1048576 bytes: pass
(2048) [104,104,5] Test separation: 2097152 bytes: pass
(2048) [106,106,4] Test separation: 4194304 bytes: pass
(2048) [105,106,4] Test separation: 8388608 bytes: pass
(2048) [104,105,5] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

NetBSD netbsd.bitmover.com 1.5 NetBSD 1.5 (GENERIC) #1: Sun Nov 19 21:42:11 MET 2000     fvdl@sushi:/work/trees/netbsd-1-5/sys/arch/i386/compile/GENERIC i386

==== netwinder ====
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

==== openbsd ====
(512) [27,27,1] Test separation: 4096 bytes: pass
(512) [27,27,1] Test separation: 8192 bytes: pass
(512) [27,27,1] Test separation: 16384 bytes: pass
(512) [27,27,1] Test separation: 32768 bytes: pass
(512) [27,27,1] Test separation: 65536 bytes: pass
(512) [27,27,1] Test separation: 131072 bytes: pass
(512) [27,27,1] Test separation: 262144 bytes: pass
(512) [27,27,1] Test separation: 524288 bytes: pass
(512) [27,27,1] Test separation: 1048576 bytes: pass
(512) [27,27,1] Test separation: 2097152 bytes: pass
(512) [27,27,1] Test separation: 4194304 bytes: pass
(512) [27,27,1] Test separation: 8388608 bytes: pass
(512) [27,27,1] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

OpenBSD openbsd 3.0 GENERIC#94 i386

==== parisc ====
A500
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
(2048) [41,41,2] Test separation: 4194304 bytes: pass
(2048) [41,41,2] Test separation: 8388608 bytes: pass
(2048) [41,41,2] Test separation: 16777216 bytes: pass
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

==== ppc ====
(1024) [40,40,1] Test separation: 4096 bytes: pass
(1024) [40,40,1] Test separation: 8192 bytes: pass
(1024) [40,40,1] Test separation: 16384 bytes: pass
(1024) [40,40,1] Test separation: 32768 bytes: pass
(1024) [40,40,1] Test separation: 65536 bytes: pass
(1024) [40,40,1] Test separation: 131072 bytes: pass
(1024) [40,40,1] Test separation: 262144 bytes: pass
(1024) [40,40,1] Test separation: 524288 bytes: pass
(1024) [40,40,1] Test separation: 1048576 bytes: pass
(1024) [40,40,1] Test separation: 2097152 bytes: pass
(1024) [40,40,1] Test separation: 4194304 bytes: pass
(1024) [40,40,1] Test separation: 8388608 bytes: pass
(1024) [40,40,1] Test separation: 16777216 bytes: pass
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

==== qube ====
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
(512) [47,47,2] Test separation: 16384 bytes: pass
(512) [47,47,2] Test separation: 32768 bytes: pass
(512) [47,47,2] Test separation: 65536 bytes: pass
(512) [47,47,2] Test separation: 131072 bytes: pass
(512) [47,47,2] Test separation: 262144 bytes: pass
(512) [47,47,2] Test separation: 524288 bytes: pass
(512) [47,47,2] Test separation: 1048576 bytes: pass
(512) [47,47,2] Test separation: 2097152 bytes: pass
(512) [47,47,2] Test separation: 4194304 bytes: pass
(512) [47,47,2] Test separation: 8388608 bytes: pass
(512) [47,47,2] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)

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

==== redhat52 ====
(256) [12,12,0] Test separation: 4096 bytes: pass
(256) [12,12,0] Test separation: 8192 bytes: pass
(256) [12,12,0] Test separation: 16384 bytes: pass
(256) [12,12,0] Test separation: 32768 bytes: pass
(256) [12,12,0] Test separation: 65536 bytes: pass
(256) [12,12,0] Test separation: 131072 bytes: pass
(256) [12,12,0] Test separation: 262144 bytes: pass
(256) [12,12,0] Test separation: 524288 bytes: pass
(256) [12,12,0] Test separation: 1048576 bytes: pass
(256) [12,12,0] Test separation: 2097152 bytes: pass
(256) [12,12,0] Test separation: 4194304 bytes: pass
(256) [12,12,0] Test separation: 8388608 bytes: pass
(256) [12,12,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

Linux redhat52.bitmover.com 2.2.15pre9 #10 Sat Apr 8 17:59:35 PDT 2000 i686 unknown
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 534.561273
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 532.48

==== redhat62 ====
(256) [12,12,0] Test separation: 4096 bytes: pass
(256) [12,12,0] Test separation: 8192 bytes: pass
(256) [12,12,0] Test separation: 16384 bytes: pass
(256) [12,12,0] Test separation: 32768 bytes: pass
(256) [12,12,0] Test separation: 65536 bytes: pass
(256) [12,12,0] Test separation: 131072 bytes: pass
(256) [12,12,0] Test separation: 262144 bytes: pass
(256) [12,12,0] Test separation: 524288 bytes: pass
(256) [12,12,0] Test separation: 1048576 bytes: pass
(256) [12,12,0] Test separation: 2097152 bytes: pass
(256) [12,12,0] Test separation: 4194304 bytes: pass
(256) [12,12,0] Test separation: 8388608 bytes: pass
(256) [12,12,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

Linux redhat62.bitmover.com 2.2.14-5.0 #1 Tue Mar 7 21:07:39 EST 2000 i686 unknown
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 534.552424
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 532.48

==== redhat71 ====
(256) [14,14,0] Test separation: 4096 bytes: pass
(256) [14,14,0] Test separation: 8192 bytes: pass
(256) [14,14,0] Test separation: 16384 bytes: pass
(256) [14,14,0] Test separation: 32768 bytes: pass
(256) [14,14,0] Test separation: 65536 bytes: pass
(256) [14,14,0] Test separation: 131072 bytes: pass
(256) [14,14,0] Test separation: 262144 bytes: pass
(256) [14,14,0] Test separation: 524288 bytes: pass
(256) [14,14,0] Test separation: 1048576 bytes: pass
(256) [14,14,0] Test separation: 2097152 bytes: pass
(256) [14,14,0] Test separation: 4194304 bytes: pass
(256) [14,14,0] Test separation: 8388608 bytes: pass
(256) [14,14,0] Test separation: 16777216 bytes: pass
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

==== sco ====
(1024) [48,48,2] Test separation: 4096 bytes: pass
(1024) [48,48,2] Test separation: 8192 bytes: pass
(1024) [48,48,2] Test separation: 16384 bytes: pass
(1024) [48,48,2] Test separation: 32768 bytes: pass
(1024) [48,48,2] Test separation: 65536 bytes: pass
(1024) [48,48,2] Test separation: 131072 bytes: pass
(1024) [48,48,1] Test separation: 262144 bytes: pass
(1024) [49,49,1] Test separation: 524288 bytes: pass
(1024) [48,48,2] Test separation: 1048576 bytes: pass
(1024) [48,48,2] Test separation: 2097152 bytes: pass
(1024) [48,48,2] Test separation: 4194304 bytes: pass
(1024) [48,48,2] Test separation: 8388608 bytes: pass
(1024) [48,48,2] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

SCO_SV sco 3.2 5.0.7 i386

==== sgi ====
FPU: MIPS R10010 Floating Point Chip Revision: 0.0
CPU: MIPS R10000 Processor Chip Revision: 2.6
1 195 MHZ IP28 Processor
Main memory size: 192 Mbytes
Secondary unified instruction/data cache size: 1 Mbyte
Instruction cache size: 32 Kbytes
Data cache size: 32 Kbytes

(1024) [103,103,5] Test separation: 16384 bytes: pass
(1024) [103,103,5] Test separation: 32768 bytes: pass
(1024) [103,103,5] Test separation: 65536 bytes: pass
(1024) [103,103,5] Test separation: 131072 bytes: pass
(1024) [103,103,5] Test separation: 262144 bytes: pass
(1024) [103,103,5] Test separation: 524288 bytes: pass
(1024) [103,103,5] Test separation: 1048576 bytes: pass
(1024) [103,103,5] Test separation: 2097152 bytes: pass
(1024) [103,103,5] Test separation: 4194304 bytes: pass
(1024) [103,103,5] Test separation: 8388608 bytes: pass
(1024) [103,103,5] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

IRIX64 sgi 6.5 10120105 IP28

==== slovax ====
(128) [12,1,0] Test separation: 4096 bytes: FAIL - too slow
(128) [12,1,0] Test separation: 8192 bytes: FAIL - too slow
(128) [12,1,0] Test separation: 16384 bytes: FAIL - too slow
(2048) [15,16,0] Test separation: 32768 bytes: pass
(2048) [13,16,0] Test separation: 65536 bytes: pass
(2048) [13,16,0] Test separation: 131072 bytes: pass
(2048) [15,16,0] Test separation: 262144 bytes: pass
(2048) [15,16,0] Test separation: 524288 bytes: pass
(2048) [15,16,0] Test separation: 1048576 bytes: pass
(2048) [15,16,0] Test separation: 2097152 bytes: pass
(2048) [15,16,0] Test separation: 4194304 bytes: pass
(2048) [15,16,0] Test separation: 8388608 bytes: pass
(2048) [13,16,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 32768 (8 pages)

Linux slovax.bitmover.com 2.4.18-14 #1 Wed Sep 4 12:13:11 EDT 2002 i686 athlon i386 GNU/Linux

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2700+
stepping        : 1
cpu MHz         : 2162.685
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4297.33


==== sparc ====
Test separation: 8192 bytes: FAIL - cache not coherent
(1024) [65,71,2] Test separation: 16384 bytes: pass
(1024) [65,68,2] Test separation: 32768 bytes: pass
(512) [2,50,2] Test separation: 65536 bytes: pass
(512) [33,19,2] Test separation: 131072 bytes: pass
(512) [33,20,2] Test separation: 262144 bytes: pass
(512) [33,50,2] Test separation: 524288 bytes: pass
(512) [33,19,2] Test separation: 1048576 bytes: pass
(1024) [35,68,2] Test separation: 2097152 bytes: pass
(512) [33,42,2] Test separation: 4194304 bytes: pass
(512) [2,50,2] Test separation: 8388608 bytes: pass
(512) [5,50,2] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (2 pages)

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

==== sun ====
cpu0: SUNW,UltraSPARC-II (upaid 0 impl 0x11 ver 0x20 clock 296 MHz)
cpu1: SUNW,UltraSPARC-II (upaid 1 impl 0x11 ver 0x20 clock 296 MHz)
SunOS Release 5.6 Version Generic_105181-05 [UNIX(R) System V Release 4.0]

(128) [11,7,0] Test separation: 8192 bytes: pass
(256) [15,21,0] Test separation: 16384 bytes: pass
(256) [15,21,0] Test separation: 32768 bytes: pass
(256) [15,21,0] Test separation: 65536 bytes: pass
(256) [15,21,0] Test separation: 131072 bytes: pass
(256) [15,21,0] Test separation: 262144 bytes: pass
(256) [15,21,0] Test separation: 524288 bytes: pass
(256) [15,21,0] Test separation: 1048576 bytes: pass
(256) [15,21,0] Test separation: 2097152 bytes: pass
(256) [15,21,0] Test separation: 4194304 bytes: pass
(256) [15,21,0] Test separation: 8388608 bytes: pass
(256) [15,21,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

SunOS sun 5.6 Generic_105181-05 sun4u sparc SUNW,Ultra-2

==== sunx86 ====
2x 450Mhz Xeons

(512) [29,29,1] Test separation: 4096 bytes: pass
(512) [29,29,1] Test separation: 8192 bytes: pass
(512) [29,29,1] Test separation: 16384 bytes: pass
(512) [29,29,1] Test separation: 32768 bytes: pass
(512) [29,29,1] Test separation: 65536 bytes: pass
(512) [29,29,1] Test separation: 131072 bytes: pass
(512) [29,29,1] Test separation: 262144 bytes: pass
(512) [29,29,1] Test separation: 524288 bytes: pass
(512) [29,29,1] Test separation: 1048576 bytes: pass
(512) [29,29,1] Test separation: 2097152 bytes: pass
(512) [29,29,1] Test separation: 4194304 bytes: pass
(512) [29,29,1] Test separation: 8388608 bytes: pass
(512) [29,29,1] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

SunOS sunx86.bitmover.com 5.7 Generic_106542-18 i86pc i386 i86pc

==== tru64 ====
600AU (nicely made machine)

(65536) [976,976,0] Test separation: 8192 bytes: pass
(65536) [976,976,0] Test separation: 16384 bytes: pass
(65536) [976,976,0] Test separation: 32768 bytes: pass
(65536) [976,976,0] Test separation: 65536 bytes: pass
(65536) [976,976,0] Test separation: 131072 bytes: pass
(65536) [976,976,0] Test separation: 262144 bytes: pass
(65536) [976,976,0] Test separation: 524288 bytes: pass
(65536) [976,976,0] Test separation: 1048576 bytes: pass
(65536) [976,976,0] Test separation: 2097152 bytes: pass
(65536) [976,976,0] Test separation: 4194304 bytes: pass
(65536) [976,976,0] Test separation: 8388608 bytes: pass
(65536) [976,976,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

OSF1 tru64.bitmover.com V5.1 2650 alpha

==== winxp ====
I just did a gcc on this system, I have no idea what that did but it didn't
complain so it did something.  

win32-xp /build/jamie ./a.exe
Test separation: 4096 bytes: FAIL - alias map failed
Test separation: 8192 bytes: FAIL - alias map failed
Test separation: 16384 bytes: FAIL - alias map failed
Test separation: 32768 bytes: FAIL - alias map failed
Test separation: 65536 bytes: FAIL - alias map failed
Test separation: 131072 bytes: FAIL - alias map failed
Test separation: 262144 bytes: FAIL - alias map failed
Test separation: 524288 bytes: FAIL - alias map failed
Test separation: 1048576 bytes: FAIL - alias map failed
Test separation: 2097152 bytes: FAIL - alias map failed
Test separation: 4194304 bytes: FAIL - alias map failed
Test separation: 8388608 bytes: FAIL - alias map failed
Test separation: 16777216 bytes: FAIL - alias map failed
VM page alias coherency test: failed; will use copy buffers instead

=== zseries/RedHat ===
(256) [11,11,0] Test separation: 4096 bytes: pass
(256) [11,11,0] Test separation: 8192 bytes: pass
(256) [11,11,0] Test separation: 16384 bytes: pass
(256) [11,11,0] Test separation: 32768 bytes: pass
(256) [11,11,0] Test separation: 65536 bytes: pass
(256) [11,11,0] Test separation: 131072 bytes: pass
(256) [11,11,0] Test separation: 262144 bytes: pass
(256) [11,11,0] Test separation: 524288 bytes: pass
(256) [11,13,0] Test separation: 1048576 bytes: pass
(256) [11,13,0] Test separation: 2097152 bytes: pass
(256) [11,13,0] Test separation: 4194304 bytes: pass
(256) [11,13,0] Test separation: 8388608 bytes: pass
(256) [11,13,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

Linux l006034.zseriespenguins.ihost.com 2.4.9-38 #1 SMP Tue Sep 10 00:16:26 CEST 2002 s390 unknown

vendor_id       : IBM/S390
# processors    : 1
bogomips per cpu: 612.76
processor 0: version = FF,  identification = 049321,  machine = 9672

=== zseries/SuSE ===
(512) [21,21,1] Test separation: 4096 bytes: pass
(256) [11,11,0] Test separation: 8192 bytes: pass
(512) [21,21,1] Test separation: 16384 bytes: pass
(512) [21,21,1] Test separation: 32768 bytes: pass
(512) [21,21,1] Test separation: 65536 bytes: pass
(512) [22,22,0] Test separation: 131072 bytes: pass
(512) [22,22,0] Test separation: 262144 bytes: pass
(512) [21,21,1] Test separation: 524288 bytes: pass
(512) [21,25,1] Test separation: 1048576 bytes: pass
(512) [22,26,0] Test separation: 2097152 bytes: pass
(256) [11,13,0] Test separation: 4194304 bytes: pass
(512) [22,26,0] Test separation: 8388608 bytes: pass
(512) [21,25,1] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

Linux lh003022 2.2.16 #6 SMP Wed May 23 16:39:31 EDT 2001 s390 unknown

vendor_id       : IBM/S390
# processors    : 1
bogomips per cpu: 581.63
processor 0: version = FF,  identification = 049321,  machine = 9672
