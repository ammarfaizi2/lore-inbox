Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUGMQEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUGMQEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUGMQEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:04:07 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:57780 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S265410AbUGMQEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:04:04 -0400
Date: Tue, 13 Jul 2004 09:38:20 -0400
From: Eric Buddington <ebuddington@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Continuing sil3112/Seagate timout/error
Message-ID: <20040713133820.GO8720@pool-141-154-182-45.wma.east.verizon.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.154.182.45] at Tue, 13 Jul 2004 11:04:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading my systme to 2.6.7-bk19 (which does have Jeff Garzik's
recent fixes, right?), I am still seeing

-----------------------------------
ata1: command 0x25 timeout, stat 0x58 host_stat 0x1
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 c7 4d 67 00 00 08 00 
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 13061479
ATA: abnormal status 0x58 on port 0xCF819087
ATA: abnormal status 0x58 on port 0xCF819087
ATA: abnormal status 0x58 on port 0xCF819087
-----------------------------------

and once a string of reiserfs errors (refuted subsequently by reiserfs, which found the system clean).

Some of my PCI devices:
-----------------------------------
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
00:10.0 RAID bus controller: CMD Technology Inc: Unknown device 3112 (rev 02)
-----------------------------------

And my hard drive is a ST3160023AS.

-Eric
