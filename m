Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289970AbSAKOyC>; Fri, 11 Jan 2002 09:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289972AbSAKOxw>; Fri, 11 Jan 2002 09:53:52 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:61631 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289970AbSAKOxk>; Fri, 11 Jan 2002 09:53:40 -0500
Date: Fri, 11 Jan 2002 16:53:18 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <jim@federated.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re:  Problem with ServerWorks CNB20LE and lost interrupts
Message-ID: <Pine.LNX.4.33.0201111650370.17814-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

00:00.0 Host bridge: ServerWorks CNB20LE (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE (rev 05)
00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
00:0a.0 Network controller: Penta Media Co Ltd: Unknown device 9050 (rev
02)
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
00:0f.1 IDE interface: ServerWorks: Unknown device 0211
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)
01:03.0 SCSI storage controller: Adaptec 7892P (rev 02)
01:05.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
01:06.0 Network controller: Penta Media Co Ltd: Unknown device 9050 (rev
02)
01:07.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 02)
01:07.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev
02)

           CPU0       CPU1
  0:   70930979          0          XT-PIC  timer
  1:      19222          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0          XT-PIC  rtc
 10:   24926906          0          XT-PIC  eth0
 11:   86480614          0          XT-PIC  dpti0, pentanet0
 14:        118          0          XT-PIC  ide0
 15:    2041588          0          XT-PIC  eth1
NMI:          0          0
LOC:   70931368   70931502
ERR:          0

What does your /proc/interrupts look like?

Regards,
	Zwane Mwaikambo

