Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUIYX5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUIYX5S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUIYX5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:57:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267386AbUIYX5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:57:13 -0400
Date: Sat, 25 Sep 2004 19:57:04 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
In-Reply-To: <20040925162252.GN3309@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0409251956070.28582-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Andrea Arcangeli wrote:

> I didn't check the topdown model, in theory it should be extended to
> cover that too, this is only working for the legacy model right now
> because those apps aren't going to use topdown anyways.

Looks like it should just work, topdown shouldn't affect
expand_stack() or find_vma_prev() ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

