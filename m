Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSGOBte>; Sun, 14 Jul 2002 21:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGOBtd>; Sun, 14 Jul 2002 21:49:33 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39686 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315451AbSGOBtd>; Sun, 14 Jul 2002 21:49:33 -0400
Date: Sun, 14 Jul 2002 21:46:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <20020713.205930.101495830.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1020714213937.21185B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, David S. Miller wrote:

> 
> You have to use specific source-routing settings in conjuntion with
> enabling arp_filter in order for arp_filter to have any effect.
> 
> This is a FAQ.

Frequently asked, but all I find is complex ways to work around the bug
rather than any patches. I do have the source routing settings in place,
virtually all packets sent to an IP not on the NIC are loggged and
droppped, so I won't have a problem with spoofing. I did turn off the
firewall on a machine to check the problem, in practice all the packets
with incorrect MAC addresses would be dropped.

I fear someone with less draconian firewalls might accept an internal IP
address on an external NIC, however. I get about 800 log entries a month
on some machines, and they're behind a boundary router.

I thought I was missing something, clearly this is a known problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

