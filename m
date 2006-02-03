Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWBCQCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWBCQCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWBCQCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:02:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36617 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750988AbWBCQCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:02:24 -0500
Date: Fri, 3 Feb 2006 16:02:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060203160218.GA27452@flint.arm.linux.org.uk>
Mail-Followup-To: Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E36850.5030900@aarnet.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 12:57:28AM +1030, Glen Turner wrote:
> 
> Hi Russell,
> 
> Thanks for your response.
> 
> > A normal user can't produce arbitarily formatted
> > kernel messages
> 
> They don't need to provide an entire message, just a
> AT string (a vector which a user could control
> could be a volume label on removable media).

So?

My point stands - if the user can provide an arbitary string to printk,
they can fake any kernel message.  That in itself is a security bug.
If there is an instance of that, then that's the real bug which would
need fixing.

Once those bugs have been fixed, your claimed bug is also magically
fixed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
