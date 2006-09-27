Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWI0PKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWI0PKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWI0PKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 11:10:50 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:5837 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964892AbWI0PKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 11:10:49 -0400
Date: Wed, 27 Sep 2006 19:09:57 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20060927150957.GA18116@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <11587449471424@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 27 Sep 2006 19:09:59 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 01:35:47PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> 
> Generic event handling mechanism.
> 
> Consider for inclusion.

I have been told in private what is signal masks about - just to wait
until either signal or given condition is ready, but in that case just 
add additional kevent user like AIO complete or netwrok notification 
and wait until either requested events are ready or signal is triggered.

-- 
	Evgeniy Polyakov
