Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTLVNHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 08:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLVNHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 08:07:13 -0500
Received: from mail.szintezis.hu ([195.56.253.241]:27333 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S264410AbTLVNHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 08:07:11 -0500
Subject: [2.6.0] intel pro/wireless 2011 vs. orinoco
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Dec 2003 14:07:08 +0100
Message-Id: <1072098429.3831.13.camel@gmicsko03>
Mime-Version: 1.0
X-OriginalArrivalTime: 22 Dec 2003 13:07:10.0356 (UTC) FILETIME=[824CE540:01C3C88C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

if i try download big files from the internet or my local network throuh
my intel pro/wireless 2011 card, i get sometimes (rare) the following
error messages:

Dec 22 13:54:55 gmicsko03 kernel: eth1: Error -110 writing Tx descriptor
to BAP
Dec 22 13:54:55 gmicsko03 last message repeated 82 times

in this situation my CPU load jump to 100%, traffic stopping. if i
remove the pcmcia card, and reinsert everything is OK.

it is a driver bug, or my wireless card old/buggy/etc ?

snip from syslog:

Dec 22 14:05:11 gmicsko03 cardmgr[231]: socket 0: Intel PRO/Wireless
2011
Dec 22 14:05:11 gmicsko03 kernel: eth1: Station identity
001f:0002:0002:0001
Dec 22 14:05:11 gmicsko03 kernel: eth1: Looks like a Symbol firmware
version [V2.51-04] (parsing to 25104)
Dec 22 14:05:11 gmicsko03 kernel: eth1: Ad-hoc demo mode supported
Dec 22 14:05:11 gmicsko03 kernel: eth1: IEEE standard IBSS ad-hoc mode
supported
Dec 22 14:05:11 gmicsko03 kernel: eth1: WEP supported, 104-bit key
Dec 22 14:05:11 gmicsko03 kernel: eth1: MAC address 00:02:B3:04:7B:F6
Dec 22 14:05:11 gmicsko03 kernel: eth1: Station name "Prism  I"
Dec 22 14:05:11 gmicsko03 kernel: eth1: ready
Dec 22 14:05:11 gmicsko03 kernel: eth1: index 0x01: Vcc 5.0, irq 3, io
0x0100-0x0147
Dec 22 14:05:11 gmicsko03 cardmgr[231]: executing: './network start
eth1'
Dec 22 14:05:11 gmicsko03 cardmgr[231]: + SIOCSIFFLAGS: Cannot assign
requested address
Dec 22 14:05:11 gmicsko03 kernel: eth1: New link status: Disconnected
(0002)
Dec 22 14:05:12 gmicsko03 kernel: eth1: New link status: Connected
(0001)

[...]


