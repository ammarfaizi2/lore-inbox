Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754476AbWKMLVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbWKMLVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 06:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbWKMLVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 06:21:06 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:44195 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754476AbWKMLVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 06:21:02 -0500
Date: Mon, 13 Nov 2006 14:16:47 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061113111647.GB8182@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061113105458.GA8182@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 13 Nov 2006 14:16:53 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 01:54:58PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > ===================
> > 
> > - there is really no reason to invent yet another timer implementation.
> >   We have the POSIX timers which are feature rich and nicely
> >   implemented.  All that is needed is to implement SIGEV_KEVENT as a
> >   notification mechanism.  The timer is registered as part of the
> >   timer_create() syscalls.
> 
> Feel free to add any interface you like - it is as simple as call for
> kevent_user_add_ukevent() in userspace.

... in kernelspace I mean.

-- 
	Evgeniy Polyakov
