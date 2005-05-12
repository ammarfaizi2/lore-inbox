Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVELFQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVELFQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVELFQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:16:24 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:62380 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261151AbVELFQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:16:18 -0400
Date: Thu, 12 May 2005 07:16:30 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: 7eggert@gmx.de, Jesper Juhl <juhl-lkml@dif.dk>,
       "David S.Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace 
 cleanup)
In-Reply-To: <4282D4CA.6030003@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0505120644010.3645@be1.lrz>
References: <42Mbg-Tq-25@gated-at.bofh.it> <42MXA-1zI-3@gated-at.bofh.it>
 <42MXA-1zI-1@gated-at.bofh.it> <42Nh3-1M8-17@gated-at.bofh.it>
 <42Nh3-1M8-15@gated-at.bofh.it> <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org>
 <4282D4CA.6030003@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Nick Piggin wrote:
> Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> >Jesper Juhl <juhl-lkml@dif.dk> wrote:

> >>If Andrew agrees, then I'll commit to doing this cleanup;

> >>- (to a limited degree) no trailing whitespace

> >I just ran a script over -rc4 to remove trailing ws. The result is
> >about 22 MB in 429 patches (iterated over ./*/*).
> >
> >How hard can I patch you before you start patching me?
> >
> >Which addresses am I supposed to send it to? I don't want to break the
> >record for the most annoying patch series in lkml.
> >
> 
> First of all, why is it 429 patches?

Because
1) some parts will get rejected due to conflicting patches. Only those 
parts will need to be recreated.
2) i forgot to create the 430th patch.

> The patches we want aren't about a
> file or a subdirectory or even a subsystem, but they're supposed to be
> a logical change. Ie. 1 patch.

That would be too large for most mailboxes. If you like a single patch,
you can just concatenate all the patches, so splitting it was a safe bet.

> An exception for something like this would
> be if you want to feed it to different maintainers seperately, but it
> sounds like you just want to bomb it somewhere...

I asume there is no automatic way to get the maintainer from a given 
file, and I don't want to grow old and grey while doing that manually.

-- 
"Bravery is being the only one who knows you're afraid."
-David Hackworth
