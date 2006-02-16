Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWBPTDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWBPTDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWBPTDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:03:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932319AbWBPTDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:03:06 -0500
Date: Thu, 16 Feb 2006 19:02:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tejun Heo <htejun@gmail.com>, Matt Reimer <mattjreimer@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] block: convert IDE to use blk_kmap helpers
Message-ID: <20060216190259.GH29443@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Tejun Heo <htejun@gmail.com>, Matt Reimer <mattjreimer@gmail.com>,
	linux-kernel@vger.kernel.org
References: <11371658562541-git-send-email-htejun@gmail.com> <1137165856390-git-send-email-htejun@gmail.com> <f383264b0602141107v78864d7bua38fbaeefafd5@mail.gmail.com> <43F28C4E.1090104@gmail.com> <20060216180125.GE29443@flint.arm.linux.org.uk> <Pine.LNX.4.64.0602161008490.916@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602161008490.916@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 10:10:59AM -0800, Linus Torvalds wrote:
> On Thu, 16 Feb 2006, Russell King wrote:
> > Linus - can we merge Tejun's patches so that we have an IDE subsystem
> > which works on ARM platforms please?  If James wants to come up with
> > another solution later on, I'm sure we can transition all drivers
> > over to that new solution once we know what it is.  Until then, can
> > we please fix the bug?
> 
> I'm assuming this isn't a regression, and that it's just been that way 
> forever. If so, I'm going to vote for it being merged after 2.6.16 is out. 
> We don't need more new stuff, and I think PXA users can either apply the 
> patches themselves, or wait a few weeks more..
> 
> But if this is actually a regression from 2.6.15, I want to know more 
> about it.

It's a long standing bug, so given that it can wait for post 2.6.16.
I just didn't want to have this situation continuing indefinitely.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
