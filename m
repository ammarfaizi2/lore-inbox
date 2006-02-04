Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946124AbWBDXUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946124AbWBDXUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946146AbWBDXUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:20:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1946124AbWBDXUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:20:14 -0500
Date: Sat, 4 Feb 2006 23:20:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060204232005.GC24887@flint.arm.linux.org.uk>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <m3lkwse3nz.fsf@defiant.localdomain> <20060203221346.GA10700@flint.arm.linux.org.uk> <m3mzh7ds45.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3mzh7ds45.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 05:08:10PM +0100, Krzysztof Halasa wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> > Stop throwing FUD into this issue.  The original claim was that a
> > non-root user could send arbitary strings via the console system.
> > This was an independent claim from the other issues.
> 
> That is clearly another thing and would probably need to be
> demonstrated. Anyway, the AT* problem[1] doesn't require a user
> action and the fix proposed (if correct) would fix the real AT*
> problem instead.

The problem being discussed in this sub-thread was explicitly related
to just one case - where a _non root_ user may inject AT command
sequences.  Your response in that thread was throwing up random
other issues, and in that respect it's just adding confusion to
the specific issue being discussed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
