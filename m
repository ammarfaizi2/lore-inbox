Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTAQD4Q>; Thu, 16 Jan 2003 22:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTAQD4P>; Thu, 16 Jan 2003 22:56:15 -0500
Received: from mail.ifip.com ([63.113.106.66]:30184 "EHLO mail.ifip.com")
	by vger.kernel.org with ESMTP id <S267236AbTAQD4M>;
	Thu, 16 Jan 2003 22:56:12 -0500
Message-ID: <3E278107.1030802@markerman.com>
Date: Thu, 16 Jan 2003 23:05:27 -0500
From: Byron Albert <byron@markerman.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hw tcp v4 csum failed ????
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

 I just got a new machine in production as a web server and I am getting 
lots of "hw tcp v4 csum failed" about 1 a min.  Have tryed 2.4.20 and 
2.4.21pre3. I have another idental machine running with out this issue.
from dmesg
tg3.c:v1.2a (Dec 9, 2002)
eth0: Tigon3 [partno(TBD) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 
10/100/1000BaseT Ethernet from /proc/pci
  Bus  2, device   1, function  0:
    Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit 
Ethernet (rev 2).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=64.
      Non-prefetchable 64 bit memory at 0xf7ef0000 [0xf7efffff].

This sounds very bad can some one explane what it means and how to get 
rid of it. Also could it be caused by bad arp cache?

Thanks
Byron

