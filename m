Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRJJBow>; Tue, 9 Oct 2001 21:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJJBok>; Tue, 9 Oct 2001 21:44:40 -0400
Received: from [202.135.142.194] ([202.135.142.194]:24843 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S273364AbRJJBoM>;
	Tue, 9 Oct 2001 21:44:12 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: pmckenne@us.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion 
In-Reply-To: Your message of "Tue, 09 Oct 2001 09:11:01 MST."
             <20011009091101.A27319@twiddle.net> 
Date: Wed, 10 Oct 2001 11:39:37 +1000
Message-Id: <E15r8LR-0000wm-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20011009091101.A27319@twiddle.net> you write:
> On Tue, Oct 09, 2001 at 07:03:37PM +1000, Rusty Russell wrote:
> > I don't *like* making Alpha's wmb() stronger, but it is the
> > only solution which doesn't touch common code.
> 
> It's not a "solution" at all.  It's so heavy weight you'd be
> much better off with locks.  Just use the damned rmb_me_harder.

Wow!  I'm glad you're volunteering to audit all the kernel code to fix
this Alpha-specific bug by inserting rmb_me_harder() in all the
critical locations!

Don't miss any!

I look forward to seeing your patch,
Rusty.
--
Premature optmztion is rt of all evl. --DK
