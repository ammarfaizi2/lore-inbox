Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUBSMkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUBSMkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:40:22 -0500
Received: from test.estpak.ee ([194.126.115.47]:47315 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S267231AbUBSMkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:40:17 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: Paul Jakma <paul@clubi.ie>
Subject: Re: raw sockets and blocking
Date: Thu, 19 Feb 2004 14:40:01 +0200
User-Agent: KMail/1.6.1
Cc: Jamie Lokier <jamie@shareable.org>, David Schwartz <davids@webmaster.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com> <20040219075343.GA4113@mail.shareable.org> <Pine.LNX.4.58.0402190831200.25392@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.58.0402190831200.25392@fogarty.jakma.org>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402191440.01035.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> On Thu, 19 Feb 2004, Jamie Lokier wrote:
> > I hate to check the obvious, but did you try setting the
> > O_NONBLOCK flag for the socket?  Did you try setting the
> > MSG_DONTWAIT flag for the sendmsg operation?
>
> We're select() driven, so the problem is not that the process
> literally blocks and sleeps, its that the socket never becomes
> ready to write again.

And maybe it makes sense to mention that all packets ospf daemon sends 
to actually down ethernet interface are multicast packets.

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
