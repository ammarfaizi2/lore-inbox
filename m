Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292142AbSBAXfN>; Fri, 1 Feb 2002 18:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292143AbSBAXfD>; Fri, 1 Feb 2002 18:35:03 -0500
Received: from rakis.net ([207.8.143.12]:62628 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S292142AbSBAXer>;
	Fri, 1 Feb 2002 18:34:47 -0500
Date: Fri, 1 Feb 2002 18:34:47 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gmack@innerfire.net, Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Machines misreporting Bogomips
In-Reply-To: <E16WnJL-0006Tg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.42.0202011831170.6556-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Alan Cox wrote:

> > The machine is reporting that the cache is enabled.  Even if this was
> > true, I have trouble believing that turning on the cache would result in a
> > 50,000% increase in speed (4 bogomips compared to 500).
>
> L1 and L2 cache both disabled comes up as about 2.5 bogomips typically on
> a Pentium II/III.
>

Ahh.  I was working with someone else trying to figure out if the cache
would affect the calculated bogomips.  Looks like it would.

The machine I'm reporting shows 512K of cache though.  I included a second
machine as a comparison, and apparently choose poorly.  That was the
machine reporting no cache.

Would a machine with L1 cache disabled, but with 512K of L2 cache report
around 4 Bogomips, or would the performance hit not be that strong?

