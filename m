Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUKMSKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUKMSKl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUKMSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 13:10:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47120 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261862AbUKMSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 13:10:35 -0500
Date: Sat, 13 Nov 2004 18:10:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line status changes.
Message-ID: <20041113181024.A15735@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1099659997.20469.71.camel@localhost.localdomain> <20041109012212.463009c7.akpm@osdl.org> <1099998437.6081.68.camel@localhost.localdomain> <1099998926.15462.21.camel@localhost.localdomain> <20041109132810.A15570@flint.arm.linux.org.uk> <1100006241.15742.6.camel@localhost.localdomain> <20041109144723.C15570@flint.arm.linux.org.uk> <1100011669.16043.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1100011669.16043.28.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 09, 2004 at 02:47:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 02:47:51PM +0000, Alan Cox wrote:
> I'm working on it. It would be helpful if the drivers/serial code would
> use helpers and not dig in places it shouldnt so that the transition can
> be cleaner.

Ok - I've just applied your patch to 8250 and expanded it to cover the
other ARM serial drivers.  Should be merged with Linus' tree tomorrow.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
