Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUFRVL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUFRVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFRVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:08:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263664AbUFRVDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:03:30 -0400
Date: Fri, 18 Jun 2004 17:03:14 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: axboe@suse.de, <dev@opensound.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <20040618135136.45581da7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0406181700400.8065-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Andrew Morton wrote:
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

That's why responsible vendors develop their feature in
the upstream kernel before they merge it into their own
product.

That way they know in advance they'll won't need to maintain
the feature as a separate patch for more than one product ;)

> But we then need to do it all again in 2.8.x.  It's hard to see how to
> fix this apart from either merging everything into the main tree or
> dropping things from vendor trees.  Or waiting for someone to come up
> with an acceptable form of whatever it is the patch does.

Ideally the vendor would come up with an acceptable form in
the first place.  Not out of a moral obligation to the Linux
community, but because doing that means free QA and better
quality source code that's easier to support...

Sure, it is some short term work for the vendor, but it'll
save work in the long run.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

