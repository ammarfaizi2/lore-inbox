Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVBPUuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVBPUuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVBPUuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:50:24 -0500
Received: from [64.4.37.24] ([64.4.37.24]:61733 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261870AbVBPUuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:50:04 -0500
Message-ID: <BAY10-F2463631423ADD0786503EAD66C0@phx.gbl>
X-Originating-IP: [61.247.245.18]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Customized 2.6.10 kernel on a Compact Flash
Date: Thu, 17 Feb 2005 02:18:13 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Feb 2005 20:49:01.0503 (UTC) FILETIME=[F1C0DCF0:01C51468]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are trying to build a customized kernel image from the stable 2.6.10 
kernel release (in kernel.org). We have not applied any kernel patches on 
this released version. We are trying to boot this custom image onto a 
compact flash (from Toshiba) in a embedded board (AMD processor with 64 MB 
RAM). While the kernel is coming up during the boot process, it panics and 
the console output is as follows:

-----------------------------------------

Memory: 60648k/65536k available (2443k kernel code, 4412k reserved, 691k 
data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: AMD 486 DX/4-WB stepping 04
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 294k freed
Linux NoNET1.0 for Linux 2.6
PCI: PCI BIOS revision 2.00 entry at 0xf7861, last bus=2
PCI: Using configuration type 1
Linux Kernel Card Services
  options:  [pci] [cardbus]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
scx200: NatSemi SCx200 Driver
audit: initializing WITHOUT netlink support
audit(315837483.464:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.22 [Flags: R/W DEBUG].
QNX4 filesystem 0.2.3 registered.
SGI XFS with ACLs, security attributes, large block numbers, no debug 
enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
SyncLink PC Card driver $Revision: 4.26 $
SyncLink PC Card driver $Revision: 4.26 $, tty major#253
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 4 RAM disks of 10240K size 1024 blocksize
loop: loaded (max 8 devices)
PS2ESDI: error initialising device, releasing resources
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA THNCF128MMA, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 250368 sectors (128 MB) w/2KiB Cache, CHS=978/8/32
hda: hda1
mice: PS/2 mouse device common for all mice
Freeing unused kernel memory: 128k freed
Kernel panic - not syncing: Attempted to kill init!

----------------------------------------------------------------------------

Are there any known issues in building this kernel version on a Compact 
Flash? Request your inputs/suggestions to overcome this problem that we are 
facing.

Thanks in advance for your time and inputs,

Govind

_________________________________________________________________
65,000 jobs listings. http://www.naukri.com/tieups/tieups.php?othersrcp=534 
Post your CV on Naukri.com today.

