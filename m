Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269877AbRHMFpS>; Mon, 13 Aug 2001 01:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269886AbRHMFpI>; Mon, 13 Aug 2001 01:45:08 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:18451 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269877AbRHMFoz>; Mon, 13 Aug 2001 01:44:55 -0400
Date: Sun, 12 Aug 2001 22:44:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <andrea@suse.de>, <eyal@eyal.emu.id.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8aa1
In-Reply-To: <20010812.202918.48532196.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108122242450.14385-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Aug 2001, David S. Miller wrote:
>
> First, maybe I'm confused about intent.  Are we trying to just hack
> together something quick for 2.4.x that allows PCI drivers on highmem
> machines to get at the complete low 4GB of physical memory, even the
> highmem parts?

No, it's more about cleaning up stuff for 2.4.x - the drivers affected
right now can't use more than 1GB of ram anyway, but as they were written
they would not compile in Andrea's tree due to having a bit too intimate a
knowledge of the VM system.

For 2.5.x, we'll see where we end up going in the long run.

		Linus

