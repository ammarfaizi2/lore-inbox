Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWGJXSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWGJXSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWGJXSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:18:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56455 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965040AbWGJXSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:18:17 -0400
Date: Tue, 11 Jul 2006 01:17:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Message-ID: <20060710231744.GC444@elf.ucw.cz>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se> <1152554328.5320.6.camel@localhost.localdomain> <20060710180839.GA16503@elf.ucw.cz> <Pine.LNX.4.64.0607110035300.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607110035300.17704@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-07-11 00:37:06, Roman Zippel wrote:
> Hi,
> 
> On Mon, 10 Jul 2006, Pavel Machek wrote:
> 
> > APM can only keep interrupts disabled on non-IBM machines, presumably
> > due to BIOS problems.
> 
> Is it possible to disable the timer interrupt before suspend and just 
> reinit the timer afterwards?

I know little about APM...

We know that cli breaks those thinkpads.

Maybe disabling timer on PIC would do the trick? Not sure...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
