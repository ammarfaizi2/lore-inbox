Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbTI2SMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTI2SH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:07:56 -0400
Received: from heron.mail.pas.earthlink.net ([207.217.120.189]:15096 "EHLO
	heron.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264174AbTI2SHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:07:36 -0400
Message-ID: <3F78745B.7000606@earthlink.net>
Date: Mon, 29 Sep 2003 14:05:15 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: transmit timeout problem
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: a437fbc6971e80f61aa676d7e74259b7b3291a7d08dfec790891091c63127daa7abbe66cdb4fa407350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help needed please,

In frequently I start getting the following:

Sep 29 10:32:49 joker kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 29 10:32:49 joker kernel: eth0: Transmit timed out, status fc1e4010, 
CSR12 0
0000000, resetting...
Sep 29 10:32:57 joker kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 29 10:32:57 joker kernel: eth0: Transmit timed out, status fc1e4010, 
CSR12 0
0000000, resetting...
Sep 29 10:33:05 joker kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 29 10:33:05 joker kernel: eth0: Transmit timed out, status fc1e4010, 
CSR12 0
0000000, resetting...
Sep 29 10:33:13 joker kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 29 10:33:13 joker kernel: eth0: Transmit timed out, status fc1e4010, 
CSR12 0
0000000, resetting...
Sep 29 10:33:21 joker kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 29 10:33:21 joker kernel: eth0: Transmit timed out, status fc1e4010, 
CSR12 0
0000000, resetting...
Sep 29 10:33:29 joker kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 29 10:33:29 joker kernel: eth0: Transmit timed out, status fc1e4010, 
CSR12 0
0000000, resetting...


This usally happens while I at work - so I have my wife restart my 
system. I have two of these cards
and have seen it happen on both of them. Anybody have an idea on how to 
fix this.

Below is the kernel version and info on the cards.

Sep 29 10:35:37 joker kernel: Linux version 2.4.20-20.9custom 
(root@joker.seclar
k.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3 Wed Sep 
17 16:28:
06 EDT 2003

Sep 29 10:35:38 joker kernel: Linux Tulip driver version 0.9.15-pre12 
(Aug 9, 20
02)
Sep 29 10:35:38 joker kernel: eth0: ADMtek Comet rev 17 at 0xb000, 
00:04:5A:6D:D
8:CC, IRQ 5.
Sep 29 10:35:38 joker kernel: eth1: ADMtek Comet rev 17 at 0xb400, 
00:04:5A:40:5
1:24, IRQ 11.

Thanks,
Steve

