Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267848AbUG3XG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267848AbUG3XG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267868AbUG3XG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:06:57 -0400
Received: from gprs214-87.eurotel.cz ([160.218.214.87]:29829 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267848AbUG3XGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:06:55 -0400
Date: Sat, 31 Jul 2004 01:06:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>, dbrownell@users.sourceforge.net
Subject: Re: Solving suspend-level confusion
Message-ID: <20040730230638.GA28908@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <1091227170.7389.5.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091227170.7389.5.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What do you think?
> 
> Your constants are ugly ;) But the whole idea makes sense, I've started
> implementing something on my side, though I didn't change the u32 to an
> enum to avoid having to "fix" bazillions of drivers. Proper
> documentation may just be enough...

Good. (Well, I'd still like to migrate to enums, eventually, so it
is not easy to confuse, but...)

> > PS: I'll be on holidays for a week, feel free to implement this or
> > something similar.. it is going to be lot of search/replace in drivers
> > :-(.
> 
> I'll have some patches soon along with the PPC stuff.

I'm looking forward...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
