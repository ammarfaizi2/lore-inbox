Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFQJHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFQJHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:07:23 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:52492 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261245AbTFQJHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:07:22 -0400
Date: Tue, 17 Jun 2003 19:20:58 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Julian Blake Kongslie <jblake@omgwallhack.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IPSEC problems with GRE.
In-Reply-To: <1055746871.2305.7.camel@festa.omgwallhack.org>
Message-ID: <Mutt.LNX.4.44.0306171918531.13900-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jun 2003, Julian Blake Kongslie wrote:

> Specifically, attempts to encrypt a GRE or IPIP tunnel with ipsec in
> transport mode result in one of:
> 	1) No data sent.
> 	2) Data sent, ignored by peer.
> 	3) Kernel panic, with no SysRq.
> 
> Numbers 1 and 2 might be configuration problems on my part, but I have
> other ipsec setups running fine, and can't see anything different for
> these. Number 3 is a big problem.
> 
> This is on 2.5.70. No third-party modules or other tainting. I can
> provide .configs on request.
> 
> I don't have the panic copied down, but I can reproduce it and get a
> copy if required.

Please post the oops (preferrably to the netdev mailing list).   

Also, which system panics, and what direction is the traffic when this 
happens?  (i.e. is it happening during tunnel encapsulation or 
decapsulation?)


- James
-- 
James Morris
<jmorris@intercode.com.au>

