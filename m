Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUBTNiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbUBTNe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:34:57 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:10503 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261208AbUBTNbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:31:41 -0500
Date: Fri, 20 Feb 2004 05:31:39 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Tridge <tridge@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040220133139.GA28230@dingdong.cryptoapps.com>
References: <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org> <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <20040220000054.GA5590@mail.shareable.org> <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org> <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 04:24:18PM -0800, Linus Torvalds wrote:

> That said, who actually _uses_ dnotify? The only time dnotify seems
> to come up in discussions is when people complain how badly designed
> it is, and I don't think I've ever heard anybody say that they use
> it and that they liked it ;)

I have code which watches maildir mailboxes using dnotify and it works
great.  I'm not sure I love dnotify but for this purpose it works very
well.


   --cw
