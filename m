Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRF2KAm>; Fri, 29 Jun 2001 06:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265840AbRF2KAc>; Fri, 29 Jun 2001 06:00:32 -0400
Received: from mean.netppl.fi ([195.242.208.16]:9488 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S265839AbRF2KA0>;
	Fri, 29 Jun 2001 06:00:26 -0400
Date: Fri, 29 Jun 2001 13:00:24 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: artificial latency for a network interface
Message-ID: <20010629130024.A11205@netppl.fi>
In-Reply-To: <3B3C0060.FBDB5F87@uow.edu.au> <Pine.GSO.4.10.10106282327330.7836-100000@mcbain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.GSO.4.10.10106282327330.7836-100000@mcbain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 11:29:38PM -0500, Burkhard Daniel wrote:
> I had a similiar problem once, and wrote a module that overwrote the
> loopback net device. Since it's loopback, the kernel won't care about
> headers.
> 
> Yeah, I know: Quick & Dirty.
> 
> I made the new loopback put its packets in a queue and then deliver them
> after a (adjustable) delay.
> 
> If I can still find the source for this, I'll post it here.
> 
And for something with a lot more options, try
http://www.antd.nist.gov/nistnet.

Works great, lets you drop packets, have variable latency, simulate
congestion, almost everything you need to simulate networks.
Even has a nice GUI to tune it all ;)

