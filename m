Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTARC7s>; Fri, 17 Jan 2003 21:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTARC7s>; Fri, 17 Jan 2003 21:59:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:48520 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262089AbTARC7r>; Fri, 17 Jan 2003 21:59:47 -0500
Subject: Re: [PATCH][RESEND] linux-2.5.58_timer-tsc-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030118025509.C295F2C0D0@lists.samba.org>
References: <20030118025509.C295F2C0D0@lists.samba.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042858925.32472.11.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 19:02:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 17:48, Rusty Russell wrote:
> In message <1042676113.1515.129.camel@w-jstultz2.beaverton.ibm.com> you write:
> > Linus, All,
> > 	This patch cleans up the timer_tsc code, removing the unused use_tsc
> > variable and making fast_gettimeoffset_quotient static.
> 
> But use_tsc is still used:

Yep, this was pointed out earlier today. My bad. The cpu_freq updates
that went in a tad bit less then 2 weeks ago slipped it in and I just
didn't notice. I apologize. Thanks for looking at it, though. 

> 
> And almost any patch to the x86 boot code is too convoluted to be
> "trivial" IMHO.

Ok, sounds fair.

Thanks
-john


