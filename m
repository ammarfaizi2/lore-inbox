Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131188AbRALAx7>; Thu, 11 Jan 2001 19:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRALAxt>; Thu, 11 Jan 2001 19:53:49 -0500
Received: from mailhost1.dircon.co.uk ([194.112.32.65]:25355 "EHLO
	mailhost1.dircon.co.uk") by vger.kernel.org with ESMTP
	id <S131188AbRALAxb>; Thu, 11 Jan 2001 19:53:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.21680.175176.177588@starfruit.iwks.multi.local>
Date: Fri, 12 Jan 2001 00:49:52 +0000 (GMT)
From: Mark Longair <list-reader@ideaworks3d.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.2.18] outgoing connections getting stuck in SYN_SENT
In-Reply-To: <Pine.LNX.3.95.1010111191618.1531A-100000@chaos.analogic.com>
In-Reply-To: <14942.18985.174437.785751@starfruit.iwks.multi.local>
	<Pine.LNX.3.95.1010111191618.1531A-100000@chaos.analogic.com>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January, Richard B. Johnson wrote ("Re: [2.2.18] outgoing connections getting stuck in SYN_SENT"):
[...]
> You probably compiled your kernel with "CONFIG_INET_ECN" set.
> If so, you need to turn it OFF in /proc/sys/net/...something_ecn.

I don't have an ECN option available in this kernel (2.2.18) - I
thought it only appeared in 2.3...

> Many/most/all servers are "not ready for prime time" and will
> reject packets that have "strange" bits set.
[...]

I compiled in the QoS support - could that possibly cause a similar
effect?  I'm not actually using the QoS tools at the moment, but I
intend to soon.  I'll post the selected options in my .config if that
would be helpful.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
