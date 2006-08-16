Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWHPXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWHPXTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWHPXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:19:33 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:44554 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751225AbWHPXTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:19:32 -0400
Date: Thu, 17 Aug 2006 00:19:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Paul Fulghum <paulkf@microgate.com>, Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060816231926.GC12407@flint.arm.linux.org.uk>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Paul Fulghum <paulkf@microgate.com>,
	Raphael Hertzog <hertzog@debian.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain> <20060816231033.GB12407@flint.arm.linux.org.uk> <1155770107.8796.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155770107.8796.14.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:15:06PM -0400, Lee Revell wrote:
> On Thu, 2006-08-17 at 00:10 +0100, Russell King wrote:
> > MIDI uses its own driver - sound/drivers/serial-u16550.c.  My guess
> > is there's something in the system starving interrupt servicing.
> > Serial is very sensitive to that, and increases in other system
> > latencies tends to have an adverse impact on serial.
> 
> Have you seen many other reports of serial working reliably in 2.4 but
> not in 2.6?  Right now this is the only clue I have to go on...

There have been one or two, but the above is basically as far as I've
got.  Unfortunately, I don't have any machines slow enough (or maybe
with the right hardware) to exhibit the problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
