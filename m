Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264615AbRFPLoz>; Sat, 16 Jun 2001 07:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264616AbRFPLoq>; Sat, 16 Jun 2001 07:44:46 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:43524 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S264615AbRFPLob>;
	Sat, 16 Jun 2001 07:44:31 -0400
Date: Sat, 16 Jun 2001 12:43:56 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: <linux-vax@mithra.physics.montana.edu>, <linux-kernel@vger.kernel.org>,
        Irish Linux Users Group <ilug@linux.ie>
Subject: Linux/VAX booting to a shell.
Message-ID: <Pine.LNX.4.32.0106161228490.18791-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, (mind crossposts on follow ups..)

attached below is a bootlog from the Linux/VAX port, booting up, loading
up busybox/uClibc sh and cat /proc/cpuinfo, from my VAXStation 3100m38,

Thanks to the other two members of the core VAX porting team, Andy
Phillips and Kenn Humborg and others on the linux-vax list who've given
their help, this is the second major milestone for the project, (gcc
porting was the first) now to get it working on a few other systems and
move into userspace...

Regards,
	Dave.

p.s. who said the Irish didn't hack kernels :-)

--
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


-ESA0
CPU type: KA42
Boot Head.S loaded at address 00009600
rpb/bootr5/ap/sp  00000000 00000000 00000348 00008A00
relocated at phys address 001001B2
CPU type: 0A000005 sidex: 04010102

Starting VM
Linux/VAX (linux-vax@mithra.physics.montana.edu)
IO mapped phys addr iomap_base 0x20080000, 0x0001 pages at virt 0x80fe4000 (IOMAP PTE index 0x0000)
IO unmapping 0x0001 pages at PTE index 0x0000
IO mapped phys addr iomap_base 0x200a0000, 0x0001 pages at virt 0x80fe4000 (IOMAP PTE index 0x0000)
RPB info:  l_pfncnt: 00007f1f, .l_vmb_version: 0a000400 .l_badpgs: 00000000
Physical memory: 00007f1f HW pagelets, 00000fe3 pages  (16271KB)
CPU type: KA42, SID: 00000000
calling start_kernel...
Linux version 2.4.2-20010307 (airlied@radon) (gcc version 2.95.2-linuxvax-20001231 (release)) #622 Sat Jun 16 13:32:20 IST 2001
bootmap size = 00000200
calling free_bootmem(start=00000200, len=000ffe00)
calling free_bootmem(start=001f88b8, len=00dea748)
On node 0 totalpages: 4067
zone(0): 4067 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=/tftpboot/vaxroot console=/dev/ttyS
Calibrating delay loop... 5.42 BogoMIPS
max low pfn is   FE3000
VMALLOC_START is 810e4000
vmallocmap_base is 8020FE18, sbr 801EE198, diff  10E4000
Memory: 15000k/16268k available
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
kernel_thread: calling thread function at 80100824
IO mapped phys addr iomap_base 0x20080000, 0x0001 pages at virt 0x80fe5000 (IOMAP PTE index 0x0001)
vsbus: interrupt mask 0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
kernel_thread: calling thread function at 8010d250
Starting kswapd v1.8
kernel_thread: calling thread function at 80118636
kernel_thread: calling thread function at 80120b00
kernel_thread: calling thread function at 80118790
kernel_thread: calling thread function at 80120c08
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9685kB/3228kB, 64 slots per queue
Serial driver version 5.02 (2000-08-09) with no serial options enabled
DECstation DZ serial driver version 1.02
ttyS0 at 0x80fe4000 (irq = 176, 177)
ttyS1 at 0x80fe4000 (irq = 176, 177)
ttyS2 at 0x80fe4000 (irq = 176, 177)
ttyS3 at 0x80fe4000 (irq = 176, 177)
vaxlance.c: v0.008 by Linux Mips DECstation task force + airlied@linux.ie
IO mapped phys addr iomap_base 0x200e0000, 0x0001 pages at virt 0x80fe6000 (IOMAP PTE index 0x0002)
IO mapped phys addr iomap_base 0x20090000, 0x0001 pages at virt 0x80fe7000 (IOMAP PTE index 0x0003)
Ethernet address in ROM: 08:00:2b:17:0a:7f
IO unmapping 0x0001 pages at PTE index 0x0003
Autoprobing LANCE interrupt vector... probed IRQ 148
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.2.15, my address is 192.168.2.55
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.2.15
Looking up port of RPC 100005/2 on 192.168.2.15
kernel_thread: calling thread function at 80186ef8
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 28k freed
In CHRDEV_OPEN 5 1 80151fb6
dz opening line 3
page 80042d24, num 3964 ,pte_val A4C07BE0
k_platform is 76 61 78 00
u_platform is 76 61 78 00
starting thread    14B10 7FFFFF80 80051F50


BusyBox v0.51 (2001.06.16-11:59+0000) Built-in shell (lash)
Enter 'help' for a list of built-in commands.

/ # mount -t proc none /proc
/ # cat /proc/cpuinfo
cpu			: VAX
cpu type		:
cpu sidex		: 0
page size		: 4096
BogoMIPS		: 5.42
/ #



