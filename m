Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUF1KHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUF1KHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 06:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUF1KHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 06:07:50 -0400
Received: from web90107.mail.scd.yahoo.com ([66.218.94.78]:22383 "HELO
	web90107.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264908AbUF1KHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 06:07:44 -0400
Message-ID: <20040628100743.14712.qmail@web90107.mail.scd.yahoo.com>
Date: Mon, 28 Jun 2004 03:07:43 -0700 (PDT)
From: Deshpande M <pdspartan@yahoo.com>
Subject: Kernel freezes- Init process in console driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am porting 2.6.0 (plain vanilla kernel) on Arm926 EJ
. I can be 
able 
to succeeded in spawning init process in debugging
mode and after 
that 
my kernel gets freezed. I am attaching my kernel log
here with for 
your 
reference. I am in clueless where could i have to look
further for 
resolving this problem? I will really appreciate if
some one could 
give me 
an idea for this.
----------------------------------------------------------------------
------------------------------------------------
 
Linux version 2.6.0-rmk2 (root@localhost.localdomain)
(gcc version 
3.3.2) #208 Thu Jun 17 13:01:38 IST 2004
CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
CPU: D undefined 14 cache
CPU: I cache: 16384 bytes, associativity 4, 32 byte
lines, 128 sets
CPU: D cache: 16384 bytes, associativity 4, 32 byte
lines, 128 sets
Machine: blr
Memory policy: ECC disabled, Data cache write back
On node 0 totalpages: 4096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/ram0 rw mem=16M
initrd=0x20800000,4M 
console=ttyS0,115200 init=/bin/sh
PID hash table entries: 128 (order 7: 1024 bytes)
Memory: 16MB = 16MB total
Memory: 11116KB available (713K code, 174K data, 52K
init)
Dentry cache hash table entries: 2048 (order: 1, 8192
bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096
bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
checking if image is initramfs...it isn't (ungzip
failed); looks like 
an initrd
Freeing initrd memory: 4096K
CPU: Testing write buffer coherency: ok
POSIX conformance testing by UNIFIX
Linux NoNET1.0 for Linux 2.6
Serial: Blr driver $Revision: 1.41 $
ttyS0 at MMIO 0xf0000000 (irq = 6) is a Blr
RAMDISK driver initialized: 16 RAM disks of 8192K size
1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096 blocks [1 disk] into ram disk...
done.
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 52K
Inside run_init_process sbin/init
Inside do_execve
Inside search_binary_handler
Inside load_elf_binary
Inside data abort handler
Inside data abort handler
Inside prefetch abort handler
Inside data abort handler
Inside data abort handler
Inside prefetch abort handler
Inside prefetch abort handler
Inside prefetch abort handler
Inside data abort handler
Inside data abort handler
Inside prefetch abort handler
Inside prefetch abort handler
Inside prefetch abort handler
Inside prefetch abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside prefetch abort handler
Inside prefetch abort handler
Inside data abort handler
Inside prefetch abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
Inside data abort handler
----------------------------------------------------------------------
---------------------
thanks in advance.
 
Deshpande



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
