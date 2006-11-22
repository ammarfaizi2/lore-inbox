Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754278AbWKVMQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbWKVMQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbWKVMQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:16:47 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:42908 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754256AbWKVMQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:16:47 -0500
Date: Wed, 22 Nov 2006 15:15:16 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122121516.GA7229@2ka.mipt.ru>
References: <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061122120933.GA32681@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 15:15:41 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 03:09:34PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> Ok, to solve the problem in the way which should be good for both I
> decided to implement additional syscall which will allow to mark any
> event as ready and thus wake up appropriate threads. If userspace will
> request zero events to be marked as ready, syscall will just
> interrupt/wakeup one of the listeners parked in syscall.

Btw, what about putting aditional multiplexer into add/remove/modify
switch? There will be logical 'ready' addon?

-- 
	Evgeniy Polyakov
