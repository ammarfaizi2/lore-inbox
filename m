Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSBUHX0>; Thu, 21 Feb 2002 02:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBUHXR>; Thu, 21 Feb 2002 02:23:17 -0500
Received: from mcns119.docsis245.scvmaxonline.com.sg ([202.156.245.119]:45583
	"HELO server.hoeg.home") by vger.kernel.org with SMTP
	id <S284180AbSBUHXA>; Thu, 21 Feb 2002 02:23:00 -0500
To: linux-kernel@vger.kernel.org
Subject: misdetection of pentium2 - very strange
Message-ID: <1014276172.3c74a04c7565e@www.hoeg.home>
Date: Thu, 21 Feb 2002 15:22:52 +0800 (SGT)
From: peter@hoeg.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 202.42.167.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gentlemen,

i have been receiving this message since the installation of debian potato 
2.2r4 (kernel 2.2.19) and multiple 2.4.x kernels since then and it just doesn't 
make sense. the computer is a compaq ep/sb series with a 333mhz p2 and 
definately not a 133.

know this is not a critical error, but still annoying... am ofcourse willing to 
test out any patches and if further info is needed please just shout.

please do cc me in on your replies (if any) as i don't subscribe to the list.

thanks in advance,
peter

====

dmesg:

Linux version 2.4.18-rc2 (peter@asilog-linux2) (gcc version 2.95.4 (Debian 
prerelease)) #3 Thu Feb 21 19:21:37 SGT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=301 devfs=mount 
video=atyfb:1024x768@8
Initializing CPU#0
Detected 133.225 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 265.42 BogoMIPS
Memory: 191116k/196608k available (1179k kernel code, 5104k reserved, 332k 
data, 232k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0080f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0080f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0080f9ff 00000000 00000000 00000000
CPU:             Common caps: 0080f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.

/proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 4
cpu MHz		: 133.225
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips	: 265.42
