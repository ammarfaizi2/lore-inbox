Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbTCQPmk>; Mon, 17 Mar 2003 10:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCQPmk>; Mon, 17 Mar 2003 10:42:40 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:45000 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S261755AbTCQPmh>; Mon, 17 Mar 2003 10:42:37 -0500
Date: Tue, 18 Mar 2003 02:53:02 +1100
From: Anton Blanchard <anton@au1.ibm.com>
To: linuxppc-announce@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Linux boots on early POWER5 hardware
Message-ID: <20030317155302.GA13463@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following is one of the original boot logs for Linux on a POWER5
microprocessor. Linux was ported to POWER5 at an IBM Lab in Austin
Texas. The port was done with pre-production hardware. As such, we are
not showing BogoMIPS or frequency numbers at this time.

Regards,

    Anton Blanchard, IBM Linux Technology Centre, OzLabs
    Todd Venton, IBM POWER5 Lab
    Milton Miller II, IBM POWER5 Lab
    JT Kellington, IBM POWER5 Lab


Starting Linux PPC64 2.5.59
-----------------------------------------------------
naca                       = 0xc000000000004000
naca->physicalMemorySize   = 0x40000000
naca->dCacheL1LineSize     = 0x80
naca->dCacheL1LogLineSize  = 0x7
naca->dCacheL1LinesPerPage = 0x20
naca->iCacheL1LineSize     = 0x80
naca->iCacheL1LogLineSize  = 0x7
naca->iCacheL1LinesPerPage = 0x20
naca->pftSize              = 0x18
naca->debug_switch         = 0x0
naca->interrupt_controller = 0x0
htab_data.htab             = 0xc00000003f000000
htab_data.num_ptegs        = 0x20000
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.5.59 (anton@superego) (gcc version 3.2.2 20030117 (prerelease)) #33 Wed Feb 5 19:20:12 EST 2003
[boot]0012 Setup Arch
Boot arguments: console=hvc0 init=/bin/sh
On node 0 totalpages: 262144
  DMA zone: 262144 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
[boot]0015 Setup Done
Building zonelist for node : 0
Kernel command line: console=hvc0 init=/bin/sh
PID hash table entries: 16 (order 4: 256 bytes)
time_init: decrementer frequency = XXXXX MHz
time_init: processor frequency   = XXXXX MHz
Console: colour dummy device 80x25
Calibrating delay loop... XXXXX BogoMIPS
Memory: 1006912k available (1832k kernel code, 1732k data, 752k init) [c000000000000000,c000000040000000]
Dentry cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 65536 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
-> bin
-> bin/busybox
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: Probing PCI hardware
PCI: Probing PCI hardware done
BIO: pool of 256 setup, 24Kb (96 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (16 bytes)
biovec pool[1]:   4 bvecs: 256 entries (64 bytes)
biovec pool[2]:  16 bvecs: 256 entries (256 bytes)
biovec pool[3]:  64 bvecs: 256 entries (1024 bytes)
biovec pool[4]: 128 bvecs: 256 entries (2048 bytes)
biovec pool[5]: 256 bvecs: 256 entries (4096 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
RTAS daemon started
PPC64 nvram contains 0 bytes
aio_setup: sizeof(struct page) = 80
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Freeing unused kernel memory: 752k freed
init started:  BusyBox v0.60.3 (2003.02.05-05:30+0000) multi-call binary
device '/dev/tty2' does not exist.
device '/dev/tty3' does not exist.
Please press Enter to activate this console.
device '/dev/tty4' does not exist.
BusyBox v0.60.3 (2003.02.05-05:30+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.
#
# cat /proc/cpuinfo
processor       : 0
cpu             : POWER5
revision        : 1.0

timebase        : XXXXX
machine         : CHRP
