Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLAJlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLAJlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 04:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVLAJlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 04:41:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24331 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932118AbVLAJlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 04:41:18 -0500
Date: Thu, 1 Dec 2005 09:41:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051201094111.GA14726@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <cda58cb80511300821y72f3354av@mail.gmail.com> <20051130162327.GC1053@flint.arm.linux.org.uk> <cda58cb80511300845j18c81ce6p@mail.gmail.com> <20051130165546.GD1053@flint.arm.linux.org.uk> <1133374482.4117.91.camel@baythorne.infradead.org> <20051130190224.GE1053@flint.arm.linux.org.uk> <1133426199.4117.179.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133426199.4117.179.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 08:36:39AM +0000, David Woodhouse wrote:
> On Wed, 2005-11-30 at 19:02 +0000, Russell King wrote:
> > We agree to disagree.  For example, in all probability, ARM will never
> > see a TPM chip, yet it's offered for selection.  Given that, does it
> > really make sense to offer it for ARM?
> 
> You speak of _probability_. Yes, it makes sense to offer it as an
> _option_ for ARM. It just doesn't make sense to put it in the defconfig
> for any of the existing platforms.
> 
> Nobody expects 'allyesconfig' to be something you'd actually want to
> _use_.

In which case why do we restrict floppy to only those machines which
could have floppy?  Why do we restrict IDE to only those platforms
which may have IDE?

Hint: there's already a precident established for *not* offering
configuration options which are pointless.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
