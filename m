Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUCVPJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUCVPJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:09:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262027AbUCVPJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:09:18 -0500
Date: Mon, 22 Mar 2004 10:09:06 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-aa1
In-Reply-To: <20040322145019.GZ3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403221007300.20045-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:

> >  * This is kept modular because we may want to experiment
> >  * with object-based reverse mapping schemes.
> 
> obviously I read that comment, but I definitely hope he meant people
> adding objrmap.c w/o necessairly deleting rmap.c too like me and you did

On the contrary.  I started out by looking at object based
rmap, but Ben and Dave told me about the worst case scenarios.
Only after that I started working on a pte based rmap scheme.

Now that the big problems with object based rmap are solved,
I'd really like to see the pte chain code go away...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

