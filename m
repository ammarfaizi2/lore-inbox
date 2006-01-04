Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWADAER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWADAER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWADAER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:04:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57780 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965156AbWADAEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:04:15 -0500
Date: Tue, 3 Jan 2006 16:02:54 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] Fix the zone reclaim code in 2.6.15
In-Reply-To: <20060103152923.2f5bbfe9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601031556120.23039@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601031457300.22676@schroedinger.engr.sgi.com>
 <20060103152923.2f5bbfe9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > Some bits for zone reclaim exists in 2.6.15 but they are not usable.
> >  This patch fixes them up, removes unused code and makes zone reclaim usable.
> >
> 
> You know that there are over 100 mm/ patches in -mm.  If Linus applies this
> patch, it will cause extensive wreckage.  And this patch doesn't vaguely
> apply to the mm/ patches which I have queued.  So it's basically useless.
> 
> Please try to play along.

Well, this is one case where there is crap in Linus tree that needs to be 
fixed. Its an urgent issue. And the existing patches in mm do not fix 
this issue but remove the code altogether. When I asked you to remove 
these patches, you got mad at me for some reason.
 
> yes, it's awkward that there's such a large backlog in that area.  We just
> need to be patient and extra careful.

So you are saying we need to remove this feature and then add it back in 
later?

This means another 2 and 3 release cycles with this severe unfixed 
problem?
