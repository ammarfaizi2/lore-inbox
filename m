Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWCYE4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWCYE4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWCYE4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:56:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750936AbWCYE4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:56:45 -0500
Date: Fri, 24 Mar 2006 20:53:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 grub oddness
Message-Id: <20060324205310.38ce20bf.akpm@osdl.org>
In-Reply-To: <1143262501.7930.4.camel@homer>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<1143201413.7741.53.camel@homer>
	<20060324102537.1d426594.akpm@osdl.org>
	<1143262501.7930.4.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> On Fri, 2006-03-24 at 10:25 -0800, Andrew Morton wrote:
> > Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > Greetings,
> > > 
> > > I'm seeing strange things with grub with this kernel.  After my box has
> > > been up for a while, and I reboot, selecting a kernel to restart, upon
> > > reboot, I sometimes (fairly often) get a blank screen staring at me
> > > though I see grub doing it's thing.  Poking the power button results in
> > > an immediate poweroff, not as if the kernel had panicked or whatnot very
> > > early in boot.  Very odd, and never before seen.
> > > 
> > 
> > Do you mean that grub is actually proceeding as expected, just that the
> > display is off?  If so, does it ever come back on?
> 
> No, the box just sits there and does nada.
> 

Did you try disabling fbdev?
