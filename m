Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTKRTjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 14:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTKRTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 14:39:04 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:21393 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S263773AbTKRTjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 14:39:01 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <Tj5w.4yi.25@gated-at.bofh.it>
References: <QHxm.193.21@gated-at.bofh.it> <ROZW.3X0.17@gated-at.bofh.it> <RPt5.4TS.9@gated-at.bofh.it> <RQ5t.69U.7@gated-at.bofh.it> <RQf8.6tb.9@gated-at.bofh.it> <Snut.2iY.7@gated-at.bofh.it> <Tg7E.7ST.11@gated-at.bofh.it> <TiVJ.4ko.11@gated-at.bofh.it> <Tj5w.4yi.25@gated-at.bofh.it>
Date: Tue, 18 Nov 2003 20:38:51 +0100
Message-Id: <E1AMBgZ-0000Rp-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003 19:50:18 +0100, you wrote in linux.kernel:

> I'm curious as to why you would think this is better than the CVS gateway.

Both things are tackling different issues.

The CVS gateway means the data (code + checkin comments) is available
in a free format. This means you as a company can do to BK's internal
format whatever you want if you decide the old format is no longer
up to it. The community still has all it wants in CVS format, as long
as you continue the gateway service.

A check-out and keep-up-to-date BK variant is a tool to access the
latest version of a BK-using project (or any tagged version). This
doesn't have to be the kernel obviously. It is still useful for
kernel development - before sending in a patch to Linus' or Marcelo,
people want to check out the latest BK tree to see if their patch
applies cleanly. The CVS gateway, at least the data on kernel.org,
lags behind the BK trees - for 2.4, the CVS repository at kernel.org
still has "-pre9" in the Makefile although rc1 has been released
already and the ChangeLog Marcelo posted indicated that he changed
the Makefile in the BK repo.

The lobotomized BK client would be useful for people who just want
to get the latest code from some project, and nothing else. It means
the project's maintainers wouldn't need to waste effort on creating
.tgz snapshots (or similar); people could instead point to the BK
repository and tell people who don't use closed-source tools on
principle that they can use the loboBK ;) client to get the sources.

As an aside, I personally rsync the CVS repository to be able to use
"cvs diff" quickly (no fun having to contact a remote server on ISDN).
I could use BK but it's not worth the effort for me to learn a new tool.
So a checkout-only BK would not be useful to me, but I can see reasons
why people would want one, outlined above.

-- 
Ciao,
Pascal
