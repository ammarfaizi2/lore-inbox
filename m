Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUAIDjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUAIDjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:39:10 -0500
Received: from [193.138.115.2] ([193.138.115.2]:4103 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262564AbUAIDjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:39:05 -0500
Date: Fri, 9 Jan 2004 04:36:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking
In-Reply-To: <20040108192021.6c2aea60.akpm@osdl.org>
Message-ID: <Pine.LNX.4.56.0401090428080.11276@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
 <20040108192021.6c2aea60.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Jan 2004, Andrew Morton wrote:

> Jesper Juhl <juhl@dif.dk> wrote:
> >
> > The current Linux kernel does only very basic sanity checking on ELF
> >  binaries.
>
> I've always had little confidence in the elf loader.  The problem is
> complex, the code quality is not high and the consequences of an error are
> severe.
>
Ahh, so I'm not crazy ;)  I've been looking at that code trying to
convince myself that I should try and deal with it for quite a while.


> I guess others realise this, and the bad guys have probably already
> "audited" the code for us, but still.
>
> I'll merge your additional checks for testing and would encourage you to
> keep looking at the problem, thanks.
>

Thank you. I'll keep working on this. I'll see if I can get a patch done over
the weekend that adds a few more checks and re-do the ones you just merged
to be stronger - it may take longer as I probably won't have too much time
the next 2-3 days, but I'll se what I can do.


-- Jesper Juhl

