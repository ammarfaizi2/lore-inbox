Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbULMSEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbULMSEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 13:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULMSEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 13:04:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6660 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261304AbULMSEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:04:50 -0500
Date: Mon, 13 Dec 2004 18:04:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213180441.F24748@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Buesch <mbuesch@freenet.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrea Arcangeli <andrea@suse.de>
References: <20041211142317.GF16322@dualathlon.random> <1102949565.2687.2.camel@localhost.localdomain> <20041213162355.E24748@flint.arm.linux.org.uk> <200412131853.47652.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200412131853.47652.mbuesch@freenet.de>; from mbuesch@freenet.de on Mon, Dec 13, 2004 at 06:53:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 06:53:40PM +0100, Michael Buesch wrote:
> Quoting Russell King <rmk+lkml@arm.linux.org.uk>:
> > the system is idle.  So far, in all my Linux kernel experience, I've
> > yet to see a kernel where it's possible to stay in the idle thread
> > for more than half a second.  (The ARM kernels I run are always
> > configured with IDLE LED support, so I can _see_ when it gets kicked
> > out of the idle thread.)
> 
> I guess IDLE LED support is not in mainline kernel, is it?
> Where can I get it?

It's an ARM only thing, and it's in mainline kernels for ARM platforms
which have general purpose LEDs available.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
