Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269439AbTGJQfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbTGJQfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:35:20 -0400
Received: from station.mywwwserver.com ([66.78.4.160]:25282 "EHLO
	station.mywwwserver.com") by vger.kernel.org with ESMTP
	id S269439AbTGJQfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:35:07 -0400
Message-ID: <3F0D99A9.5010800@colenielsen.com>
Date: Thu, 10 Jul 2003 10:51:53 -0600
From: Cole Nielsen <cole@colenielsen.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intel-based motherboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - station.mywwwserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - colenielsen.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -=-
   I know it's considered poor practice to just post to a list but I 
have a question which I and others have been unable to solve relating to 
the chipset on my motherboard.
   I have an Intel 845PE-based motherboard in my Dell 4550 purchased 
last May. I've been running LINUX on it for about 2 months now and I 
like it a lot. Interestingly enough, even with DMA enabled, performance 
from the HD, CD-ROM, and CD-RW sucks! For example... writing a 650M CD 
takes nearly 45 minutes on my 40x burner. Copying a few hundred meg of 
data from one partition to another on the HD took nearly an hour and a 
half. When I try to watch a DivX movie or one of the movies for q3 or 
Diablo 2, they skip and get out of synch. I've included some information 
about my system which may be of help.

==== /sbin/lspci ====
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 
MX420] (rev a3)
02:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
02:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
02:01.0 Communication controller: Conexant HSF 56k Data/Fax/Voice/Spkp 
Modem (rev 01)
02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
02:02.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 0a)
02:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)

==== dmesg | grep ide ====
ide-floppy driver 0.99.newide
reiserfs: checking transaction log (ide0(3,1)) for (ide0(3,1))
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
ide-scsi: hdd: unsupported command in request queue (0)
Linux video capture interface: v1.00
bttv0: registered device video0

Dell Dimension 4550
512M RAM
3.06Ghz
80G HD
SuSE 8.1
50x CD-ROM
40x52x40 burner


again, I post to the list as a last resort because if I can't get this 
working, I'll have to return to using m$ software. Thanks in advance for 
any help!

Cole Nielsen

