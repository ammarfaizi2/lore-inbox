Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbREZQg5>; Sat, 26 May 2001 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261948AbREZQgr>; Sat, 26 May 2001 12:36:47 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:36774 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S261628AbREZQgb>;
	Sat, 26 May 2001 12:36:31 -0400
Date: Sat, 26 May 2001 17:37:11 +0100 (BST)
From: Dave Gilbert <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5: Duplicate PCI devices
Message-ID: <Pine.LNX.4.10.10105261728200.750-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  (On Alpha LX164, 2.4.5,built with Gcc 3.0 from CVS and binutils 2.9.11)

This seems to be running fine, but I've noticed that 'lspci' is listing
all devices twice:

00:06.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
00:06.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 21)
00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 21)
00:08.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA
Bridge] (rev 43)
00:08.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA
Bridge] (rev 43)
00:09.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown device
0005 (rev 01)
00:09.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown device
0005 (rev 01)
00:0b.0 IDE interface: CMD Technology Inc PCI0646 (rev 01)
00:0b.0 IDE interface: CMD Technology Inc PCI0646 (rev 01)

/proc/pci seems to be only listing it once.

(dmesg on http://www.treblig.org/debug/2.4.5.dmesg )

Dave
-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

