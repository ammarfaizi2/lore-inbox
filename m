Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbRCEV0G>; Mon, 5 Mar 2001 16:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130683AbRCEVZ4>; Mon, 5 Mar 2001 16:25:56 -0500
Received: from sun1.udg.es ([130.206.45.89]:43240 "EHLO sun1.udg.es")
	by vger.kernel.org with ESMTP id <S130682AbRCEVZo>;
	Mon, 5 Mar 2001 16:25:44 -0500
Date: Mon, 5 Mar 2001 22:25:46 +0000 (WET)
From: Tania Gomes Ramos <tgomesr@silver.udg.es>
To: <linux-kernel@vger.kernel.org>
Subject: problems installing the kernel 2.4 (fwd)
Message-ID: <Pine.GSO.4.31.0103052224570.29920-100000@silver.udg.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   First of all, thanks for helping me...
   I have noticed that after I have installed the new version
 of kernel (2.4.2),I am having some problems... After compiling
everything, and making the make install_modules, I have the message that
there is nothing to be done in the directories... But, ok, it creates
the modules directorie. But...
   First of all,
 1)  -- now, trying to acess the network is impossible ... the
ifconfig just shows "lo"  and the ethernets no... but, they were
configured in the lilo in the same way they were configured with
the old kernel. You can see the configuration in the lilo:
(there are two partitions, and I have installed the new kernel in
the partition altres)

image= ../boot/vmlinuz.ip6
         label=lr
         append ="ether=5,0x300,eth0 ether=10, 0x210, eth1"
         initrd=..boot/initrd-2.2.12-20.img
         root=/dev/hda1
         read-only

image= ../boot/vmlinuz-2.4.2
         label=altres
         append ="ether=5,0x300,eth0 ether=10, 0x210, eth1"
         #initrd=..boot/initrd-2.2.12-20.img
         root=/dev/hdc1
         read-only

Well, I put a comment in front of initrd because I didnt find
this file *.img of the new kernel...

I havent changed anything else, and my computer cant see the
network in the partition altres, but in the other one,it is
 possible.

2)The other problem is:
    After installing it, this partition (the only one which
has version 2.4) cant reboot or halt. It starts to do that,
but it always stops at the message:
INIT: there is no more process left in this runlevel.
 so,I always have to reset the computer...

Do you know why it is happening? And what could I do to fix it??

Thank you,
Tania Ramos




