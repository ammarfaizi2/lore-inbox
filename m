Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTEAO7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTEAO7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:59:46 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45493 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261367AbTEAO7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:59:44 -0400
Date: Thu, 01 May 2003 08:11:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Willy TARREAU <willy@w.ods.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel source tree splitting
Message-ID: <16100000.1051801891@[10.10.2.4]>
In-Reply-To: <20030501150110.GA13282@work.bitmover.com>
References: <200305010756_MC3-1-36E1-623@compuserve.com>
 <11850000.1051797996@[10.10.2.4]> <20030501142041.GD308@pcw.home.local>
 <13900000.1051799746@[10.10.2.4]> <20030501150110.GA13282@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> -r--r--r--  1689 fletch   fletch      18691 Nov 17 20:29 COPYING
> 
> That's a bunch.  Who's fletch?  
> 
> And more importantly, how do you keep track of what is in each of those?
> I can see having 20, 100, whatever, and keeping it straight in your head
> but 1600?  

I have one view for every patch, and a bunch of scripts to manage them,
tear them down, build them up, and create patches from all of them in one
dir (they're a numbered sequence). A decent tree structure helps ;-)

It helps me to keep all the patches separated out - I want to be able to
carry forward 100 patches (at least) in sequence against the mainline tree,
and keep them all separate. Totally different problem from the one Linus
has, IMHO. 

I guess I have a view for what you call a changeset ... AFAICS, if you just
take 100 stacked patches, and do a merge forward through 30 versions, you
just end up with a big mess that you can't extract the real "changes"
you're making back out from the main view. But I've never really tried, it
might work out in BK or something I suppose. If that worked (in ~1 minute
for 100 patches), I'd be very tempted to try it (I hate learning curves for
new tools, half the time they're just burnt time).

> We'll still never be as fast as a pure hardlinked tree, that's balls to
> the wall as fast as you can go as far as I can tell.

Ow ;-)

M.

