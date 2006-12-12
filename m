Return-Path: <linux-kernel-owner+w=401wt.eu-S1751174AbWLLFcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWLLFcb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 00:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWLLFcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 00:32:31 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53134 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbWLLFca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 00:32:30 -0500
Date: Tue, 12 Dec 2006 08:31:20 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
Message-ID: <20061212053117.GA14420@2ka.mipt.ru>
References: <20061128091602.GC15083@2ka.mipt.ru> <20061128.111300.105813754.davem@davemloft.net> <20061128192236.GA2051@2ka.mipt.ru> <20061211.173644.130208821.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061211.173644.130208821.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 12 Dec 2006 08:31:39 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 05:36:44PM -0800, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Tue, 28 Nov 2006 22:22:36 +0300
> 
> > And, btw, last time I checked, aligned_u64 was not exported to
> > userspace.
> 
> It is in linux/types.h and not protected by __KERNEL__ ifdefs.
> Perhaps you mean something else?

It looks like I checked wrong #ifdef __KERNEL__/#endif pair.
It is there indeed.

-- 
	Evgeniy Polyakov
