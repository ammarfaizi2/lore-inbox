Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbUKYA1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbUKYA1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUKYAZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:25:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:24203 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262948AbUKYAXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:23:44 -0500
Date: Thu, 25 Nov 2004 01:23:54 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill the last few warnings in binfmt_elf.c
In-Reply-To: <Pine.LNX.4.61.0411031130570.10505@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.61.0411250114020.3447@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411030039310.3395@dragon.hygekrogen.localhost>
 <20041102165422.4c09aad7.akpm@osdl.org> <Pine.LNX.4.61.0411031130570.10505@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

On Wed, 3 Nov 2004, Jesper Juhl wrote:

> On Tue, 2 Nov 2004, Andrew Morton wrote:
> 
[...]
> > The other patches are still queued up in my todo queue.  This is because I
> > took a close look at these warnings some weeks ago and ended up deciding
> > that the proper fixes were complex and risky.  So I need to go through your
> > patches with some care.  I hope you've already done so.
> > 
> I've certainly tried, but as I'm sure you are aware I have nowhere near 
> the level of experience of most people on the list, but I've tried my best 
> to ensure that these patches do the right thing, and I've been using them 
> on my own box ever since making the first one and I've not seen any ill 
> effects yet.
> 
> Now that you say the proper fixes are probably "complex and risky" I think 
> I'll go back and double check my changes once more this evening. I 
> certainly don't want to waste your time with silly errors I could find 
> myself.
> 
I've been looking over my patches again (and still doing so), and I must 
say that I feel quite comfortable with my changes related to padzero() - I 
think at least that bit could go into -mm for now. I'm also quite certain 
my change to fill_psinfo() is safe (although I know you consider it a 
silly fix), that could probably also safely go into -mm. The rest of the 
changes have not caused me any trouble, but I don't have as warm and fuzzy 
a feeling in my belly about those as I do about the padzero() and 
fill_psinfo() changes, so the rest should probably wait a bit unless your 
reading of them tells you they are correct - I'll keep 
digging/reading/learning and see if I can either confirm the rest is OK or 
find the proper solution, but that could take a while...

--
Jesper Juhl


