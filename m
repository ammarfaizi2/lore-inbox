Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293002AbSCJKBm>; Sun, 10 Mar 2002 05:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293007AbSCJKBd>; Sun, 10 Mar 2002 05:01:33 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:9385 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S293002AbSCJKBS>; Sun, 10 Mar 2002 05:01:18 -0500
Message-Id: <200203101001.LAA14981@cave.bitwizard.nl>
Subject: kswapd ooopsed. 
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Mar 2002 11:01:15 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I'll see if I can find the "magic" anywhere on the disk....

I'm reading 4 160G disks, hda...hdd, at about 24M per second per disk.
After about 170G kswapd bombed out on me with an oops.  I'm hoping it
will continue to work until I finish reading the whole disk. The
machine doesn't have swap, and 1G of RAM.

It's a dual athlon, but I haven't gotten around to compiling an SMP
kernel due to other problems. 

My personal priority is currently of getting that machine up, but
should I suspect hardware problems?


00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
00:09.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02)
00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 04)
01:05.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)

The disks are on the internal IDE controller, not on the Promise. 

	Roger. 

(I Just realized it has an AMD chipset. I somehow remembered seeing
something about VIA... Phew.)

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
