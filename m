Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTHRHvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTHRHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 03:51:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:52491 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271331AbTHRHvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 03:51:02 -0400
Date: Mon, 18 Aug 2003 09:43:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030818074358.GA15633@alpha.home.local>
References: <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16> <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk> <20030817224849.GB734@alpha.home.local> <20030817222258.257694b9.davem@redhat.com> <20030818065652.GA15098@alpha.home.local> <20030818000139.6964cd04.davem@redhat.com> <20030818072922.GB15098@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818072922.GB15098@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm replying to myself !

> So as a general rule of thumb, I would recommend people to systematically call
> "ip arp append table output to [network] oif [NIC] src [local_ip]" after an
> "ip address add [local_ip] dev [NIC]". And yes, I agree that these are
> standard tools, but I maintain that the default behaviour should be cleaner.

In fact, not standard. 'ip arp' was brought by Julian Anastasov's
iproute2-iparp-3 patch on top of iproute2. But it seems to do wonderful things.

Cheers,
Willy

