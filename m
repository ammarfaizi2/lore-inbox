Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbUCZISx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbUCZISx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:18:53 -0500
Received: from mail.renesas.com ([202.234.163.13]:57998 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263925AbUCZISr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:18:47 -0500
Date: Fri, 26 Mar 2004 17:18:40 +0900 (JST)
Message-Id: <20040326.171840.498875965.takata.hirokazu@renesas.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] m32r - Linux/M32R 2.6.4 kernel
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I would like to announce the latest 2.6.4 kernel release for 
the Renesas M32R processor.

Patch information to the stock 2.6.4 kernel is placed as follows:
- m32r architecture dependent portions (arch/m32r, include/asm-m32r)
  http://www.linux-m32r.org/public/linux-2.6.4_m32r_20040326.arch-m32r.patch
- architecture independent portions for the m32r
  http://www.linux-m32r.org/public/linux-2.6.4_m32r_20040326.patch

  # Thanks to Naoto Sugai, Hitoshi Yamamoto and Hayato Fujiwara 
  # for their contributions.  :-)

Regards,
---
Hirokazu Takata,  
Linux/M32R Project: http://www.linux-m32r.org/


P.S.  Here is a boot log message:
- Kernel: 2.6.4-m32r with SMP support and preemtible kernel feature.
- Platform: M3T-M32700UT evaluation board
- Root filesystem: NFSroot boot using a root filesystem based on 
  a Debian GNU/Linux distribution.

---
Linux version 2.6.4 (takata@pcepx10) (gcc version 3.2.3 m32r-20040126) #4 SMP Fri Mar 26 15:42:52 JST 2004
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 128
  DMA zone: 128 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 2 zonelists
Kernel command line: console=ttyD0,115200n8x root=/dev/nfsroot nfsroot=192.168.0.1:/project/m32r-linux/export/root.dev nfsaddrs=192.168.0.101:192.168.0.1:192.168.0.1:255.255.255.0:mappi001 
Initializing CPU#0
PID hash table entries: 64 (order 6: 512 bytes)
Timer start : latch = 3906
Memory: 30836k/33288k available (1524k kernel code, 2372k reserved, 245k data, 72k init)
Calibrating delay loop... 176.53 BogoMIPS
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
M32R-mp information
  On-chip CPUs : 2
  CPU model : M32R-MP 012U2/CHAOS(Ver.)
CPU present map : 3
Booting processor 1/1
Waiting for send to finish...
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
+After Startup.
Before Callout 1.
After Callout 1.
OK.
Boot done.
Calibrating delay loop... 176.53 BogoMIPS
Brought up 2 CPUs
CPU#0 : CPU clock 200.00MHz, Bus clock 50.00MHz, loops_per_jiffy[882688]
CPU#1 : CPU clock 200.00MHz, Bus clock 50.00MHz, loops_per_jiffy[882688]
Before bogomips.
Total of 2 processors activated (353.07 BogoMIPS).
Before bogocount - setting activated=1.
NET: Registered protocol family 16
Linux Kernel Card Services
  options:  none
CF: Card is detected at socket 0 : stat = 0x00000001
  m32r_cfc pcc at 0x00000000
ds1302: Set PLD_RTCBAUR = 25
ds1302: RTC found.
rtc_time        : 16:14:36
rtc_date        : 2004-03-26
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Serial: M32R PLDSIO driver $Revision: 1.4 $ IRQ sharing disabled
ttyD0 at I/O 0x4c20000 (irq = 80) is a M32RPLDSIO
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
SMSC LAN91C111 Driver (v2.0), (Linux Kernel 2.4 + Support for Odd Byte) 09/24/01 -      by Pramod Bhardwaj (pramod.bhardwaj@smsc.com)

eth0: SMC91C11xFD(rev:1) at 0x300 IRQ:129 MEMSIZE:8192b NOWAIT:0 ADDR: 08:00:70:25:b0:b1 
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: PHY=LAN83C183 (LAN91C111 Internal)
IP-Config: Complete:
      device=eth0, addr=192.168.0.101, mask=255.255.255.0, gw=192.168.0.1,
     host=mappi001, domain=, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (nfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 72k freed
INIT: version 2.85 booting
Creating extra device nodes...done.  
Started device management daemon v1.3.25 for /dev
Starting Bootlog daemon: bootlogd.
Activating swap.
Calculating module dependencies... done.
Loading modules...
All modules loaded.
Setting kernel variables..
Mounting local filesystems...
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
Cleaning: /etc/network/ifstate.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Starting portmapper... Mounting remote filesystems...
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
INIT: Entering runlevel: 2
Starting HTTP server: Boa.
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd.
Starting periodic command scheduler: cron.
Stopping Bootlog daemon: bootlogd.

Debian GNU/Linux testing/unstable mappi001 ttyD0

mappi001 login: 


