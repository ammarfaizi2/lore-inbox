Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWGGONj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWGGONj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGGONi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:13:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60176 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751212AbWGGONi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:13:38 -0400
Date: Fri, 7 Jul 2006 14:01:48 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch] sharpsl_pm refactor
Message-ID: <20060707140148.GB4239@ucw.cz>
References: <20060707114818.GA5423@elf.ucw.cz> <1152274600.5548.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152274600.5548.67.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This prepares sharpsl_pm.c for collie. Without nested if()s, #ifdefs
> > can be added. 
> 
> I'm unconvinced as to why collie needs an ifdef in there and looking at
> what I think you're leading to, its ugly. Perhaps you could change the 2
> to a variable set by the machine instead or something, depending upon
> your intention.

Well, I hate the if/else maze -- IMO returns are more readable. Anyway
collie needs both count and time checks disabled, AFAICT.

> Rather than post these patches straight to the patch system, perhaps you
> could also post them for discussion first as discussing them once
> they're submitted seems wrong (and we have to remember to remove the
> patch system from the cc).

Sorry about that. Yep, I'm used to work with akpm...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
