Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267641AbUBTA6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267636AbUBTAzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:55:21 -0500
Received: from mail.shareable.org ([81.29.64.88]:32384 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267641AbUBTAy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:54:26 -0500
Date: Fri, 20 Feb 2004 00:54:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040220005421.GE5590@mail.shareable.org>
References: <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org> <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <20040220000054.GA5590@mail.shareable.org> <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org> <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> That said, who actually _uses_ dnotify? The only time dnotify seems to 
> come up in discussions is when people complain how badly designed it is, 
> and I don't think I've ever heard anybody say that they use it and 
> that they liked it ;)

I've not used it, but I have plenty of ideas (see the other email),
and one big project I'm working on that intends to use it, which isn't
a file manager.

I must say it is badly designed and I don't like it :)

Actually the design is ok because it's easy to understand.  It is just
a bit limiting for more adventurous purposes than a file manager.

Something that fitted nicely into the epoll style of event queue, and
also allowed whole directory trees to be monitored, and told exactly
what changed, and let you take out leases on files that caught writing
as well as opens, and worked even across reboots or with no program
running (using generation numbers of some kind).... that I'd like a
tiny bit more :)

-- Jamie
