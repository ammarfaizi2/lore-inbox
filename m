Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757476AbWKWVeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476AbWKWVeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbWKWVeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:34:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:14249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1757476AbWKWVeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:34:36 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061123133904.GD5561@ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
	 <1163958727.5977.15.camel@Homer.simpson.net>
	 <200611191958.15152.rjw@sisk.pl>
	 <1163966016.5744.8.camel@Homer.simpson.net>  <20061123133904.GD5561@ucw.cz>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 22:36:44 +0100
Message-Id: <1164317804.6222.11.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 13:39 +0000, Pavel Machek wrote:
> Hi!
> 
> > > > > Sane people use suspend-to-ram, and that's when you need the suspend and 
> > > > > resume debugging.
> > > > 
> > > > Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> > > > AGP card, I have no choices except swsusp or reboot.
> > > 
> > > Have you tried s2ram (http://en.opensuse.org/S2ram)?
> > 
> > Cool.  That shows potential.  On an 2.6.19-rc6-rt4 kernel, it looked
> > like it _might_ have eventually gotten past boot.  At one line of kernel
> > output every ~10 seconds though, I gave up.  Virgin 2.6.19-rc6 went
> > panic with a black screen... have options, will tinker.
> 
> Try that -rt kernel, but turn off dyntick/hires timers. Also try
> hitting keyboard while resuming.

Hmm, I'll try that.  Interesting (read odd from my perspective) that the
rt kernel gets much further.  This is pretty hard to look at.

