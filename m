Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTIATJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTIATJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:09:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45574 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263196AbTIATJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:09:57 -0400
Date: Mon, 1 Sep 2003 21:02:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64 bit jiffies for 2.4.23-pre2
Message-ID: <20030901190210.GA24145@alpha.home.local>
References: <Pine.LNX.4.44.0309011509270.6008-100000@logos.cnet> <Pine.LNX.4.33.0309012024320.26435-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309012024320.26435-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 08:28:31PM +0200, Tim Schmielau wrote:
> On Mon, 1 Sep 2003, Marcelo Tosatti wrote:
> 
> > > I think it's the most appropriate solution for 2.4. But you need to decide
> > > whether you take this, whether someone should backport the (intrusive and
> > > architecture-dependent) 2.6 fix, or whether you drop it completly and let
> > > people just upgrade to 2.6.
> >
> > Sincerely, I prefer people use 2.6.
> 
> OK, for people wanting this in their private trees, I'll try to keep an
> up-to-date version at
> 
>   http://www.physik3.uni-rostock.de/tim/kernel/2.4/

Ok, thanks Tim, I'll keep including it in my kernel since it allows my systems
to live such a long life :-) But I don't think they will ever beat Alan's box
which lasted 1100 days on 1.2.13 ! And that would not be reasonable because
even for security reasons, you sometimes have to upgrade.

BTW, that reminds me of Netware's patches that were basically hot fixes that
you could apply without shutting the system down. That was really wonderful a
feature that I would love to see on Linux. This is already doable with modules,
but not with the system core.

Regards,
Willy

