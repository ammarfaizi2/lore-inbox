Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276764AbRJVPcJ>; Mon, 22 Oct 2001 11:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRJVPcD>; Mon, 22 Oct 2001 11:32:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:52485 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276764AbRJVPbq>; Mon, 22 Oct 2001 11:31:46 -0400
Date: Mon, 22 Oct 2001 11:32:17 -0400
Message-Id: <200110221532.f9MFWH615801@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
X-Newsgroups: linux.dev.kernel
In-Reply-To: <1003597363.866.8.camel@phantasy>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1003597363.866.8.camel@phantasy> rml@tech9.net wrote:
| On Sat, 2001-10-20 at 08:59, Lorenzo Allegrucci wrote:
| > At 03.27 20/10/01 -0400, Robert Love wrote:
| >
| > >* reapply dropped hunk to pgalloc to prevent reentrancy onto per-CPU
| > >data
| > 
| > This above seems to have fixed some spontaneous reboots and oopses
| > I experiencied with 2.4.11 and 2.4.12-1 preempt-kernel patches.
|  
| This is very much what I wanted to hear.  Thank you.  I was hoping to
| clear those issues up.  Let me know of any other problems.  Enjoy.

  Is this safe to try on SMP again? The one-previous 2.4.12-ac3 patch
seems stable on a P5-100+48MB RAM, which I use as a test for things
helping dog-slow systems, did not run well on a BP6 (crashed on first
login). I didn't report it because I try to have some useful info to
report and had no time.

  Also, has this been tested with experimental kernel pcmcia or the real
pcmcia package? The BP6 is my only non-laptop pcmcia.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
