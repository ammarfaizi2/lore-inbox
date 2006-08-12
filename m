Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWHLKwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWHLKwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 06:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWHLKwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 06:52:06 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:60876 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964823AbWHLKwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 06:52:05 -0400
Date: Sat, 12 Aug 2006 14:51:19 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060812105119.GA378@2ka.mipt.ru>
References: <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru> <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru> <1155377887.13508.27.camel@lappy> <20060812104224.GA12353@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060812104224.GA12353@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 14:51:21 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 02:42:26PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > Hence the alternative allocator to use on tight memory conditions.
> 
> If transferred to your implementation, then just steal some pages from
> SLAB when new network device is added and use them when OOM happens.
> It is much simpler and can help in the most of situations.

And just to make things clear - I do not insult your implementation 
in any way, it can be 100% correct and behave perfectly.
I'm just saying that there are other methods to solve the problem which
seems to me more appropriate.

-- 
	Evgeniy Polyakov
