Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVDASgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVDASgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVDASdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:33:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:49327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262844AbVDASdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:33:02 -0500
Date: Fri, 1 Apr 2005 10:32:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, mingo@elte.hu,
       christoph@lameter.com, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-Id: <20050401103235.1fcea9f0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504010807570.4774@ppc970.osdl.org>
References: <424D373F.1BCBF2AC@tv-sign.ru>
	<Pine.LNX.4.58.0504010807570.4774@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Fri, 1 Apr 2005, Oleg Nesterov wrote:
> >
> > This patch replaces and updates 6 timer patches which are currently
> > in -mm tree. This version does not play games with __TIMER_PENDING
> > bit, so incremental patch is not suitable. It is against 2.6.12-rc1.
> > Please comment. I am sending pseudo code in a separate message for
> > easier review.
> 
> Looks ok by me. Andrew, should we let it cook in -mm, or what?
> 

Sure.  Christoph and (I think) Ken have been seeing mysterious misbehaviour
which _might_ be due to Oleg's first round of timer patches.  I assume C&K
will test this new patch?
