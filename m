Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVLFAva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVLFAva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLFAva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:51:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17891 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964890AbVLFAva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:51:30 -0500
Date: Tue, 6 Dec 2005 01:51:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206005106.GE1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <200512060005.04556.rjw@sisk.pl> <20051206001256.GM22168@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206001256.GM22168@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Alternatively, you can increase the value of PAGES_FOR_IO, defined
> > in include/linux/suspend.h.  To see any effect, you'll probably have to
> > increase it by tens of thousands, but please note the box may be unable
> > to suspend if it's too great (if you try this anyway, please let me know what
> > number seems to be the best to you).
> > 
> > Also, I can create a patch to improve this a bit, if you promise to help
> > test/debug it. ;-)
> 
> I'll play with this a bit tonight but I'd love to see a patch that makes
> it a tunable.  Rebooting my laptop is sloooow and annoying (due to slow
> startup scripts and losing all my state), but trying various suspend
> settings sounds like a fun experiment.

init=/bin/bash, and you can get rid of startup scripts ;-).
								Pavel
-- 
Thanks, Sharp!
