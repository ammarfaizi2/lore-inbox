Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWISSSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWISSSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWISSSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:18:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14255 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030396AbWISSSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:18:31 -0400
Date: Tue, 19 Sep 2006 11:19:20 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060919181919.GG1310@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org> <45102E21.2060301@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45102E21.2060301@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 03:51:29AM +1000, Nick Piggin wrote:
> Alan Stern wrote:
> >On Wed, 20 Sep 2006, Nick Piggin wrote:
> 
> >>I don't think that need be the case if one of the CPUs that has written
> >>the variable forwards the store to a subsequent load before it reaches
> >>the cache coherency (I could be wrong here). So if that is the case, then
> >>your above example would be correct.
> >
> >I don't understand your comment.  Are you saying it's possible for two 
> >CPUs to observe the same two writes and see them occurring in opposite 
> >orders?
> 
> If store forwarding is able to occur outside cache coherency protocol,
> then I don't see why not. I would also be interested to know if this
> is the case on real systems.

We are discussing multiple writes to the same variable, correct?

Just checking...

							Thanx, Paul
