Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUCMOnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 09:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUCMOnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 09:43:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263105AbUCMOnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 09:43:40 -0500
Date: Sat, 13 Mar 2004 09:43:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.58.0403120812430.1045@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0403130942200.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Linus Torvalds wrote:

> So let's make it clear: if we have an object-based reverse mapping, it 
> should cover all reasonable cases, and in particular, it should NOT have 
> rare fallbacks to code that thus never gets any real testing.

Absolutely agreed.  And with Rajesh's code it should be possible
to get object-based rmap right, not vulnerable to the scalability
issues demonstrated by Ingo's test programs.

Whether we go with mm-based or vma-based, I don't particularly
care either.  As long as the code is nice...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

