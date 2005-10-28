Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVJ1VkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJ1VkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbVJ1VkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:40:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750789AbVJ1VkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:40:12 -0400
Date: Fri, 28 Oct 2005 22:40:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051028214000.GB24432@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
	Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
	vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200510271026.10913.ak@suse.de> <20051028205132.GB11397@elf.ucw.cz> <20051028205916.GL4464@flint.arm.linux.org.uk> <200510282322.16627.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510282322.16627.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 11:22:15PM +0200, Andi Kleen wrote:
> On Friday 28 October 2005 22:59, Russell King wrote:
> > On Fri, Oct 28, 2005 at 10:51:32PM +0200, Pavel Machek wrote:
> > > Well, keyboard detected and reported an error. Kernel reacted with
> > > printk(). You are removing that printk(). I can understand that,
> > > printk is really annoying, but I really believe _some_ error handling
> > > should be added there if you remove the printk.
> > 
> > What do you suggest?
> 
> Obviously it needs an DBUS over netlink interface with an user space daemon to open 
> a window on the desktop. Then the user needs to click ok to make sure they 
> understood they did something wrong (either by buying broken hardware or by simply 
> typing).
> 
> You get bonus points when that window first opens another window with a "Did you 
> know ..." message with a little dancing pink penguin that gives you helpful tips 
> regarding typing on keyboards and offers you links to buy new keyboards on the web.
> 
> Wouldn't that be great?

Sounds like too much hastle.  I heard an alternative suggestion somewhere
which I liked much better <evil grin>.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
