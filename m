Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUCLD24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 22:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUCLD24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 22:28:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49065 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261928AbUCLD2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 22:28:55 -0500
Date: Thu, 11 Mar 2004 22:28:42 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040311135608.GI30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Andrea Arcangeli wrote:

> it's more complicated because it's more finegrined and it can handle
> mremap too. I mean, the additional cost of tracking the vmas payoffs
> because then we've a tiny list of vma to search for every page,
> otherwise with the mm-wide model we'd need to search all of the vmas in
> a mm.

Actually, with the code Rajesh is working on there's
no search problem with Hugh's idea.

Considering the fact that we'll need Rajesh's code
anyway, to deal with Ingo's test program and the real
world programs that do similar things, I don't see how
your objection to Hugh's code is still valid.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


