Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbQJ0KiQ>; Fri, 27 Oct 2000 06:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQJ0KiG>; Fri, 27 Oct 2000 06:38:06 -0400
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:16388 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S129155AbQJ0Khx>; Fri, 27 Oct 2000 06:37:53 -0400
Date: Fri, 27 Oct 2000 11:37:52 +0100 (BST)
From: Tim <tim@parrswood.manchester.sch.uk>
To: linux-kernel@vger.kernel.org
Subject: Reboot problems with test9 on SiS5582
Message-ID: <Pine.LNX.4.21.0010271125180.26729-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I run "/sbin/shutdown -r now" on a SiS5582 based system with a Cyrix
MII cpu, the machine shuts down as far printing: Rebooting system. It then
hangs. This is a RedHat 7.0 based system (The kernel was compiled with
RedHat 6.2)

The lspci on the system gives:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 10)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 68)

The machines reboots fine with the shipped RedHat kernel (patched 2.2.16)

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X   
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
                                   ^^-^^

"While preceding your entrance with a grenade is a good tactic in
   Quake, it can lead to problems if attempted at work." -- C Hacking

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
