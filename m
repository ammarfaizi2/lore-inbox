Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUCNTzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUCNTzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 14:55:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261462AbUCNTzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 14:55:13 -0500
Date: Sun, 14 Mar 2004 14:54:58 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: j-nomura@ce.jp.nec.com, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <andrea@suse.de>, <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades>
Message-ID: <Pine.LNX.4.44.0403141453560.12895-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Marcelo Tosatti wrote:

> - It is off by default 
> - It is very simple (non intrusive), it just changes the point in which 
> anonymous pages are inserted into the LRU. 
> - When turned on, I dont see it being a reason for introducing new 
> bugs.
> 
> What you think of this? 

1) Yes, the patch is harmless enough.
2) As long as the default behaviour doesn't change from
   how things are done now, the patch shouldn't introduce
   any regressions, so it should be safe to apply.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

