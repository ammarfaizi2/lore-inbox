Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWH3OJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWH3OJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWH3OJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:09:38 -0400
Received: from 1wt.eu ([62.212.114.60]:42769 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750832AbWH3OJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:09:37 -0400
Date: Wed, 30 Aug 2006 15:46:44 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sean <seanlkml@sympatico.ca>
Cc: Andi Kleen <ak@suse.de>, davej@redhat.com, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830134644.GA20129@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <p73y7t65z6c.fsf@verdi.suse.de> <20060830121845.GA351@1wt.eu> <200608301459.15008.ak@suse.de> <20060830131612.GB351@1wt.eu> <20060830100015.6b967c32.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830100015.6b967c32.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 10:00:15AM -0400, Sean wrote:
> On Wed, 30 Aug 2006 15:16:12 +0200
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > That's already what I'm doing, and yes, it is *that* hard. We're literally
> > speaking about *thousands* of patches. It's as difficult to find one patch
> > within 2.6 git changes as it is to find a useful mail in the middle of 99%
> > spam. This is not because of GIT but because of the number of changes.
> 
> Willy,
> 
> The git-cherry command might be useful for you in this situation.  It will
> show you all the patches in one branch that have been merged in an upstream
> branch, and those that haven't.  Not sure if it's perfect for your situation,
> but may be worth a look.

I've already used it (it's what I was using when to maintain the 2.4-hf
tree in parallel to Marcelo's mainline). But it's useful when you have
*a few* patches. I'm really speaking about *thousands* of patches that
get merged into 2.6 every few months and this is what makes the job difficult.
Not to mention that they also get merged in 2.6-mm in advance, or that
sometimes they are obsoleted and/or replaced by something else.

Clearly, I'm not going to track all 2.6 patch by patch to maintain 2.4 !

The most scalable workflow is distributed, and should be oriented towards
push and not pull. We just have to ensure that *someone* takes care of
each patch and tracks it up to its merge.

> Sean

Cheers,
Willy

