Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTEHKaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 06:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTEHKaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 06:30:21 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:43399 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S261259AbTEHKaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 06:30:21 -0400
Date: Thu, 8 May 2003 03:42:51 -0700
To: Ming Lei <lei.ming@attbi.com>
Cc: linux-kernel@vger.kernel.org, "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: linux rt priority  thread corrupt  global variable?
Message-ID: <20030508104251.GA21537@gnuppy.monkey.org>
References: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com> <20030508095238.GA20844@gnuppy.monkey.org> <20030508095911.GA20934@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508095911.GA20934@gnuppy.monkey.org>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:59:11AM -0700, Bill Huey wrote:
> On Thu, May 08, 2003 at 02:52:38AM -0700, Bill Huey wrote:
> > No, it's not a fully preemptive kernel, but spreads preemption points
> > throughout the source tree, both directly and indirectly, instead. Spinlocks
> > are the primary mutex of choice in Linux and create atomic critical sections
> > that can't be preempted with respect to the normal Linux scheduler. Fully
> 
> Geez, this isn't exactly right either, my brain is failing me at the moment.

I was right the first time. :) Just remember why breaking a spinlock is
a bad thing to do. :)

bill

