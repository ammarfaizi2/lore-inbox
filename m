Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271896AbRHUXWY>; Tue, 21 Aug 2001 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271895AbRHUXWO>; Tue, 21 Aug 2001 19:22:14 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:53090 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271896AbRHUXWD>; Tue, 21 Aug 2001 19:22:03 -0400
Date: Tue, 21 Aug 2001 19:22:16 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: <firenza@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to page_cache.max_percent?
In-Reply-To: <20010822013929.E2275@telecoma.net>
Message-ID: <Pine.LNX.4.33.0108211921210.14374-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 firenza@gmx.net wrote:

> i don't care about the pagecache, i only care about having those
> 3GB in memory...

mlock()/mlockall().

> is there a way to set a maximum size for the pagecache (afaik,
> page_cache.max_percent is not used)?

> or can i specify to always drain the pagecache before swapping out?

Disable all swap.  (ie swapoff -a)

		-ben

