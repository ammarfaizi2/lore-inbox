Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUJSV6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUJSV6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJSVtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:49:14 -0400
Received: from havoc.gtf.org ([69.28.190.101]:22444 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267431AbUJSViF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:38:05 -0400
Date: Tue, 19 Oct 2004 17:38:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041019213803.GA6994@havoc.gtf.org>
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com> <41753B99.5090003@pobox.com> <4d8e3fd304101914332979f86a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd304101914332979f86a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:33:40PM +0200, Paolo Ciarrocchi wrote:
> On Tue, 19 Oct 2004 12:06:49 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Although tangential to the problem, I thought LKML and BitMover (and
> > maybe Andrew or Linus as well) might be interested in a general
> > description of my workflow.
> > 
> > For net drivers in the Linux kernel, there exists two patch queues,
> > net-drivers-2.6 and netdev-2.6 (and corresponding 2.4 versions).
> > net-drivers-2.6 could be described as the "upstream immediately" or "for
> > Linus" queue, and netdev-2.6 could be described as the "testing" queue.
> 
> So you have two bk trees, 
> - patches good for mainstream
> - patches good for -mm tree

Close:
- patches ready for mainstream
- patches eventually ready for mainstream

and changes flow "up" from netdev-2.6 to net-drivers-2.6.


> It would be cool if all the maintainers could adopt your working method,
> Andrew is already automatically pulling from a bunch of trees, why not
> having Linusdoing the same too?

That's what Linus does already, when I email him :)

But Linus is essentially "senior editor", so we don't want to automate
the system, otherwise there is no editorial control.  He is our
emporer penguin, after all.

	Jeff


