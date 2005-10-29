Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVJ2TvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVJ2TvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVJ2TvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:51:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17166 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750786AbVJ2TvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:51:22 -0400
Date: Sat, 29 Oct 2005 20:51:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Luck <tony.luck@gmail.com>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <20051029195115.GD14039@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Luck <tony.luck@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 11:57:30AM -0700, Tony Luck wrote:
> > - Process continues until the kernel is considered "ready", the
> > process should last three months ( 4 kernels per yeard should be
> > released).
> IIRC the goal was to make a release in around 8 weeks (which would
> be closer to six per year).  But you have the important part, which is
> that Linus doesn't make the release until it is "ready".  2.6.13 was
> released on August 28th, and 2.6.14 on October 27th ... so we
> appear to have hit the goal this time through.

However, three months is _far_ too long.  Look at what is happening
post-2.6.14?  There's loads of really huge changes going in which
were backed up over the last two months.

Continuing like this will just push the release of each kernel further
and further out as there's more stuff merged during the mayhem than
can possibly be properly reviewed and tested.

Shorter release cycles means that there's less mayhem, which in turn
means more time to review.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
