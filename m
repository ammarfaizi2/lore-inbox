Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWH1Khw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWH1Khw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWH1Khv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:37:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:951 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964784AbWH1Khu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:37:50 -0400
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: Arjan van de Ven <arjan@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       rmk+lkml@arm.linux.org.uk, akpm@osdl.org, chase.venters@clientec.com,
       B.Steinbrink@gmx.de, jdike@addtoit.com, linux-arch@vger.kernel.org,
       arnd@arndb.de, David Miller <davem@davemloft.net>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <1156759232.5340.36.camel@pmac.infradead.org>
References: <200608281003.02757.ak@suse.de> <200608281028.13652.ak@suse.de>
	 <1156754436.5340.20.camel@pmac.infradead.org>
	 <200608281053.11142.ak@suse.de>
	 <1156759232.5340.36.camel@pmac.infradead.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 12:37:27 +0200
Message-Id: <1156761447.3034.178.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 11:00 +0100, David Woodhouse wrote:
> On Mon, 2006-08-28 at 10:53 +0200, Andi Kleen wrote:
> > 
> > > /usr/include/linux is _not_ a place to dump "reference code" in lieu of
> > > documentation on using kernel interfaces.
> > 
> > At least for the system call interface it was always. It is not
> > my fault you're trying to suddenly redefine it to be something else.
> 
> I'm trying to 'suddenly redefine' kernel headers as something that
> _isn't_ just a library of random crap for people to abuse in userspace
> as they see fit, then whine when something breaks even though it was
> never really guaranteed to work when abused in that way anyway.
> 
> So far, you're just reminding me why that needed to be done.
> 
> > > Besides, the _syscallX implementations in the kernel were generally
> > > unsuitable for use [as a reference implementation]
> > 
> > I disagree. I used them and they worked great for me.

the x86_64 macros use the VDSO page? great! I didn't know that.
But that would make them unusable for kernel use I suspect...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

