Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUDEMy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUDEMy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:54:28 -0400
Received: from news.cistron.nl ([62.216.30.38]:43728 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262194AbUDEMy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:54:27 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Network issues in 2.6
Date: Mon, 5 Apr 2004 12:54:26 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c4rku2$9dh$2@news.cistron.nl>
References: <002101c41b00$3f0f8c30$1530a8c0@HUSH>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1081169666 9649 62.216.29.200 (5 Apr 2004 12:54:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <002101c41b00$3f0f8c30$1530a8c0@HUSH>,
Carlos Fernandez Sanz <cfs-lk@nisupu.com> wrote:
>I upgraded from 2.4.22 to 2.6.5 (to test HPT374' support, which BTW, works
>fine).
>
>However, I'm having serious network issues now. The NIC is a 3com 3c905B.
>ifconfig shows this:
>
>eth0      Link encap:Ethernet  HWaddr 00:01:03:27:81:75
>          inet addr:192.168.20.1  Bcast:192.168.20.255  Mask:255.255.255.0
>          UP BROADCAST MULTICAST  MTU:1500  Metric:1
>          RX packets:11241 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:9739 errors:0 dropped:0 overruns:0 carrier:9732
>          collisions:0 txqueuelen:1000
>          RX bytes:2994485 (2.8 Mb)  TX bytes:835146 (815.5 Kb)
>          Interrupt:9 Base address:0xd800
>
>Note that for TX packets, the carrier number is almost the same as the total
>packets.... booting in 2.4.22, there are zero problems.  The only difference
>in the ifconfig, other than that, is that in 2.4.22, I have "RUNNING" in the
>options (but I didn't find how to force that).

Have you tried upgrading your 'ifconfig' ?

Mike.

