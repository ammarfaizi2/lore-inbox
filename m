Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUHBSyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUHBSyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHBSyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:54:40 -0400
Received: from mail.tmr.com ([216.238.38.203]:51463 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261563AbUHBSyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:54:38 -0400
Date: Mon, 2 Aug 2004 14:48:51 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
In-Reply-To: <m38yd3j02q.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.3.96.1040802144144.17578B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Krzysztof Halasa wrote:

> Bill Davidsen <davidsen@tmr.com> writes:
> 
> > And akpm posted that he intended to remove cryptoloop, while others
> > are calling for the end to devfs. Not having features disappear is
> > part of stable, I would think, not just "not oops more often."
> 
> OTOH removing things declared "obsolete" for a long time doesn't make
> it unstable - does it?

Obsolete for a long time? This is a new feature in 2.6! It was just added
and was the hook that got some people to go to 2.6 in some cases, to have
some useful security in laptops. To remove it would effectively block
following newer kernels when security holes are found, since dm-crypt
would mean installing new software, training the support group,
reformatting the disk to generate a partition to use, etc.

When major new features just added to a stable series vanish after they
are adopted I most definitely do call that unstable.

And dm-crypt is vulnerable to the same types of attacks, it's just harder
to use.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

