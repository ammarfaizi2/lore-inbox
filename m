Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTAFWQ4>; Mon, 6 Jan 2003 17:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbTAFWQ4>; Mon, 6 Jan 2003 17:16:56 -0500
Received: from algx-tower-com-4173.z188-2-66.customer.algx.net ([66.2.188.62]:35501
	"EHLO neon.limebrokerage.com") by vger.kernel.org with ESMTP
	id <S267160AbTAFWQz>; Mon, 6 Jan 2003 17:16:55 -0500
Date: Mon, 6 Jan 2003 17:25:31 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix starfire compiler warning on PAE
In-Reply-To: <41340000.1041889554@flay>
Message-ID: <Pine.LNX.4.44.0301061721260.22375-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Martin J. Bligh wrote:

> > A few of these are mostly normal, it's the card signalling the driver that 
> > it is getting a Tx fifo underrun, and the driver responds by increasing 
> > the threshold at which the card starts transmitting the packet.
> 
> Can we not print them onto the console if they're normal then?

They're only semi-normal, since they signal some unusual contention on the
PCI bus... but yeah, I guess we could lower their priority to KERN_INFO.

> I think the card took itself offline at this point, so it smells like a bug.
> That's only been happening recently though (I've only noticed in the last
> week from a year or two of use).

I could definitely be a bug (known or not). Anyway, it would be good to 
test it with the latest version of the driver.

> Sure, send me the patch, these boxes bring out races like dying rich aunts
> bring out friendly relatives. And I have a cabinet drawer full of starfire
> cards ;-)

All right, I'll forward it off-list.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

