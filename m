Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934448AbWKXGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934448AbWKXGhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 01:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934447AbWKXGhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 01:37:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:20707 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S934448AbWKXGhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 01:37:03 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200611232236.58444.rjw@sisk.pl>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <20061123133904.GD5561@ucw.cz> <1164317804.6222.11.camel@Homer.simpson.net>
	 <200611232236.58444.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 07:39:10 +0100
Message-Id: <1164350350.6128.9.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 22:36 +0100, Rafael J. Wysocki wrote:
> On Thursday, 23 November 2006 22:36, Mike Galbraith wrote:
> > On Thu, 2006-11-23 at 13:39 +0000, Pavel Machek wrote:
> > > 
> > > Try that -rt kernel, but turn off dyntick/hires timers. Also try
> > > hitting keyboard while resuming.
> > 
> > Hmm, I'll try that.  Interesting (read odd from my perspective) that the
> > rt kernel gets much further.  This is pretty hard to look at.
> 
> Is your system an i386?

Yeah, single P4/HT supermarket box.

I tried the dynticks/hires-timers/kbd suggestion, no difference.  It
still boots in medicated snail mode, and emits a stream of IRQ9: nobody
cared messages (fasteoi acpi, irqpoll = nogo) while doing so.

	-Mike

