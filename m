Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWAICnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWAICnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWAICnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:43:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:46497 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750772AbWAICnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:43:40 -0500
Subject: Re: [GIT PATCH] PCI patches for 2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1136774203.30123.103.camel@localhost.localdomain>
References: <20060106063716.GA4425@kroah.com>
	 <20060106180833.GA14235@kroah.com>
	 <1136774203.30123.103.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 13:44:18 +1100
Message-Id: <1136774659.30123.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Greg, what patches specifically have problems ? Paul is just back
> from vacation and we are trying to catch up with merging the tons of
> pending powerpc stuffs, but we have a couple of requirements with things
> in this list, notably my small export of pci_cfg_space_size() which
> should be trivial, but also Linas error recovery stuff... So if one of
> these is causing problems, we need to know right now as it means we have
> to rebase.

BTW. I looked a linux-pci and only saw 2 complaints about the e1000 and
sym2 driver patches to implement error recovery. I suppose you could
just drop those 2 and keep the infrastructure in. However, I'm a bit
annoyed because Linas did post those patches (and several times I think)
to the relevant lists, and possibly the maintainers (not sure about
that) and no comment was ever made...

I find it fairly annoying (and that's not the first time that happens)
that a major piece of work gets posted publically several times, nobody
bothers to comment, and by the time it gets send for merging upstream,
suddenly, people wakeup from all over the place NAK'ing it for all sort
of reasons, mostly claiming it wasn't properly reviewed by the
appropriate maintainers...

Ben.

