Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWIDJ7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWIDJ7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWIDJ7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:59:32 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62642 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751326AbWIDJ7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:59:31 -0400
Date: Mon, 4 Sep 2006 13:58:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take15 0/4] kevent: Generic event handling mechanism.
Message-ID: <20060904095850.GA2654@2ka.mipt.ru>
References: <12345678912345.GA1898@2ka.mipt.ru> <11573648604058@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <11573648604058@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 04 Sep 2006 13:58:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 02:14:20PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> 
> Generic event handling mechanism.

Unfortunately bogofilter on vger.kernel.org decided that socket and
timer notifications are spam, so they will not be found in linux-kernel
archive.

One can use kevent homepage instead:
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent


Missed socket notifications description:
# added socket notifications (send/recv/accept). Using trivial web
# server based on kevent and this features instead of epoll it's
# performance increased more than noticebly. More details about
# benchmark and server itself (evserver_kevent.c) can be found on project
# homepage. Splitted patches are available in archive 
# http://tservice.net.ru/~s0mbre/archive/kevent/2.6.18.15

-- 
	Evgeniy Polyakov

-- 
VGER BF report: U 0.499757
