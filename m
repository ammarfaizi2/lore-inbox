Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTBSVzU>; Wed, 19 Feb 2003 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTBSVzU>; Wed, 19 Feb 2003 16:55:20 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:63207
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S261908AbTBSVzT>; Wed, 19 Feb 2003 16:55:19 -0500
Date: Wed, 19 Feb 2003 17:04:00 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "David S. Miller" <davem@redhat.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
In-Reply-To: <1045692407.14307.11.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0302191659360.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2003, David S. Miller wrote:

> On Wed, 2003-02-19 at 09:28, Ion Badulescu wrote:
> > then you're probably debugging, not performance-tuning, so the cast to u64 
> > is acceptable.
> 
> Not true, you must cast to 'long long' as there is no appropriate
> printf format string for u64 that works warning-free on all
> systems.

Yes, long long and %ll[xd] is what I meant, thanks for the correction.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


