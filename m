Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282053AbRKVGvQ>; Thu, 22 Nov 2001 01:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282047AbRKVGvI>; Thu, 22 Nov 2001 01:51:08 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:58024 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S282051AbRKVGu4>;
	Thu, 22 Nov 2001 01:50:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: 8139 Driver Improvements
Date: Wed, 21 Nov 2001 22:50:28 -0800
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166ngq-0003pQ-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I'd just like to say that the 8139 Ethernet driver in 2.4.15pre3 is 
vastly improved over the driver included in the Linux ~2.4.8 timeframe. On my 
486DX2/80 running 2.4.8, the card would have impresssive burst performance, 
but buffer overruns would quickly drop the TCP throughput down to around 
1KB/second with heavy latency. Adjusting the all the /proc tuning knobs would 
do very little to improve performance, and I understandably blamed it on my 
shoddy hardware. I had similar results in FreeBSD, although I didn't know my 
way around enough to tune it terribly well.

I just upgraded the machines kernel to 2.4.15pre3 (to match my desktop). Now, 
the same setup can push 440KB/sec without breaking a sweat, and this is just 
a simple HTTP file transfer using the default /proc-tunable settings. So, 
hats off to Jeff Garzik and anyone else who has hacked on that driver and/or 
the TCP/IP stack.

-Ryan
