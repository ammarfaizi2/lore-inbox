Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSANPff>; Mon, 14 Jan 2002 10:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSANPfb>; Mon, 14 Jan 2002 10:35:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S286935AbSANPev>; Mon, 14 Jan 2002 10:34:51 -0500
Date: Mon, 14 Jan 2002 10:34:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: initrd failure on Linux-2.4.17
Message-ID: <Pine.LNX.3.95.1020114103203.216A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am still trying to get linux-2.4.17 (the last stable version)
to boot using initrd.

I have hand copied the kernel messages and they follow:

Based upon Swansea Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Detected PS/2 Mouse Port
pty: 256 Unix/98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximumm main memory to use for agp memory: 262M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32767 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 581k freed
kernel panic: VFS: Unable to mount root fs on 01:00

Note that the compressed image was found, but Linux promptly
freed initrd memory, which should surely make it "un-found".
Then, true to form, the ramdisk image can't be mounted as
the root file-system.

Has somebody fixed this or is it expected that nobody uses
an initial RAM disk on 2.4.17 ..or.. is this not the latest
"stable" version of Linux to use?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


