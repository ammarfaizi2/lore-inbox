Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRKAM3w>; Thu, 1 Nov 2001 07:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278871AbRKAM3n>; Thu, 1 Nov 2001 07:29:43 -0500
Received: from mout0.freenet.de ([194.97.50.131]:35026 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S278887AbRKAM31>;
	Thu, 1 Nov 2001 07:29:27 -0500
Message-ID: <3BE13FF0.809@athlon.maya.org>
Date: Thu, 01 Nov 2001 13:28:32 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [VM Kernel 2.4.13] Congratulation - first time, backup has been working without break
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I'm very glad of VM in kernel 2.4.13. It was the first time today, that 
my backup run without any problem and without massive caching on the 
backup-Server (only about 10MB during KDE2-session with konqueror, 
knode, ...) . Working parallel with other applications has acceptable 
performance.

Comparison with 2.4.13-ac4:
Nearly the same programs running in background, the backup break down 
after about 60s of getting datas via ethernet. At this point, the swap 
has been grown over 56Mb!! Normally (= if the backup runs to the end at 
the second or third try), 300MB swap weren't enough. Working with other 
applications is impossible or painful.


I do my backups of the whole harddisks (all in one over 20 GB) with 
rsync (of remote machines too) to another HD on the desktop, which is 
only used for these backups.


My system:
backup-server (also desktop): 512 MB RAM, usually 256 MB cache, Athlon 
800 with 2 UDMA4-disks (20 and 45GB).

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
[Apollo Super AC97/Audio] (rev 20)
00:08.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 02)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF


Unfortunately, there is one great (old) problem with any 
2.4.x-vanilla-kernel, which isn't fixed until today and which prevents 
me of using the vanilla kernel:
Usually after some restarts of the X-sserver (4.x.y), my screen (not the 
monitor itself; no sleep-modus is shown) is beginning to go off and on 
again (when the mouse is moved) within seconds. You can't get rid of it 
by restarting X - you have to reboot the machine.
This problem doesn't occur with ac-kernels.
I'm using DRI - but without DRI, the problem doesn't disappear :-(. I'm 
using no energy-safing modes - and nothing is configured or compiled 
thereto.


Regards,
Andreas Hartmann

