Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVJ2S5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVJ2S5b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVJ2S5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:57:31 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:30678 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751257AbVJ2S5a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:57:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=blCGKpb6+cJ+DAPEgJCryHRhyXW/tQxmBvuGd25BHsZj6WT9NWvvQEXNpY2XhGPlesfy21aFUg+L6KcF9t2By7WthziQYGG4DV8A39dWttgeyqbTbPMjBgutD432aVO9ZPiwRieGOB4xP8lB3rzxAVZCF5FKdgFURIUICMLPacA=
Message-ID: <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
Date: Sat, 29 Oct 2005 11:57:30 -0700
From: Tony Luck <tony.luck@gmail.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: New (now current development process)
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/05, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> 2.6.x kernel are maintained by Linus Torvalds and Andrew Morton (both
> are from OSDL) and the development is as follow:
Linus maintains the 2.6.x kernel, and Andrew maintains the "-mm" tree
(which is used as a testing ground for anything non-trivial before it is
fed into Linus' tree).

> - As soon a new kernel is released a two weeks windows is open, during
> this period of time maintainers can submit big diffs to Linus (usually
> the patched sitted in -mm kernels for a few weeks). Preferred way to
> submit big changes is using GIT ( more information about GIT at
> http://git.or.cz/ and
> http://www.kernel.org/pub/software/scm/git/docs/tutorial.html).
> - After two weeks a -rc1 kernel is released and now is possible to
> push only patches that do not include new functionalities)
Initially Linus said that he would only accept e-mail patches after
rc1 ... but common sense prevailed and he later clarified to say that
git merges could still be used, but only to include bug fixes.

Also note that a whole new driver (or filesystem) might be accepted
after -rc1 because there is no risk of causing regressions with
such a change.

> - After two weeks -rc2 is released
There isn't really a hard schedule for when -rcN for N>1 are released.

> - Process continues until the kernel is considered "ready", the
> process should last three months ( 4 kernels per yeard should be
> released).
IIRC the goal was to make a release in around 8 weeks (which would
be closer to six per year).  But you have the important part, which is
that Linus doesn't make the release until it is "ready".  2.6.13 was
released on August 28th, and 2.6.14 on October 27th ... so we
appear to have hit the goal this time through.

-Tony
