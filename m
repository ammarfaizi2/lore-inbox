Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUJZCEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUJZCEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUJZCDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:03:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29897 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261899AbUJZBso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:48:44 -0400
Date: Mon, 25 Oct 2004 21:48:25 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: lowmem_reserve (replaces protection)
In-Reply-To: <20041025170128.GF14325@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Andrea Arcangeli wrote:

> This is a forward port to 2.6 CVS of the lowmem_reserve VM feature in
> the 2.4 kernel.
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-1

-       unsigned long           protection[MAX_NR_ZONES];
+       unsigned long           lowmem_reserve[MAX_NR_ZONES];

The gratituous renaming of variable and function names makes
it hard to see what this patch actually changed.  Hard enough
that I'm not sure what the behavioural difference is supposed
to be.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

