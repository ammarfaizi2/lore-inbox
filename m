Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275131AbRIYRm3>; Tue, 25 Sep 2001 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275135AbRIYRmT>; Tue, 25 Sep 2001 13:42:19 -0400
Received: from rj.sgi.com ([204.94.215.100]:22958 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275132AbRIYRmL>;
	Tue, 25 Sep 2001 13:42:11 -0400
From: Jens Petersohn <jkp@sgi.com>
Message-ID: <XFMail.20010925124235.jkp@sgi.com>
X-Mailer: XFMail 1.5.0 on IRIX
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 25 Sep 2001 12:42:35 -0500 (CDT)
Organization: SGI, Inc.
To: linux-kernel@vger.kernel.org
Subject: protocol is buggy?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

getting the following in dmesg. Don't know if it's iptables related or
not. The ethernet card in question is a Intel EtherPRO 100 with the
stock 2.4.8 driver. Everything is working great, but I'm mostly
curious why these messages appear. A search in Google or LKM 
didn't turn anything immidiately, but I might have missed something.

protocol 0008 is buggy, dev eth1
protocol 0008 is buggy, dev eth1
protocol 0008 is buggy, dev eth1
protocol 0008 is buggy, dev eth1
NET: 16 messages suppressed.
protocol 0008 is buggy, dev eth1

/proc/pci:
  Bus  0, device  19, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 2).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xe4100000 [0xe4100fff].
      I/O at 0x7400 [0x741f].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe40fffff].

The card in question is the "public/internet" side of the firewall.
There are two additional interfaces, eth0 (private ethernet) and eth2,
a radio LAN.

Thanks,

Jens Petersohn
-- 
      Apple OS X Public Beta is not intended for use in the operation of
      nuclear facilities, aircraft navigation or communication systems,
      air traffic control systems, life support machines or other equipment
      in which the failure of the Apple Software could lead to death,
      personal injury, or severe physical or environmental damage.

