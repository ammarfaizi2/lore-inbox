Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUB2SLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 13:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUB2SLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 13:11:19 -0500
Received: from gprs154-126.eurotel.cz ([160.218.154.126]:42114 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262090AbUB2SLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 13:11:10 -0500
Date: Sun, 29 Feb 2004 19:10:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040229181053.GD286@elf.ucw.cz>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x4qt93i6y.fsf@kth.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
> >> > It seems noone is maintaining it, equivalent functionality is provided
> >> > by swsusp, and it is confusing users...
> >> 
> >> It may be ugly, it may be unmaintained, but I get the impression that it
> >> works for some people for whom swsusp doesn't. So unless swsusp works for
> >> everyone or Nigel's swsusp2 is merged, I'd suggest leaving that in.
> >
> > Do you have example when pmdisk works and swsusp does not? I'm not
> > aware of any in recent history...
> 
> For me, none of them (pmdisk, swsusp and swsusp2) work.  I did manage
> to get pmdisk to resume once, and swsusp2 makes it half-way through
> the resume.  The old swsusp doesn't even get that far.

Try current swsusp with minimal drivers, init=/bin/bash.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
