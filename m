Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTK3SR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTK3SR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:17:57 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:5613 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S262330AbTK3SRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:17:55 -0500
Message-ID: <3FCA356A.6050003@tin.it>
Date: Sun, 30 Nov 2003 19:22:34 +0100
From: Marcello <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.5) Gecko/20031031
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.23] IPv6 creates errors on my ethernet device
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all ,

I have an ethernet card with a Realtek 8139C chip , and I've enabled 
IPv6 in my kernel  (2.4.23)

My ethernet card is connected to an ADSL Modem , an Ericsson HM220dp, 
and every (appoximatly)  50000 packets transmitted/recived by the 
devices ,if IPv6 is enabled , ifconfig reports an error in RX packages :

bash-2.05b# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:E0:7D:D5:0C:ED
          inet6 addr: fe80::2e0:7dff:fed5:ced/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:95734 errors:1 dropped:0 overruns:0 frame:0
          TX packets:101956 errors:0 dropped:0 overruns:0 carrier:0
          collisions:465 txqueuelen:1000
          RX bytes:24717818 (23.5 Mb)  TX bytes:52543424 (50.1 Mb)
          Interrupt:17 Base address:0x5f00
 
The modem is connected at 10Mbps speed Half-Duplex .

If I disable IPv6 I don't see errors on the ethernet device , I've tried 
until 1500000 packets without errors .

What cause those errors? The only solution is disable IPv6?? I've found 
this problem on 2.4.22 too (I haven't tried IPv6 on previous kernels)

Thanks

Marcello

