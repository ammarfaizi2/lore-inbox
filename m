Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279084AbRKAPS7>; Thu, 1 Nov 2001 10:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279097AbRKAPSu>; Thu, 1 Nov 2001 10:18:50 -0500
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:61958 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S279084AbRKAPS3>; Thu, 1 Nov 2001 10:18:29 -0500
Date: Thu, 1 Nov 2001 16:18:27 +0100 (CET)
From: Joris van Rantwijk <joris@deadlock.et.tudelft.nl>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
In-Reply-To: <p733d3yr2b1.fsf@amdsim2.suse.de>
Message-ID: <Pine.LNX.4.21.0111011603040.25072-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2001, Andi Kleen wrote:
> Joris van Rantwijk <joris@deadlock.et.tudelft.nl> writes:
> > So... Shouldn't dev_queue_xmit_nit() also process ptype_base then ?

> It probably should, but unfortunately then it would loop back to all normal
> protocols (IP, IPv6, ARP etc.) too, which would not be good.

Ah, right. I suspected there was a good reason not to do it, or it
would have been done ages ago.

But it's still a bit weird isn't it ?
You sure won't find this in man packet(7).

Thanks for explaining,
  Joris van Rantwijk.

