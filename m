Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbTIAQ3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbTIAQ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:29:43 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24264 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262980AbTIAQ3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:29:30 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030901161316.GH11503@dualathlon.random>
References: <20030831163350.GY24409@dualathlon.random>
	 <20030831164802.GA12752@work.bitmover.com>
	 <20030831170633.GA24409@dualathlon.random>
	 <20030831211855.GB12752@work.bitmover.com>
	 <20030831224938.GC24409@dualathlon.random>
	 <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk>
	 <20030831230219.GD24409@dualathlon.random>
	 <20030831230728.GA4918@work.bitmover.com>
	 <20030831232224.GF24409@dualathlon.random>
	 <1062416635.13372.17.camel@dhcp23.swansea.linux.org.uk>
	 <20030901161316.GH11503@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062433710.14254.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 17:28:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 17:13, Andrea Arcangeli wrote:
> > Each ACK that has caused previous delays generally opens up a 64K window
> > so you get bursts of data incoming. A sequence of acks can cause the
> 
> the congestion avoidance shouldn't allow what you say. It sends a few
> packets immediatly (cwnd starts > 1 recently), and that's why
> non-keepalive connections are bad, but after that the congestion window
> will remain low if we drop the packets.

You may trigger fast retransmit patterns. Thats why you have to bend the
window.

