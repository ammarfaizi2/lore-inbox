Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUFRVYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUFRVYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUFRVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:20:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64408 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264524AbUFRVSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:18:12 -0400
Date: Fri, 18 Jun 2004 23:17:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, dev@opensound.com,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618211757.GD7404@suse.de>
References: <20040618082708.GD12881@suse.de> <Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com> <20040618135136.45581da7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618135136.45581da7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18 2004, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> > Maintaining a patch for one version of the distribution, in
> > order to get a feature to customers sooner, is perfectly
> > doable and may make economic sense.
> > 
> > Maintaining an out-of-tree patch forever because you didn't
> > get around to merging it into the upstream kernel doesn't.
> 
> Problem is, what happens if vendor X ships a feature and that feature is
> deemed unacceptable for the kernel.org kernel?

Very good question, as these features/patches are often the ones that
are ugliest and the hardest to maintain. Or the ones that make you
slightly source incompatible with mainline, which is always ugly.

> There are examples of this and as I've earlier indicated, I'd be OK with
> merging some fairly stinky things after 2.7 forks off, as a service to the
> major kernel.org customers and as a general lets-keep-things-in-sync
> exercise.

Within reason (I trust your taste and judgement completely), I fully
support that and think this is key to maintaing closer proximity between
mainline and vendor kernels. There are _always_ going to be uglies
(don't ask me why)...

> But we then need to do it all again in 2.8.x.  It's hard to see how to fix
> this apart from either merging everything into the main tree or dropping
> things from vendor trees.  Or waiting for someone to come up with an
> acceptable form of whatever it is the patch does.

Wish I had an answer for that. Things can and do get dropped from vendor
trees, doesn't cover all cases naturally.

-- 
Jens Axboe

