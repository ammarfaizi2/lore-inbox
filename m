Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWAaIPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWAaIPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 03:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWAaIPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 03:15:03 -0500
Received: from ee.oulu.fi ([130.231.61.23]:33002 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S965059AbWAaIPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 03:15:01 -0500
Date: Tue, 31 Jan 2006 10:14:29 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Knut Petersen <Knut_Petersen@t-online.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: skge bridge & hw csum failure (Was: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller 11ab:4362 (rev 19))
Message-ID: <20060131081429.GA11063@ee.oulu.fi>
References: <20060130231658.GA6952@ee.oulu.fi> <20060130161551.623a3ad0@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060130161551.623a3ad0@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 04:15:51PM -0800, Stephen Hemminger wrote:
> Okay, what is the hardware version:
> 	dmesg | grep skge
> Maybe that chip rev is no good.
skge 1.3 addr 0xd042c000 irq 169 chip Yukon-Lite rev 7
skge eth0: addr 00:10:f3:06:83:d4
skge 1.3 addr 0xd0420000 irq 193 chip Yukon-Lite rev 7
skge eth1: addr 00:10:f3:06:83:d5
skge 1.3 addr 0xd0424000 irq 185 chip Yukon-Lite rev 7
skge eth2: addr 00:10:f3:06:83:d6
skge 1.3 addr 0xd0428000 irq 177 chip Yukon-Lite rev 7
skge eth3: addr 00:10:f3:06:83:d7

In related news, the box has been running with a 2.6.16-rc1-git4 based
kernel for 8 hours now without any errors. First kernel+driver version
that does that (apart from vendor-sk98lin on a kernel without slab
debugging ;) ;) ;) ). 
