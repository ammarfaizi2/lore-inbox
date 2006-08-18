Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWHRSgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWHRSgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWHRSgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:36:16 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:15628 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030507AbWHRSgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:36:16 -0400
Date: Fri, 18 Aug 2006 19:36:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial issue
Message-ID: <20060818183609.GE21101@flint.arm.linux.org.uk>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Paul Fulghum <paulkf@microgate.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1155862076.24907.5.camel@mindpipe> <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155925024.2924.22.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 02:17:04PM -0400, Lee Revell wrote:
> On Fri, 2006-08-18 at 13:11 -0500, Paul Fulghum wrote:
> > Lee Revell wrote:
> > > But it had no effect.
> > > 
> > > Could it be a hardware-specific bug?  After all VIA chipsets are
> > > notorious for interrupts not working right.
> > > 
> > > Any other suggestions?
> > 
> > I can't think of any. The interrupts are occurring
> > and being serviced. Nothing else seems to be sitting
> > on that interrupt. It's reaching a bit: maybe there
> > is some console output interfering with the
> > file transfer protocol, but it only occurs with
> > interrupt enabled because of some initial timing?
> > (polling mode may delay things enough to work)
> > What protocol is ckermit using? (zmodem, etc)
> > 
> 
> I think it's just using the kermit file transfer protocol.

Are you transferring from or two the machine which is having a problem?
IOW, is the problem machine doing lots of receive or lots of transmit?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
