Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUCRAcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUCRAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:32:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:17026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262240AbUCRAcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:32:18 -0500
Date: Wed, 17 Mar 2004 16:32:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kurt Garloff <garloff@suse.de>
Cc: kernel@kolivas.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dynamic sched timeslices
Message-Id: <20040317163214.16c943c5.akpm@osdl.org>
In-Reply-To: <20040318002027.GO20121@tpkurt.garloff.de>
References: <20040315224201.GX4452@tpkurt.garloff.de>
	<200403170013.38140.kernel@kolivas.org>
	<20040316142957.GX4452@tpkurt.garloff.de>
	<200403170745.02538.kernel@kolivas.org>
	<20040318002027.GO20121@tpkurt.garloff.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> wrote:
>
> Hi Con,
> 
> On Wed, Mar 17, 2004 at 07:45:02AM +1100, Con Kolivas wrote:
> > > That's why I think we should offer the tunables.
> > 
> > If your workload is so dedicated to just number crunching it isn't hard to add 
> > a zero to maximum timeslice in kernel/sced.c. 
> 
> Of course I can compile a custom kernel for myself and tune all sorts of
> things. But this is not the way most Linux users want to use Linux any
> more. Actually that's a long time ago.
> 

I don't think we should be averse to offering a couple of nice high-level
scheduler tunables.  But I do think we should have testing results which
clearly show that they provide some benefit, and we should agree that the
scheduler cannot provide the same benefit automagically.

Apologies in advance if we've seen those testing results and I missed it.
