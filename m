Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRJVSjv>; Mon, 22 Oct 2001 14:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277581AbRJVSjA>; Mon, 22 Oct 2001 14:39:00 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22514
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277576AbRJVSiv>; Mon, 22 Oct 2001 14:38:51 -0400
Date: Mon, 22 Oct 2001 11:39:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
Message-ID: <20011022113920.A25329@mikef-linux.matchmail.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1003597363.866.8.camel@phantasy> <200110221532.f9MFWH615801@deathstar.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110221532.f9MFWH615801@deathstar.prodigy.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 11:32:17AM -0400, bill davidsen wrote:
> In article <1003597363.866.8.camel@phantasy> rml@tech9.net wrote:
> | On Sat, 2001-10-20 at 08:59, Lorenzo Allegrucci wrote:
> | > At 03.27 20/10/01 -0400, Robert Love wrote:
> | >
> | > >* reapply dropped hunk to pgalloc to prevent reentrancy onto per-CPU
> | > >data
> | > 
> | > This above seems to have fixed some spontaneous reboots and oopses
> | > I experiencied with 2.4.11 and 2.4.12-1 preempt-kernel patches.
> |  
> | This is very much what I wanted to hear.  Thank you.  I was hoping to
> | clear those issues up.  Let me know of any other problems.  Enjoy.
> 
>   Is this safe to try on SMP again? The one-previous 2.4.12-ac3 patch

I'm running:
Now  : 5 day(s), 16:07:02 running Linux
                2.4.12-ac3+netdev_ramdom+preempt+vm_hogstop2 

on 2x366 celeron.  No problems.

There was one compile bug, but that has been resolved.

Mike
