Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310163AbSCFVC2>; Wed, 6 Mar 2002 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310179AbSCFVCJ>; Wed, 6 Mar 2002 16:02:09 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:6539 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S310178AbSCFVBu>; Wed, 6 Mar 2002 16:01:50 -0500
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: Mike Fedyk <mfedyk@matchmail.com>, Robert Love <rml@tech9.net>
Date: Wed, 6 Mar 2002 16:01:31 -0500
MIME-Version: 1.0
Subject: Re: [STATUS 2.5]  March 6, 2002
CC: linux-kernel@vger.kernel.org
Message-ID: <3C863D5B.10226.23FAF78C@localhost>
In-Reply-To: <20020306190249.GB342@matchmail.com>
In-Reply-To: <1015446625.1482.11.camel@icbm>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2002 at 15:30, Robert Love wrote:

> On Wed, 2002-03-06 at 14:02, Mike Fedyk wrote:
> 
> > > o Beta        Fix long-held locks for low scheduling latency  (Andrew Morton, 
> > > etc.)
> > 
> > IIRC, LL isn't compatible with preempt, so maybe this item should be removed?
> 
> Agreed.  It isn't "incompatible" per se but it is certainly not the
> intention anymore.  With kernel preemption, we plan to cleanly tackle
> the lock hold times.
> 
> But maybe that is what the above means ... not "low-latency" per se but
> the general reduction in lock hold times and improvement of algorithms. 
> This is something Andrew, myself, and others are working on.  It is the
> follow up work to preempt-kernel.

Yes, this is what the above means: reducing lock hold times in the 
appropriate places.  Robert, I'll add you name for this item too, 
since you are working on this with Andrew.  It will make it clearer 
that it is not just referring to the old "low-latency" patch.

-- Guillaume

