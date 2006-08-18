Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWHRTJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWHRTJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWHRTJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:09:24 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:15886 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932385AbWHRTJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:09:23 -0400
Date: Fri, 18 Aug 2006 20:09:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial issue
Message-ID: <20060818190917.GI21101@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1155862076.24907.5.camel@mindpipe> <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe> <20060818183609.GE21101@flint.arm.linux.org.uk> <1155926405.2924.25.camel@mindpipe> <20060818185209.GF21101@flint.arm.linux.org.uk> <44E60FD3.7040003@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E60FD3.7040003@microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 02:06:59PM -0500, Paul Fulghum wrote:
> Russell King wrote:
> >On Fri, Aug 18, 2006 at 02:40:05PM -0400, Lee Revell wrote:
> >
> >>On Fri, 2006-08-18 at 19:36 +0100, Russell King wrote:
> >>
> >>>On Fri, Aug 18, 2006 at 02:17:04PM -0400, Lee Revell wrote:
> >>>Are you transferring from or two the machine which is having a problem?
> >>>IOW, is the problem machine doing lots of receive or lots of transmit?
> >>>
> >>
> >>Neither uploads nor downloads work in interrupt mode.  Both work in
> >>polled mode.
> >
> >
> >Ho hum.  This probably requires the use of a serial splitter so that
> >an independent known good machine can monitor what's being sent by
> >each end.
> 
> Since you have 2 serial ports, can you test
> using ttyS1 as the console (kernel boot parameter console=ttyS1)
> and do a transfer on ttyS0 (interrupt mode) with a separate
> connection to another machine?

Who are you referring to?  Since your message was addressed to me, one
would assume you want _me_ to do it, but somehow I suspect you're really
asking Lee.  Please be more careful with your To: and CC: _and_ which
message you're replying to.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
