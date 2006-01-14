Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWANIye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWANIye (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 03:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWANIye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 03:54:34 -0500
Received: from bay17-f29.bay17.hotmail.com ([64.4.43.79]:58131 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750740AbWANIyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 03:54:33 -0500
Message-ID: <BAY17-F29079CAE51CD9B122B8FC997190@phx.gbl>
X-Originating-IP: [203.197.150.66]
X-Originating-Email: [ratheesh.ksz@hotmail.com]
From: "Ratheesh k" <ratheesh.ksz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: change eth0 to sn0        ? 
Date: Sat, 14 Jan 2006 14:24:33 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 14 Jan 2006 08:54:33.0304 (UTC) FILETIME=[2375CD80:01C618E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i m using  fc3


$ ifconfig

eth0      Link encap:Ethernet  HWaddr 00:11:2F:38:07:D9
           inet addr:172.16.7.104  Bcast:172.16.7.255  Mask:255.255.252.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:6506 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5120 errors:0 dropped:0 overruns:0 carrier:0
          collisions:1256 txqueuelen:1000
          RX bytes:1951142 (1.8 Mb)  TX bytes:1027381 (1003.3 Kb)
          Interrupt:23 Base address:0x3800

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:78 errors:0 dropped:0 overruns:0 frame:0
          TX packets:78 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:5420 (5.2 Kb)  TX bytes:5420 (5.2 Kb)


     $ ifconfig eth0 down
     $ ifconfig sn0  172.16.8.1   netmask 255.255.252.0

sn0  intreface is added by driver .


what i want is , i want to  use the hw addreess of eth0 , irq of eth0 to sn0 
.

ie , i want  to do

$ ifconfig  sno 172.16.8.1 mtu 1500 irq 193 hw ether 00:11:2f:77:fd:c2

what i have to do ?

_________________________________________________________________
How good are you in a Formula One car? Play now 
http://server1.msn.co.in/sp05/tataracing/onlinegame.asp

