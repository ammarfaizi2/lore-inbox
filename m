Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUDELVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUDELVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:21:01 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:37249 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262006AbUDELU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:20:58 -0400
Message-ID: <002101c41b00$3f0f8c30$1530a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: <linux-kernel@vger.kernel.org>
Subject: Network issues in 2.6
Date: Mon, 5 Apr 2004 13:21:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded from 2.4.22 to 2.6.5 (to test HPT374' support, which BTW, works
fine).

However, I'm having serious network issues now. The NIC is a 3com 3c905B.
ifconfig shows this:

eth0      Link encap:Ethernet  HWaddr 00:01:03:27:81:75
          inet addr:192.168.20.1  Bcast:192.168.20.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:11241 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9739 errors:0 dropped:0 overruns:0 carrier:9732
          collisions:0 txqueuelen:1000
          RX bytes:2994485 (2.8 Mb)  TX bytes:835146 (815.5 Kb)
          Interrupt:9 Base address:0xd800

Note that for TX packets, the carrier number is almost the same as the total
packets.... booting in 2.4.22, there are zero problems.  The only difference
in the ifconfig, other than that, is that in 2.4.22, I have "RUNNING" in the
options (but I didn't find how to force that).

I read the docs and tried forcing full_duplex, etc, with no success.
BTW, that NIC is connected to a 10/100 switch, nothing fancy.

