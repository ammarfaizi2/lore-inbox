Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWDQHC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWDQHC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 03:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDQHC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 03:02:57 -0400
Received: from host242-26.pool8261.interbusiness.it ([82.61.26.242]:54022 "EHLO
	mail.zambrini.it") by vger.kernel.org with ESMTP id S1750713AbWDQHC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 03:02:56 -0400
Message-ID: <001801c661ec$f1113250$eeeea8c0@zibriw>
From: "Zibri" <zibri@worldonline.it>
To: <linux-kernel@vger.kernel.org>
Subject: GPL Violation: TELSEY
Date: Mon, 17 Apr 2006 09:02:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telsey Spa violated *again* the GPL...

It's TELSEY MAGIC adsl2 router it's like the USRobotics 9105/9106/9107/9108 
and they are based on BROADCOM boards.

TELSEY MAGIC is based on the bcm96348 board and it uses LINUX (kernel 
2.6.8.1) and MANY GPL'ed programs...

If you open one of theese jewels, you find a 4 pin header.... simple as it 
seems it's GND, RX, TX, VCC (3.3v).

Attach a simple MAX232 and connect that header to a pc serial port. Switch 
the router ON and you will see:

Booting from latest image (0xc0000000) ...
Code Address: 0x80010000, Entry Address: 0x80199018
Decompression OK!
Entry at 0x80199018
Closing network.
Starting program at 0x80199018
Linux version 2.6.8.1 (carpao@Carpao_lab) (gcc version 3.4.2) #1 Wed Dec 21 
12:40:40 CET 2005
Parallel flash device: name MX29LV640T, id 0x22c9, size 8192KB
Total Flash size: 8192K with 135 sectors
MAGIC prom init
CPU revision is: 00029107
Determined physical RAM map:
 memory: 00fa0000 @ 00000000 (usable)
On node 0 totalpages: 4000
  DMA zone: 4000 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=31:0 ro noinitrd
brcm mips: enabling icache and dcache...
Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB 2-way, linesize 16 bytes.
PID hash table entries: 64 (order 6: 512 bytes)
Using 128.000 MHz high precision timer.
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 14044k/16000k available (1364k kernel code, 1936k reserved, 204k 
data, 72k init, 0k highmem)
Calibrating delay loop... 254.77 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
Can't analyze prologue code at 80163844
PPP generic driver version 2.4.2
NET: Registered protocol family 24
Using noop io scheduler
bcm963xx_mtd driver v1.0
bcm963xx_mtd: rootfs_addr = 0xBF800100, kernel_addr = 0xBFAAE100
brcmboard: brcm_board_init entry
Confirm button interrupt has been configured
bcm963xx_serial driver v2.0
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
NET: Registered protocol family 1
NET: Registered protocol family 17
Ebtables v2.0 registered
NET: Registered protocol family 8
NET: Registered protocol family 20
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 72k freed
init started:  BusyBox v1.00 (2005.12.21-11:46+0000) multi-call binary
Algorithmics/MIPS FPU Emulator v1.5


BusyBox v1.00 (2005.12.21-11:46+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.


Loading drivers and kernel modules...

atmapi: module license 'Proprietary' taints kernel.
blaadd: blaa_detect entry
adsl: adsl_init entry
Broadcom BCMPROCFS v1.0 initialized
Broadcom BCM6348A2 Ethernet Network Device v0.3 Dec 21 2005 12:39:20
Config Internal PHY Through MDIO
BCM63xx_ENET: 100 MB Full-Duplex (auto-neg)
eth0: MAC Address: 00:03:6F:13:20:48
Broadcom BCM6348A2 Ethernet Network Device v0.3 Dec 21 2005 12:39:20
Config External PHY Through MDIO
eth0 Link UP.
BCM63xx_ENET: Auto-negotiation timed-out
BCM63xx_ENET: 10 MB Half-Duplex (assumed)
eth1: MAC Address: 00:03:6F:13:20:49
Telsey BCM6348A2 USB Network Device v0.4 Dec 21 2005 12:39:23
usb0: MAC Address: 00 03 6F 13 20 4A
usb0: Host MAC Address: 00 03 6F 13 20 4B
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:01.0 (0004 -> 0006)
wl0: Broadcom BCM4318 802.11 Wireless Controller 3.131.35.0.cpe0.0a
dgasp: kerSysRegisterDyingGaspHandler: wl0 registered
Telsey smart card: tda8007_module_init
tda8007: Found TDA 8007BHL/C2
wlctl: wlctl: smartcardmngr:Initializing SmartCardMngr
smartcardmngr:SMART CARD INSERTED


Obviously they don't release the (modified) source code, nor broadcom does.

Lately a few telcos are adopting similar products...

T-Online for example is releasing the source code here: 
http://www.telekom.de/dtag/downloads/b/bcm963xx_SpeedportW500V.01.2.01L.300L01.V27_cons_rel.tar.gz

This one is *very* similar to TELSEY MAGIC... infact i can successfully 
compile a firmware...

However... things don't end here... TELSEY is selling the product to italian 
TELECOM ITALIA (www.telecomitalia.it) for ADSL2 broadband and IPTV.

The IPTV module uses linux too.. and obviously nor TELSEY nor TELECOM nor 
BROADCOM are releasing the source codes..

Please if you can... do something.

I emailed telsey asking for sources... they told me they only deal with 
TELECOM ITALIA....

I emailed again yesterday, telling them they are violating GPL. Let's see 
what they will answer...



