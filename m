Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVGHWDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVGHWDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVGHWAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:00:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262580AbVGHV6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:58:55 -0400
Date: Fri, 8 Jul 2005 14:59:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050708145953.0b2d8030.akpm@osdl.org>
In-Reply-To: <20050708214908.GA31225@taniwha.stupidest.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<20050708214908.GA31225@taniwha.stupidest.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Thu, Jun 23, 2005 at 11:28:47AM -0700, Linux Kernel Mailing List wrote:
          ^^^^^^

It's been over two weeks and nobody has complained about anything.

> 
> > [PATCH] i386: Selectable Frequency of the Timer Interrupt
> 
> [...]
> 
> > +choice
> > +	prompt "Timer frequency"
> > +	default HZ_250
> 
> WHAT?
> 
> The previous value here i386 is 1000 --- so why is the default 250.

Because 1000 is too high.

> Now that this has hit mainline please consider applying:

We might indeed do that.  But if nobody continues to notice anything, we
might not.  We'll see.
