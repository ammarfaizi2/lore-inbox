Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbTJGASX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJGASX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 20:18:23 -0400
Received: from [66.212.224.118] ([66.212.224.118]:14605 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261800AbTJGASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 20:18:22 -0400
Date: Mon, 6 Oct 2003 20:18:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Domen Puncer <domen@coderock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-Reply-To: <200310070144.47822.domen@coderock.org>
Message-ID: <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
References: <200310061529.56959.domen@coderock.org> <200310070033.53590.domen@coderock.org>
 <Pine.LNX.4.53.0310061842030.19396@montezuma.fsmlabs.com>
 <200310070144.47822.domen@coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Domen Puncer wrote:

> On Tuesday 07 of October 2003 00:43, Zwane Mwaikambo wrote:
> > On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > > Ok, could you send your .config too, i use the 3c59x driver and haven't
> > > > noticed this in 2.6.0-test5-mm4. My card is;
> > >
> > > .config at the end of mail
> >
> > Sorry i forgot to ask for a dmesg too (from a kernel exhibiting the
> > problem)
> 
> 0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.19
> eth0: no IPv6 routers present
> eth0: Setting full-duplex based on MII #24 link partner capability of 0141.

What is your link peer?

> Might be relevant... the last line is lagged a couple of seconds, and network
> works fine before i see that line in dmesg.

I'm also curious as to why mii-tool doesn't work, can you attach an strace 
mii-tool eth0?

