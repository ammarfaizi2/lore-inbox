Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135796AbRDYDy0>; Tue, 24 Apr 2001 23:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135799AbRDYDyG>; Tue, 24 Apr 2001 23:54:06 -0400
Received: from smtp.networkusa.net ([216.162.106.18]:31246 "EHLO
	smtp.networkusa.net") by vger.kernel.org with ESMTP
	id <S135796AbRDYDyB>; Tue, 24 Apr 2001 23:54:01 -0400
Message-ID: <3AE64A60.7FD6CFBB@networkusa.net>
Date: Tue, 24 Apr 2001 22:54:08 -0500
From: Ian Zink <zforce@networkusa.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TULIP driver broken
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well it would appear the tulip driver regressed from 2.4.2-ac22 and
2.4.3. (2.4.3-ac12 isn't working either) Once again, my tulip card just
spews carrier errors and doesn't even get a link light.

If someone could point me to a patch I would appreciate it. I have
attached any pretient information below.


Thanks, Ian Zink


Linux zforce 2.4.3-ac12 #5 Tue Apr 24 02:49:03 CDT 2001 i686 unknown

  Bus  0, device  11, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet]
 (rev 32).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=40.
      I/O at 0xb000 [0xb07f].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe080007f].

eth0      Link encap:Ethernet  HWaddr 00:00:C0:41:99:E9
          inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:243 dropped:0 overruns:0 carrier:243
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:10 Base address:0xb000

Linux version 2.4.3-ac12 (root@zforce) (gcc version 2.95.4 20010319
(Debian prer
elease)) #5 Tue Apr 24 02:49:03 CDT 2001
....

Linux Tulip driver version 0.9.14e (April 20, 2001)
PCI: Found IRQ 10 for device 00:0b.0
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
00:0b.0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
00:0b.0:  Advertising 0001 on PHY 3, previously advertising 01e1.
00:0b.0:  Advertising 0001 (to advertise is 0001).
eth0: Digital DS21140 Tulip rev 32 at 0xb000, 00:00:C0:41:99:E9, IRQ 10.



