Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUCLTGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUCLTGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:06:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262398AbUCLTGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:06:37 -0500
Date: Fri, 12 Mar 2004 14:06:17 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <40520928.4050409@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0403121405170.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Chris Friesen wrote:

> What happens when you have more than PAGE_SIZE processes running?

Forked off the same process ?
Without doing an exec ?
On a 32 bit system ?

You'd probably run out of space to put the VMAs,
mm_structs and pgds long before reaching this point ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

