Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUJBBUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUJBBUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 21:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJBBUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 21:20:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:30628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266912AbUJBBUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 21:20:39 -0400
Date: Fri, 1 Oct 2004 18:17:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: haveblue@us.ibm.com, linux-mm@kvack.org, piggin@cyberone.com.au,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-Id: <20041001181742.7b880af2.akpm@osdl.org>
In-Reply-To: <20041001234200.GA4635@logos.cnet>
References: <20041001182221.GA3191@logos.cnet>
	<20041001131147.3780722b.akpm@osdl.org>
	<20041001190430.GA4372@logos.cnet>
	<1096667823.3684.1299.camel@localhost>
	<20041001234200.GA4635@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > Here's one of the recent patch sets that we're working on:
>  > 
>  > http://sprucegoose.sr71.net/patches/2.6.9-rc2-mm4-mhp-test2/
>  > 
> ...
>  Andrew, what are your thoughts wrt merging this to mainline?

It's the first I've seen of it.  I guess I'd be looking for testing results
as well as the outcome of discussions/review with the ia64 guys whose
hardware is not quite as cooperative as that on the ppc64 machines.
