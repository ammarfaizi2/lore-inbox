Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWGHMYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWGHMYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGHMYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:24:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17060 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964804AbWGHMYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:24:41 -0400
Date: Sat, 8 Jul 2006 14:24:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       kristen.c.accardi@intel.com
Subject: Re: 2.6.18-rc1: breaks boot on thinkpad x32 -- acpiphp problems?
Message-ID: <20060708122427.GA2484@elf.ucw.cz>
References: <20060707105041.GA1656@elf.ucw.cz> <20060707040156.e385670e.akpm@osdl.org> <20060708120635.GA1585@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708120635.GA1585@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I tried to update to 2.6.18-rc1-git, but got hang after
> > > 
> > > acpiphp: Slot [1] registered
> > > 
> > > ...but acpi=off failed to workaround the problem, it merely hung at
> > > another place. I went back to 2.6.18-rc1, and it hung at same
> > > place.
> > 
> > There have been no post-2.6.18-rc1 commits yet.
> >
> > >  2.6.17 works. Any ideas?
> > 
> > Nope.  Is the hang during initial bootup or during modprobing?
> 
> > If during initial bootup, try adding initcall_debug to the boot
> > command line.
> 
> Initial bootup, I basically do not use modules.
> 
> It hangs at the same place... but with with acpi=off, I can see it
> hanging at acpi_ac_init. What is going on?
> 
> Why is acpiphp being initialized with acpi=off?
> 
> Will try disabling acpiphp in config and see what happens.

With acpiphp disabled, machine indeed boots properly.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
