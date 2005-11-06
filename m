Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVKFWRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVKFWRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVKFWRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:17:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16914 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932307AbVKFWRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:17:08 -0500
Date: Sun, 6 Nov 2005 22:16:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [RFC] IRQ type flags
Message-ID: <20051106221643.GB6274@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <1131316897.1212.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131316897.1212.61.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 10:41:37PM +0000, Alan Cox wrote:
> On Sul, 2005-11-06 at 08:40 +0000, Russell King wrote:
> > Finally, the SA_TRIGGER_* flag passed to request_irq() should reflect
> > the property that the device would like.  The IRQ controller code
> > should do its best to select the most appropriate supported mode.
> > 
> > Comments?
> 
> This is actually true of some x86 hardware in the EISA space where there
> is a control register for level v edge that we sort of half deal with.

Thanks Alan.  Can I assume you're happy with the patch, even if x86
currently ignores the flags?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
