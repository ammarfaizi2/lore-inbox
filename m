Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRHKPF2>; Sat, 11 Aug 2001 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268079AbRHKPFS>; Sat, 11 Aug 2001 11:05:18 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:29570 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S268017AbRHKPFJ>;
	Sat, 11 Aug 2001 11:05:09 -0400
Date: Sat, 11 Aug 2001 19:08:17 +0400
From: s0mbre <johnpol@2ka.mipt.ru>
X-Mailer: The Bat! (v1.39) Educational
Reply-To: s0mbre <johnpol@2ka.mipt.ru>
X-Priority: 3 (Normal)
Message-ID: <8797.010811@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: [insmod don't work corrctly] /dev/hands damaged system
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, linux guru.

After recompiling -ac1( and -ac10, and -ac9, and -ac7) with
gcc-2.95.2( instead of 3.0 that doesn't work in principle), i collide
with strange behavior of lsmod:

[root@Sombre s0mbre]# insmod /lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol __kfree_skb
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol ether_setup
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol kmalloc
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol unregister_netdev
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol register_netdev
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol dev_alloc_name
/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol kfree
[root@Sombre s0mbre]#
  
Where can i miss a sufficient thing?


Thanks in advance for your help and advices.

---
WBR. //s0mbre


