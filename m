Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbULTV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbULTV13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbULTV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:27:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261647AbULTV1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:27:20 -0500
Date: Mon, 20 Dec 2004 16:27:07 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <20041220125443.091a911b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412201626420.13935@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
 <20041220125443.091a911b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Andrew Morton wrote:

> We haven't been incrementing local variable total_scanned since the
> scan_control stuff went in.  That broke kswapd throttling.

That would explain the "kswapd uses heaps of CPU time when
starting a memory hungry task", too ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
