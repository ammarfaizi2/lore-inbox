Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUKCKl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUKCKl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUKCKl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:41:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:45490 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261521AbUKCKkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:40:42 -0500
Date: Wed, 3 Nov 2004 11:37:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill the last few warnings in binfmt_elf.c
In-Reply-To: <20041102165422.4c09aad7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0411031130570.10505@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.61.0411030039310.3395@dragon.hygekrogen.localhost>
 <20041102165422.4c09aad7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Andrew Morton wrote:

> Date: Tue, 2 Nov 2004 16:54:22 -0800
> From: Andrew Morton <akpm@osdl.org>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] kill the last few warnings in binfmt_elf.c
> 
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > Sorry to keep bugging you with this directly, but I'm still not aware of a 
> >  sepperate maintainer for this file.
> 
> There isn't one.
> 
Ok, you + lkml it is then.

> > 
> >  I've send you 3 patches previously that kill a few warnings in 
> >  fs/binfmt_elf.c. The patch below includes those previous 3 and also adds a 
> >  fix for the last ones.
> 
> The other patches are still queued up in my todo queue.  This is because I
> took a close look at these warnings some weeks ago and ended up deciding
> that the proper fixes were complex and risky.  So I need to go through your
> patches with some care.  I hope you've already done so.
> 
I've certainly tried, but as I'm sure you are aware I have nowhere near 
the level of experience of most people on the list, but I've tried my best 
to ensure that these patches do the right thing, and I've been using them 
on my own box ever since making the first one and I've not seen any ill 
effects yet.

Now that you say the proper fixes are probably "complex and risky" I think 
I'll go back and double check my changes once more this evening. I 
certainly don't want to waste your time with silly errors I could find 
myself.


--
Jesper Juhl

