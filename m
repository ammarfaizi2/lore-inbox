Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTJaD63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 22:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTJaD63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 22:58:29 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:62033 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262940AbTJaD62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 22:58:28 -0500
Date: Thu, 30 Oct 2003 22:57:23 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Vine <chris@cvine.freeserve.co.uk>
cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <200310292230.12304.chris@cvine.freeserve.co.uk>
Message-ID: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Chris Vine wrote:

> However, on a low end machine (200MHz Pentium MMX uniprocessor with only 32MB 
> of RAM and 70MB of swap) I get poor performance once extensive use is made of 
> the swap space.

Could you try the patch Con Kolivas posted on the 25th ?

Subject: [PATCH] Autoregulate vm swappiness cleanup


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


