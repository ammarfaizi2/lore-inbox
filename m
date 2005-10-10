Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVJJOch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVJJOch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVJJOch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:32:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44503 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750719AbVJJOcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:32:36 -0400
Date: Mon, 10 Oct 2005 16:32:29 +0200
From: VMiklos <vmiklos@frugalware.org>
To: linux-kernel@vger.kernel.org
Subject: Intresting messages and kernel panic with 2.6.13-mm3
Message-ID: <20051010143229.GH14425@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r475 (Linux)
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,FORGED_RCVD_HELO autolearn=disabled SpamAssassin version=3.0.4
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there.

I got a little problem here, i'm using debian sarge with an own compiled
kernel. The kernel version is 2.6.13-mm3 . No any extra patches.

I got strange errors in my dmesg:

KERNEL: assertion ((int)tcp_packets_in_flight(tp) >= 0) failed at
net/ipv4/tcp_input.c (1129)
KERNEL: assertion ((int)tcp_packets_in_flight(tp) >= 0) failed at
net/ipv4/tcp_input.c (1129)
Leak s=1 1
Leak s=2 3
KERNEL: assertion ((int)tcp_packets_in_flight(tp) >= 0) failed at
net/ipv4/tcp_input.c (1129)
Leak s=1 1
KERNEL: assertion ((int)tcp_packets_in_flight(tp) >= 0) failed at
net/ipv4/tcp_input.c (1129)
KERNEL: assertion ((int)tcp_packets_in_flight(tp) >= 0) failed at
net/ipv4/tcp_input.c (1129)

^^ like those. I don't know what is that or what cause that.
And i got segfaults at random time. (4hours.. after 6hours.. after
1hour..) I think those error messages causes the segfault in my kernel.

See this (shot from kernel-panic message) :
http://frugalware.org/~krix/panic.jpg

And i uploaded my config.gz to here:
http://frugalware.org/~krix/config.gz

So please, anyone got any idea about that ? :)

udv / greetings,
VMiklos

-- 
Developer of Frugalware Linux, to make things frugal - http://frugalware.org
