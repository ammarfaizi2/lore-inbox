Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTI0KSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 06:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTI0KSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 06:18:22 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:20486 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262105AbTI0KSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 06:18:21 -0400
Subject: Re: Ejecting a CardBus device
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030927082806.A681@flint.arm.linux.org.uk>
References: <1064628015.1393.5.camel@teapot.felipe-alfaro.com>
	 <20030927082806.A681@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1064657889.1381.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Sep 2003 12:18:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-27 at 09:28, Russell King wrote:
> On Sat, Sep 27, 2003 at 04:00:16AM +0200, Felipe Alfaro Solana wrote:
> > How can I tell the CardBus subsystem to eject my CardBus NIC by software
> > with 2.6.0 kernels? In 2.4 I could use "cardctl eject", but I don't know
> > how to do the same on 2.6.0-test5-mm4.
> 
> The same works with 2.6.0-test5.

I doesn't seem to work: "cardctl eject" complains that no pcmcia driver
appears in /proc/devices. Any ideas?

Meanwhile, I'll take a look at the source code of cardctl to see if I
can learn how to force the eject by software.

