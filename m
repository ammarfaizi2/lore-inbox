Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWIJJeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWIJJeY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIJJeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:34:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24329 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750814AbWIJJeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 05:34:23 -0400
Date: Sat, 9 Sep 2006 12:11:34 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060909121134.GC4277@ucw.cz>
References: <20060908031422.GA4549@lists.us.dell.com> <20060908112035.f7a83983.akpm@osdl.org> <450283D5.1020404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450283D5.1020404@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I wanted to note what Martin Mares just raised in the 
> thread "State of the Linux PCI Subsystem for 2.6.18-rc6":
> 
> >Changing the device order in the middle of the 2.6 
> >cycle doesn't sound
> >like a sane idea to me. Many people have changed their 
> >systems' configuration
> >to adapt to the 2.6 ordering and this patch would break 
> >their setups.
> >I have seen many such examples in my vicinity.
> >
> >I believe that not breaking existing 2.6 setups is much 
> >more important
> >than keeping compatibility with 2.4 kernels, especially 
> >when the problem
> >is discovered after more than 2 years after release of 
> >the first 2.6.
> 
> 
> I'm not siding with either Martin or Matt explicitly, 
> just noting that there are good arguments for both sides.

I agree with martin here. 'Lets break all the machines where people
are currently using 2.6.x, for benefit of people currently running
2.4.x' is *very* bad idea.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
