Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWBPSLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWBPSLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBPSLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:11:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932545AbWBPSLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:11:09 -0500
Date: Thu, 16 Feb 2006 10:10:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Tejun Heo <htejun@gmail.com>, Matt Reimer <mattjreimer@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] block: convert IDE to use blk_kmap helpers
In-Reply-To: <20060216180125.GE29443@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0602161008490.916@g5.osdl.org>
References: <11371658562541-git-send-email-htejun@gmail.com>
 <1137165856390-git-send-email-htejun@gmail.com>
 <f383264b0602141107v78864d7bua38fbaeefafd5@mail.gmail.com> <43F28C4E.1090104@gmail.com>
 <20060216180125.GE29443@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Russell King wrote:
> 
> Linus - can we merge Tejun's patches so that we have an IDE subsystem
> which works on ARM platforms please?  If James wants to come up with
> another solution later on, I'm sure we can transition all drivers
> over to that new solution once we know what it is.  Until then, can
> we please fix the bug?

I'm assuming this isn't a regression, and that it's just been that way 
forever. If so, I'm going to vote for it being merged after 2.6.16 is out. 
We don't need more new stuff, and I think PXA users can either apply the 
patches themselves, or wait a few weeks more..

But if this is actually a regression from 2.6.15, I want to know more 
about it.

			Linus
