Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVH2Q2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVH2Q2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVH2Q2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:28:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63460 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751111AbVH2Q2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:28:21 -0400
Date: Mon, 29 Aug 2005 09:28:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 04/16] I/O driver for 8250-compatible UARTs
Message-ID: <20050829162821.GB3827@smtp.west.cox.net>
References: <resend.3.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.3.2982005.trini@kernel.crashing.org> <resend.4.2982005.trini@kernel.crashing.org> <20050829171817.A15074@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829171817.A15074@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 05:18:17PM +0100, Russell King wrote:
> On Mon, Aug 29, 2005 at 09:09:37AM -0700, Tom Rini wrote:
> > This is the I/O driver for any 8250-compatible UARTs.
> 
> Ah, obviously its patchbomb time.  2.6.13 must have been released! 8)
> 
> I wish for this stuff to wait until my queue of stuff has gone to
> Linus first - otherwise Linus will probably have a merge headache
> on his hands... unless these patches are against the -mm kernels.

I forsee it as being unlikely that this will hit Linus' tree without
sometime spent in -mm, and probably more time than it will take for your
queue to drain.  But, these are unlikey to cause a headache (new func,
extern for said func, Kconfig around SERIAL_8250_NR_UARTS, it really is
simplier than before :))

-- 
Tom Rini
http://gate.crashing.org/~trini/
