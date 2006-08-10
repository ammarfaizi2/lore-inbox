Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030631AbWHJMXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbWHJMXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWHJMXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:23:05 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:29370 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751486AbWHJMXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:23:03 -0400
Date: Thu, 10 Aug 2006 16:22:13 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take7 1/1] kevent: core files and timer/poll notifications.
Message-ID: <20060810122213.GA12155@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru> <11551105602734@2ka.mipt.ru> <20060809152127.481fb346.akpm@osdl.org> <20060810121250.GA28665@2ka.mipt.ru> <20060810121638.GA3782@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060810121638.GA3782@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 10 Aug 2006 16:22:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 04:16:38PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> With this patchset rate of requests per second has achieved 2500 req/sec
> while with epoll/kqueue and similar techniques it is about 1600-1800
> requests per second on my test hardware and trivial web server.

Nope, it is old record from archives... Current one is 2600+

-- 
	Evgeniy Polyakov
