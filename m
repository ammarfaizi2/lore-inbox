Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVLFBSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVLFBSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVLFBSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:18:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31748
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964895AbVLFBSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:18:47 -0500
Date: Tue, 6 Dec 2005 02:18:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206011844.GO28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205121851.GC2838@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:18:51AM -0800, William Lee Irwin III wrote:
> The December 6 event is extraordinarily unlikely. What's vastly more
> likely is consistent "erosion" over time. First the 3D video drivers,
> then the wireless network drivers, then the fakeraid drivers, and so on.

I agree about the erosion.

I am convinced that the only way to stop the erosion is to totally stop
buying hardware that has only binary only drivers (unless you buy it to
create an open source driver or to reverse engineer the binary only
driver of course! ;).

For example if a laptop has an embedded wirless or 3d card not supported by
open source drivers, buy a laptop without any wireless card or without
3d, instead of buying one with the not-supported hardware without using
it (I can guarantee there are still laptops that requires no 3d
binary only drivers and no wirless cards drivers, even for the winmodems
you can choose the ones supported by alsa). We literally have to refuse
buying those cards with binary only kernel drivers.

Every time we buy a piece of hardware with binary only drivers we admit
that the binary only driver vendors are doing the right choice for their
stockholders. Only when we refuse to buy it, we can make a slight difference.
When we don't buy hardware without open source drivers, we send the
message to the shareholders that the management is causing them a loss.

It's market forces controlling which drivers are open sources and which
aren't (the risk of being sued and the cost of the laywers is only part
of the more complex equation), and the customers have an huge strength
in controlling those forces (we effectively control 50% of it).

The fact Arjan got the "nvidia fanboy" complaining, is the sign that
some people just don't care. This understandable for a 3d kind of
product which is 90% for entertainment (nobody loses money when it
crashes), and we generally can't expect everyone to care about the long
term kernel development.

But at least for all more business oriented usages of linux, linux users
should understand the erosion they create by funding companies that
requires binary only drivers. 

Every time we buy an hardware with a binary only driver, we effectively
increase the erosion, or we give a sound reason to those company to keep
eroding.

I think messages like the one from Arjan are very positive to let people
understand the long term effect of binary only drivers, but this should
be combined with the strategy to use to reduce the erosion (i.e. not to
buy hardware that has binary only drivers).

Perhaps we should add a printk that points to an url on kernel.org
including Arjan's message every time a non-gpl module gets loaded by the
kernel. I think it's a matter of educating the customer too or they can
do mistakes, creating a blacklist would help too.

I don't believe in the breaking of the 3d drivers gratuitously, it
should be market forces deciding which drivers have to be open sources
and which not. But our side of the market (i.e. the buyers) must be
educated properly.
