Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTABBoH>; Wed, 1 Jan 2003 20:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTABBoH>; Wed, 1 Jan 2003 20:44:07 -0500
Received: from foursticks.link.internode.on.net ([150.101.16.181]:2957 "EHLO
	mars") by vger.kernel.org with ESMTP id <S265378AbTABBoG>;
	Wed, 1 Jan 2003 20:44:06 -0500
To: linux-kernel@vger.kernel.org
cc: pschulz@foursticks.com
Subject: Broadcom Gigabit 5703 and Bridging
Date: Thu, 02 Jan 2003 12:20:29 +1030
From: Paul Schulz <pschulz@foursticks.com>
Message-Id: <E18TuVB-000282-00@mars>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm seeing 'TCP Checksum' Errors after packets pass through a host
bridging TCP packets with:

 - Kernel 2.4.20
 - Bridge code 
 - tg3 (Broadcom Gigabit 5703)

   eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] 
    (PCIX:100MHz:64-bit) 10/100/1000BaseT
  (eth1 is similar)
  
Pings (ICMP) pass through the bridge just fine.

The hardware is IBM's xSeries 305.

Paul
--
                Paul Schulz - Software Engineer [codito, ergo sum]
        Foursticks Pty Ltd - 2/259 Glen Osmond Road, Frewville, SA 5063
    Phone: +61 8 8338 5500   Fax: +61 8 8338 5511   Mobile: +61 401 981 301
       Email: pschulz@foursticks.com           Web: www.foursticks.com
