Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265467AbRGSRYi>; Thu, 19 Jul 2001 13:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265452AbRGSRY3>; Thu, 19 Jul 2001 13:24:29 -0400
Received: from mail.intrex.net ([209.42.192.246]:29958 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S265443AbRGSRYK>;
	Thu, 19 Jul 2001 13:24:10 -0400
Date: Thu, 19 Jul 2001 13:29:35 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: Request for comments
Message-ID: <20010719132935.A10126@bessie.localdomain>
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>; from ctrl@rdsnet.ro on Thu, Jul 19, 2001 at 06:44:52PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 06:44:52PM +0300, Cornel Ciocirlan wrote:

> What this would do is keep a "cache" of all the "flows" that are passing
> through the system; a flow is defined as the set of packets that have the
> same headers - or header fields. For example we could choose "ip source,
> ip destination, ip protocol, ip source port [if relevant], ip destination
> port [ if relevant ], and maintain a cache of all distinct such
> "flows" that pass through the system. The flows would have to be
> "expired" from the cache (LRU) and there should be a limit on the size of
> the cache.

This sounds a lot like what MPLS does.  I believe that someone has MPLS
patches for the kernel, but I dont know who.  You might want to find them
and take a look.

Jim
