Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWDYSOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWDYSOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWDYSOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:14:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6737 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932270AbWDYSOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:14:51 -0400
Date: Tue, 25 Apr 2006 20:15:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler question 2.6.16.x
Message-ID: <20060425181530.GQ4102@suse.de>
References: <200604251905.19004.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604251905.19004.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2006, Nick Warne wrote:
> Hi all,
> 
> I see in menuconfig I have two options:
> 
> <*> Anticipatory I/O scheduler
> <*> Deadline I/O scheduler
> 
> Help reveals Anticipatory is pretty good, but make a slightly larger
> kernel - Deadline help says it a good alternative to Anticipatory.
> 
> But I can build both in... so I guess then the kernel decides what is
> the best to use?  Or should it be so I am only allowed to select one
> or the other and allowing both is an oversight?

See the option no more than two lines down from that, default io
scheduler. Also see Documentation/block/switching-sched.txt and/or
Documentation/kernel-parameters.txt (elevator=) section.

-- 
Jens Axboe

