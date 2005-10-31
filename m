Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVJaBXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJaBXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVJaBXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:23:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751268AbVJaBXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:23:30 -0500
Date: Sun, 30 Oct 2005 17:22:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: ak@suse.de, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030172247.743d77fa.akpm@osdl.org>
In-Reply-To: <20051031001647.GK2846@flint.arm.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051029223723.GJ14039@flint.arm.linux.org.uk>
	<20051030111241.74c5b1a6.akpm@osdl.org>
	<200510310148.57021.ak@suse.de>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > It might work better if we were told when the releases would actually
>  > happen and you don't need to fear that this not quite tested everywhere
>  > bugfix you're about to submit might make it into the gold kernel, breaking
>  > the world for some subset of users.
> 
>  Indeed - a prime example is the bootmem initialisation problem.

No, I'd say that was an *exception*, not a "prime example".

I've filed away 322 unresolved bug reports here.  The great majority are
busted drivers on random hardware dating back as far as 2.6.11.  Many of
them are regressions.

There is nothing stopping anyone from working with the originators to get
these things fixed up at any time.

Why is it necessary for me to chase maintainers to get their bugs fixed?

Why are maintainers working on new features when they have unresolved bugs?

Why is it so often me who has to do the followup for un-responded-to bug
reports against subsystems which I don't know anything about?

(Those are rhetorical questions, btw).
