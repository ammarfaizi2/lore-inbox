Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131326AbRAFAeB>; Fri, 5 Jan 2001 19:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132074AbRAFAdw>; Fri, 5 Jan 2001 19:33:52 -0500
Received: from [64.16.10.150] ([64.16.10.150]:58386 "EHLO cougar.intrinsyc.com")
	by vger.kernel.org with ESMTP id <S131326AbRAFAdk>;
	Fri, 5 Jan 2001 19:33:40 -0500
Message-ID: <3A56E6FE.6F61A2C4@intrinsyc.com>
Date: Sat, 06 Jan 2001 04:35:58 -0500
From: Daniel Chemko <dchemko@intrinsyc.com>
Reply-To: dchemko@intrinsyc.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 3c59x problems on all 2.4 Kernels?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a 3Com 905C Tornado Vortex Driver and the official 2.4.0, and
the driver does not start up. I think I had the same problem with this
driver in the 2.2 kernel, which forced me to use 3com's 3c90x, which is
not available for 2.4. Below are the specs:

Sorry for not including more, info but I am leaving for home in like
30min ;)


This was what 'Messages' gave me:


Jan  5 06:32:17 cookiemonster kernel: 3c59x.c:LK1.1.11 13 Nov 2000
Donald Becker and others. http://www.scyld.com/network/vortex.html
$Revision: 1.102.2.46 $
Jan  5 06:32:17 cookiemonster kernel: See
Documentation/networking/vortex.txt
Jan  5 06:32:17 cookiemonster kernel: eth0: 3Com PCI 3c905C Tornado at
0xb800, PCI: Found IRQ 9 for device 02:0a.0
Jan  5 06:32:17 cookiemonster kernel: PCI: Setting latency timer of
device 02:0a.0 to 64
Jan  5 06:32:17 cookiemonster kernel:  00:01:03:1f:73:76, IRQ 9
Jan  5 06:32:17 cookiemonster kernel:   8K byte-wide RAM 5:3 Rx:Tx
split, autoselect/Autonegotiate interface.
Jan  5 06:32:17 cookiemonster kernel:   MII transceiver found at address
1, status   24.
Jan  5 06:32:17 cookiemonster kernel:   MII transceiver found at address
2, status   24.
Jan  5 06:32:17 cookiemonster kernel:   Enabling bus-master transmits
and whole-frame receives.
Jan  5 06:32:29 cookiemonster kernel: eth0: using NWAY autonegotiation
Jan  5 06:32:29 cookiemonster kernel: eth0: command 0x2800 did not
complete! Status=0x7000


>From lspci -vx


02:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
 Subsystem: 3Com Corporation: Unknown device 1000
 Flags: bus master, medium devsel, latency 0, IRQ 9
 I/O ports at b800
 Memory at f5000000 (32-bit, non-prefetchable)
 Capabilities: [dc] Power Management version 2
00: b7 10 00 92 17 00 10 02 78 00 00 02 08 00 00 00
10: 01 b8 00 00 00 00 00 f5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 0a 0a

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
