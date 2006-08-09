Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbWHIFz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWHIFz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWHIFzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:55:55 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:29123 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030505AbWHIFzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:55:54 -0400
Date: Wed, 9 Aug 2006 09:55:31 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, phillips@google.com
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060809055530.GE17446@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru> <20060808.225355.78711315.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060808.225355.78711315.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 09 Aug 2006 09:55:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 10:53:55PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Wed, 9 Aug 2006 09:46:48 +0400
> 
> > There is another approach for that - do not use slab allocator for
> > network dataflow at all. It automatically has all you pros amd if
> > implemented correctly can have a lot of additional usefull and
> > high-performance features like full zero-copy and total fragmentation
> > avoidance.
> 
> Free advertisement for your network tree allocator Evgeniy? :-)

He-he, some kind of :)

-- 
	Evgeniy Polyakov
