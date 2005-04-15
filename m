Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVDOCcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDOCcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 22:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVDOCcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 22:32:55 -0400
Received: from waste.org ([216.27.176.166]:27880 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261723AbVDOCct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 22:32:49 -0400
Date: Thu, 14 Apr 2005 19:32:32 -0700
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fix never executed code due to expression always false
Message-ID: <20050415023232.GR25554@waste.org>
References: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost> <425F064E.8050003@yahoo.com.au> <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost> <425F0735.6010407@yahoo.com.au> <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost> <425F096F.2020303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F096F.2020303@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 10:23:11AM +1000, Nick Piggin wrote:
> Jesper Juhl wrote:
> 
> >
> >As per this patch perhaps? : 
> >
> 
> Thanks. I'll make sure it gets to the right place if nobody picks it up.

Perhaps this ought to be wrapped up in sched_clock_before() or some
such.

-- 
Mathematics is the supreme nostalgia of our time.
