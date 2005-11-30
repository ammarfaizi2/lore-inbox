Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbVK3TCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbVK3TCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbVK3TCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:02:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39696 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751508AbVK3TCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:02:31 -0500
Date: Wed, 30 Nov 2005 19:02:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051130190224.GE1053@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <cda58cb80511300821y72f3354av@mail.gmail.com> <20051130162327.GC1053@flint.arm.linux.org.uk> <cda58cb80511300845j18c81ce6p@mail.gmail.com> <20051130165546.GD1053@flint.arm.linux.org.uk> <1133374482.4117.91.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133374482.4117.91.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 06:14:42PM +0000, David Woodhouse wrote:
> On Wed, 2005-11-30 at 16:55 +0000, Russell King wrote:
> > So until someone says "I want to use this on such and such arch" I
> > think it's better to keep it dependent on those we know are likely
> > to support it.
> 
> I disagree; unless there's a reason why it _shouldn't_ work on a given
> architecture, it should be possible to enable it there.

We agree to disagree.  For example, in all probability, ARM will never
see a TPM chip, yet it's offered for selection.  Given that, does it
really make sense to offer it for ARM?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
