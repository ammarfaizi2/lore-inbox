Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWDYSvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWDYSvC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWDYSvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:51:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34412 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751284AbWDYSvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:51:01 -0400
Date: Tue, 25 Apr 2006 20:51:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler question 2.6.16.x
Message-ID: <20060425185142.GS4102@suse.de>
References: <200604251905.19004.nick@linicks.net> <20060425181530.GQ4102@suse.de> <200604251933.48363.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604251933.48363.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2006, Nick Warne wrote:
> On Tuesday 25 April 2006 19:15, Jens Axboe wrote:
> 
> > > But I can build both in... so I guess then the kernel decides what is
> > > the best to use?  Or should it be so I am only allowed to select one
> > > or the other and allowing both is an oversight?
> >
> > See the option no more than two lines down from that, default io
> > scheduler. Also see Documentation/block/switching-sched.txt and/or
> > Documentation/kernel-parameters.txt (elevator=) section.
> 
> Hi Jens,
> 
> I haven't got the switching-sched.txt, although I found a
> sched-design.txt...  but what I meant was if I select whatever
> default, do/can I still need to select either/or scheduler?
> 
> i.e. why doesn't 'default selection option' only allow that scheduler
> to be selected?

I don't understand your question, but here's how it works. You can
select as many/few schedulers as you want. You can only set a scheduler
default, if it's compiled in (y, not m). If you don't select any
schedulers, noop is still selected and wil be the default.

Just try the options, you'll see how they work...

-- 
Jens Axboe

