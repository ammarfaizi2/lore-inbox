Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUCVOIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUCVOIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:08:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261993AbUCVOIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:08:06 -0500
Date: Mon, 22 Mar 2004 09:07:54 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-aa1
In-Reply-To: <20040322041629.GK3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403220906280.20045-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:

> > > I renamed it primarly because rmap is the common name for the tecnique
> > > of traking the pagetables with pte_chains
> > 
> > Funny, first thing I hear about that ;)
> 
> Not sure after all those discussions how you may not have ever noticed
> that people uses objrmap to mean something different than rmap, it's
> really hard to believe that you never noticed.

Most people seem to be talking about "pte based rmap" vs
"object based rmap".  So far you're the only one who I've
seen using "rmap" to mean just "pte based rmap" and not
also "object based rmap".

Also, the BSDs seem to abbreviate "pte based reverse mapping"
to pmap, not rmap...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

