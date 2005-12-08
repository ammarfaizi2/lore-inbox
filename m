Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVLHBgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVLHBgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 20:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVLHBgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 20:36:32 -0500
Received: from gambit.vianw.pt ([195.22.31.34]:5065 "EHLO gambit.vianw.pt")
	by vger.kernel.org with ESMTP id S932260AbVLHBgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 20:36:31 -0500
Message-ID: <43978E04.7030000@esoterica.pt>
Date: Thu, 08 Dec 2005 01:36:04 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org
Subject: STILL Cannot run linux 2.6.14.3 UML on a x86_64
References: <43924B2C.9000300@esoterica.pt> <20051204043205.GA15425@ccure.user-mode-linux.org> <43926CC8.2030902@esoterica.pt> <20051204162732.GA3692@ccure.user-mode-linux.org>
In-Reply-To: <20051204162732.GA3692@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

>On Sun, Dec 04, 2005 at 04:12:56AM +0000, Paulo da Silva wrote:
>  
>
> ...
>
>It works.  I have never really tested tt mode on x86_64.
>
>  
>
Cannot get it running !!!
It stops, consuming variable amounts of cpu.
The same configuration works perfectly on a 32 bits system.

Here is the console output.

Checking PROT_EXEC mmap in /tmp...OK
Checking for /proc/mm...not found
Checking for the skas3 patch in the host...not found
UML running in SKAS0 mode
[42949372.960000] Checking that ptrace can change system call numbers...OK
[42949372.960000] Checking syscall emulation patch for ptrace...missing
[42949372.960000] Linux version 2.6.14.3 (psergio@Gandalf) (gcc version 
3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 Thu Dec 8 01:13:35 
WET 2005
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ubd0=/VMs/UML/UML1 mem=250M 
eth0=tuntap,,,192.168.1.100 root=98:0
[42949372.960000] PID hash table entries: 1024 (order: 10, 32768 bytes)
[42949372.960000] Dentry cache hash table entries: 32768 (order: 6, 
262144 bytes)
[42949372.960000] Inode-cache hash table entries: 16384 (order: 5, 
131072 bytes)
[42949372.960000] Memory: 243712k available
[42949373.180000] Mount-cache hash table entries: 256
[42949373.180000] Checking that host ptys support output SIGIO...Yes
[42949373.180000] Checking that host ptys support SIGIO on close...No, 
enabling workaround
[42949373.180000] Checking for /dev/anon on the host...Not available 
(open failed with errno 2)
[42949373.180000] softlockup thread 0 started up.
[42949373.180000] Using 2.6 host AIO
[42949373.180000] NET: Registered protocol family 16
[42949373.180000] mconsole (version 2) initialized on 
/home/psergio/.uml/Pulga/mconsole
[42949373.180000] Netdevice 0 : TUN/TAP backend - IP = 192.168.1.100
[42949373.180000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[42949373.180000] Initializing Cryptographic API
[42949373.230000] io scheduler noop registered
[42949373.230000] io scheduler anticipatory registered
[42949373.230000] io scheduler deadline registered
[42949373.230000] io scheduler cfq registered
[42949373.230000] RAMDISK driver initialized: 16 RAM disks of 4096K size 
1024 blocksize
[42949373.250000] loop: loaded (max 8 devices)
[42949373.250000] NET: Registered protocol family 2
[42949373.390000] IP route cache hash table entries: 2048 (order: 2, 
16384 bytes)
[42949373.390000] TCP established hash table entries: 8192 (order: 4, 
65536 bytes)
[42949373.390000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[42949373.390000] TCP: Hash tables configured (established 8192 bind 8192)
[42949373.390000] TCP reno registered
[42949373.390000] TCP bic registered
[42949373.390000] NET: Registered protocol family 1
[42949373.390000] NET: Registered protocol family 17
[42949373.390000] NET: Registered protocol family 15
[42949373.390000] Initialized stdio console driver
[42949373.390000] Console initialized on /dev/tty0
[42949373.390000] Initializing software serial port version 1
[42949373.390000]  ubda: unknown partition table
[42949373.390000] VFS: Mounted root (ext2 filesystem) readonly.
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c

