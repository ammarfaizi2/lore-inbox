Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVHEH61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVHEH61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVHEH60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:58:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6810 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262901AbVHEH6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:58:23 -0400
Date: Tue, 1 Jan 2002 08:53:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20020101075339.GA467@openzaurus.ucw.cz>
References: <20050726015401.GA25015@kroah.com> <20050728190352.GA29092@kroah.com> <9e47339105072812575e567531@mail.gmail.com> <200507282310.23152.oliver@neukum.org> <9e47339105072814125d0901d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072814125d0901d9@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > New, simplified version of the sysfs whitespace strip patch...
> > 
> > Could you tell me why you don't just fail the operation if malformed
> > input is supplied?
> 
> Leading/trailing white space should be allowed. For example echo
> appends '\n' unless you know to use -n. It is easier to fix the kernel
> than to teach everyone to use -n.

Please, NO! echo -n is the right thing to do, and users will eventually learn.
We are not going to add such workarounds all over the kernel...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

