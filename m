Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUHSITx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUHSITx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUHSITx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:19:53 -0400
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:64130 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263784AbUHSITw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:19:52 -0400
Date: Thu, 19 Aug 2004 10:19:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
Cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040819081930.GA30924@elf.ucw.cz>
References: <566B962EB122634D86E6EE29E83DD808182C3774@hdsmsx403.hd.intel.com> <1092895178.25911.194.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092895178.25911.194.camel@dhcppc4>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Can you provide an example where the enum patch
> causes gcc to generate a warning for incorrect code?
> 
> When I drop the wrong enum into a function,
> gcc seems to eat it just as happily as when
> we used u32's.  Maybe I'm missing something.

It will not provide a warning, not for now. Idea was that eventually
sparse could warn or so.

Even with that, it makes it pretty clear for user what is going on,
and hopefully people will actually think before assigning variables
from different enum types.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
