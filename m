Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUCRDT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 22:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUCRDTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 22:19:55 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:13064 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S262378AbUCRDTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 22:19:53 -0500
Message-ID: <1079581101.405919ade7af9@vds.kolivas.org>
Date: Thu, 18 Mar 2004 14:38:21 +1100
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kurt Garloff <garloff@suse.de>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic sched timeslices
References: <20040315224201.GX4452@tpkurt.garloff.de> <200403170013.38140.kernel@kolivas.org> <20040316142957.GX4452@tpkurt.garloff.de> <200403170745.02538.kernel@kolivas.org> <20040318002027.GO20121@tpkurt.garloff.de> <20040317163214.16c943c5.akpm@osdl.org>
In-Reply-To: <20040317163214.16c943c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:

> Kurt Garloff <garloff@suse.de> wrote:
> >
> > Hi Con,
> > 
> > On Wed, Mar 17, 2004 at 07:45:02AM +1100, Con Kolivas wrote:
> > > > That's why I think we should offer the tunables.
> > > 
> > > If your workload is so dedicated to just number crunching it isn't hard
> to add 
> > > a zero to maximum timeslice in kernel/sced.c. 
> > 
> > Of course I can compile a custom kernel for myself and tune all sorts of
> > things. But this is not the way most Linux users want to use Linux any
> > more. Actually that's a long time ago.
> > 
> 
> I don't think we should be averse to offering a couple of nice high-level
> scheduler tunables.  But I do think we should have testing results which
> clearly show that they provide some benefit, and we should agree that the
> scheduler cannot provide the same benefit automagically.
> 
> Apologies in advance if we've seen those testing results and I missed it.

Well that reply takes my message out of context. I'm not averse to tunables - if
they do something.

The only evidence Kurt has shown so far is that he can decrease throughput. The
rest is theoretical based on a scheduler that isn't the 2.6 kernel.

Con

