Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWC3Oxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWC3Oxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWC3Oxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:53:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:50189 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750714AbWC3Oxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:53:42 -0500
Date: Thu, 30 Mar 2006 16:53:24 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [rfc][patch] improved interactive starvation patch against 2.6.16
Message-ID: <20060330145324.GB4914@w.ods.org>
References: <1143713997.9381.28.camel@homer> <20060330115540.GA4914@w.ods.org> <1143728558.7840.11.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143728558.7840.11.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:22:38PM +0200, Mike Galbraith wrote:
 
> You applied the wrong patch.  The inlined one was against virgin 2.6.16,
> for folks to comment on, and the attached was the incremental against
> the 2.6.16 anti-starvation tree.
> 
> Ah, your mailer probably showed both as attached.  Anyway, here's the
> incremental again inlined.

Ah OK, it's not even the mailer, it's me. I read the message and did not
notice the attachment, just the inline patch. Then I forwarded it to my
work address and lost the attachment. You know the rest ...

> (note to self:  never include patches for two trees in same message)

Good advice. Or manually edit the directory name in the diff to
explicitly show what it refers to. Eg:

--- linux-2.6.16-sched7/kernel/sched.c	2006-03-27 06:11:01.000000000 +0200
+++ linux-2.6.16/kernel/sched.c	2006-03-30 10:50:46.000000000 +0200

Anyway, thanks for your reply, I'll re-apply it and recompile.

> 	-Mike

Cheers,
Willy

