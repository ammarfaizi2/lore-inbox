Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275353AbTHSFp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275357AbTHSFpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:45:55 -0400
Received: from waste.org ([209.173.204.2]:59059 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275353AbTHSFpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:45:55 -0400
Date: Tue, 19 Aug 2003 00:45:38 -0500
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030819054538.GA23889@waste.org>
References: <3F4182FD.3040900@cyberone.com.au> <20030819023536.GZ32488@holomorphy.com> <3F418F7A.7090007@cyberone.com.au> <3F4192AD.1020305@cyberone.com.au> <20030819051533.GL16387@waste.org> <3F41B6CE.1000407@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F41B6CE.1000407@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 03:34:06PM +1000, Nick Piggin wrote:
> Matt Mackall wrote:
> 
> >
> >You forgot to mention fork() splitting its timeslice 2/3 to 1/3 parent
> >to child.
> >
> >
> 
> Hmm... did I do that? I don't actually have the code in front of me, but I
> think the timeslice split is still 50/50 (see fork.c). Its the priority
> points that go 2/3 to 1/3. Actually its a bit more complex than that even
> and probably not exactly right...

Actually, it's as you say. The terms sleeptime and timeslice just
confused me.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
