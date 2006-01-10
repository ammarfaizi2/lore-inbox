Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWAJAng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWAJAng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWAJAng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:43:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751797AbWAJAnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:43:35 -0500
Date: Mon, 9 Jan 2006 16:43:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
In-Reply-To: <20060110002818.GD15083@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0601091641000.5588@g5.osdl.org>
References: <43C165CE.AF913697@tv-sign.ru> <20060110002818.GD15083@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Paul E. McKenney wrote:
> 
> This patch looks sane to me.  It passes a short one-hour rcutorture
> on ppc64 and x86, firing up some overnight runs as well.
> 
> Dipankar, Manfred, any other concerns?  Cacheline alignment?  (Seems
> to me this code is far enough from the fastpath that this should not
> be a problem, but thought I should ask.)

I'd ask you and Oleg to re-synchronize, and perhaps Oleg to re-send the 
(part of?) the series that has no debate. I'm unsure, for example, whether 
#2 was just to be dropped.

I already applied #1, and it looks like there's agreement on #3 and #4, 
but basically, just to make sure, can Oleg please re-send to make sure I 
got it right?

Getting a screwed-up RCU thing is going to be too painful to debug, so I'd 
rather get it right the first time it hits my tree..

		Linus
