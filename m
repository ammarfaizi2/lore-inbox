Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVDEJ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDEJ12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDEJ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:27:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51857 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261649AbVDEJYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:24:47 -0400
Date: Tue, 5 Apr 2005 11:24:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adam Belay <abelay@novell.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [RFC] Driver States
Message-ID: <20050405092423.GA7254@elf.ucw.cz>
References: <1111963367.3503.152.camel@localhost.localdomain> <Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net> <1112222717.3503.213.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112222717.3503.213.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You have a few things here that can easily conflict, and that will be
> > developed at different paces. I like the direction that it's going, but
> > how do you intend to do it gradually. I.e. what to do first?
> 
> I think the first step would be for us to all agree on a design, whether
> it be this one or another, so we can began planning for long term
> changes.
> 
> My arguments for these changes are as follows:

0. I do not see how to gradually roll this in.

>      4. Having responsibilities at each driver level encourages a
>         layered and object based design, reducing code duplication and
>         complexity.

Unfortunately, you'll be retrofiting this to existing drivers. AFAICS,
trying to force existing driver to "layered and object based design"
can only result in mess.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
