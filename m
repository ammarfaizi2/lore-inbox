Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWBCWNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWBCWNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWBCWNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:13:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29449 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750735AbWBCWNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:13:54 -0500
Date: Fri, 3 Feb 2006 22:13:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060203221346.GA10700@flint.arm.linux.org.uk>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <m3lkwse3nz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3lkwse3nz.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 06:46:24PM +0100, Krzysztof Halasa wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> > My point stands - if the user can provide an arbitary string to printk,
> > they can fake any kernel message.  That in itself is a security bug.
> > If there is an instance of that, then that's the real bug which would
> > need fixing.
> 
> I think the AT problem is valid - the user doesn't have to be able to
> send anything to the console, the system alone can screw it up with
> something as simple as ATZ^M (or with almost any string with embedded
> [aA][tT].*^M).

Stop throwing FUD into this issue.  The original claim was that a
non-root user could send arbitary strings via the console system.
This was an independent claim from the other issues.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
