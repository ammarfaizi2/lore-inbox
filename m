Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVAPJLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVAPJLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 04:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVAPJLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 04:11:50 -0500
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:47071 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262465AbVAPJLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 04:11:39 -0500
Message-ID: <41EA30C5.3030500@poczta.onet.pl>
Date: Sun, 16 Jan 2005 10:15:49 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 - dead keyboard
Content-Type: multipart/mixed;
 boundary="------------050208000307090007070900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208000307090007070900
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

my AT keyboard is dead on 2.6.10. .config was produced by "make
defconfig" (procesor changed to i586) - attached as gz. System works ok,
all programs run but keyboard is like unplugged (but it is plugged of
course). Here is kernel bootup:

Jan 15 20:11:02 wiktor kernel: Linux version 2.6.10 (root@wiktor.home)
(gcc version 3.3.5 (Debian 1:3.3.5-5)) #12 SMP Sat Jan 15 17:05:30 CET 2005
(...)
Jan 15 20:11:02 wiktor kernel: Kernel command line: BOOT_IMAGE=linux-new
ro root=301 atkbd.reset=1
Jan 15 20:11:02 wiktor kernel: No local APIC present or hardware disabled
Jan 15 20:11:02 wiktor kernel: Initializing CPU#0
Jan 15 20:11:02 wiktor kernel: CPU 0 irqstacks, hard=c04aa000 soft=c04a2000
Jan 15 20:11:02 wiktor kernel: PID hash table entries: 512 (order: 9,
8192 bytes)
Jan 15 20:11:02 wiktor kernel: Detected 200.479 MHz processor.
Jan 15 20:11:02 wiktor kernel: Using tsc for high-res timesource
Jan 15 20:11:02 wiktor kernel: Console: colour VGA+ 80x25
Jan 15 20:11:02 wiktor kernel: Dentry cache hash table entries: 16384
(order: 4, 65536 bytes)
Jan 15 20:11:02 wiktor kernel: Inode-cache hash table entries: 8192
(order: 3, 32768 bytes)
Jan 15 20:11:02 wiktor kernel: Memory: 92752k/98304k available (2456k
kernel code, 5140k reserved, 1044k data, 192k init, 0k highmem)
Jan 15 20:11:02 wiktor kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
Jan 15 20:11:02 wiktor kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Jan 15 20:11:02 wiktor kernel: Intel Pentium with F0 0F bug - workaround
enabled.
Jan 15 20:11:02 wiktor kernel: Checking 'hlt' instruction... OK.
Jan 15 20:11:02 wiktor kernel: CPU0: Intel Pentium 75 - 200 stepping 0c
Jan 15 20:11:02 wiktor kernel: per-CPU timeslice cutoff: 159.74 usecs.
Jan 15 20:11:02 wiktor kernel: task migration cache decay timeout: 1 msecs.
(...)
Jan 15 20:11:02 wiktor kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 15 20:11:02 wiktor kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
<- kbd port detected
Jan 15 20:11:02 wiktor kernel: Serial: 8250/16550 driver $Revision: 1.90
$ 8 ports, IRQ sharing disabled
Jan 15 20:11:02 wiktor kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan 15 20:11:02 wiktor kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jan 15 20:11:02 wiktor kernel: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
(...)
Jan 15 20:11:02 wiktor kernel: atkbd.c: keyboard reset failed on
isa0060/serio1
Jan 15 20:11:02 wiktor kernel: atkbd.c: keyboard reset failed on
isa0060/serio0 <- but keyboard IS resetted (leds flashes)
Jan 15 20:11:02 wiktor kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0

is it simple keyboard read error? (IMO keyboard gets commands - it
resets and on system reset [by shutdown] leds also blinks). I can't
determine in which kernel version this bug(?) appeared - kernel
compilation takes about 4 hours on my machine. I'm grateful for any help.

---
May the Source be with you.
Wiktor


--------------050208000307090007070900
Content-Type: application/gzip;
 name="kernel.cfg-2.4.20.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kernel.cfg-2.4.20.gz"

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
--------------050208000307090007070900--
