Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282395AbRK0R5A>; Tue, 27 Nov 2001 12:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282218AbRK0R4t>; Tue, 27 Nov 2001 12:56:49 -0500
Received: from c38889-c.grlnd1.tx.home.com ([24.4.38.23]:6272 "HELO
	webby.quo.to") by vger.kernel.org with SMTP id <S282189AbRK0Rzm>;
	Tue, 27 Nov 2001 12:55:42 -0500
Message-ID: <002301c1776c$b9776ef0$024d460a@neptune>
From: "Jordan Russell" <jr-list-kernel@quo.to>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4(.16) kernel logs messages in the wrong order
Date: Tue, 27 Nov 2001 11:55:39 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here's an excerpt from my /var/log/messages. Notice how messages from two
different times are strangely mixed together. What's going on? Is there some
way to fix it? This does not happen when a 2.2.x kernel is used.

Nov 27 11:38:54 webby sysctl: net.ipv4.conf.default.rp_filter = 1
Nov 27 11:39:15 webby kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 27 11:38:54 webby sysctl: kernel.sysrq = 1
Nov 27 11:39:15 webby kernel: IP Protocols: ICMP, UDP, TCP
Nov 27 11:38:54 webby sysctl: net.ipv4.ip_forward = 1
Nov 27 11:39:15 webby kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Nov 27 11:38:54 webby rc.sysinit: Configuring kernel parameters:  succeeded

I'm using Red Hat 7.2 if it matters.

Thanks,

Jordan Russell

