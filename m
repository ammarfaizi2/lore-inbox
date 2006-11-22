Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031489AbWKVKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031489AbWKVKkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbWKVKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:40:20 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:48074 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1755628AbWKVKkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:40:18 -0500
Date: Wed, 22 Nov 2006 13:39:23 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ulrich Drepper <drepper@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122103923.GB11480@2ka.mipt.ru>
References: <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <45635F39.1000708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45635F39.1000708@garzik.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 13:39:23 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 03:19:05PM -0500, Jeff Garzik (jeff@garzik.org) wrote:
> Another:  pass a 'flags' argument to kevent_init(2).  I guarantee you 
> will need it eventually.  It IMO would help with later binary 
> compatibility, if nothing else.  You wouldn't need a new syscall to 
> introduce struct kevent_ring_v2.

Yep, I will add there 'flags' field.

> 	Jeff

-- 
	Evgeniy Polyakov
