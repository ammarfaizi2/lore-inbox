Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVAWEsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVAWEsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVAWEsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:48:19 -0500
Received: from colin2.muc.de ([193.149.48.15]:18439 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261221AbVAWEqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:46:40 -0500
Date: 23 Jan 2005 05:46:37 +0100
Date: Sun, 23 Jan 2005 05:46:37 +0100
From: Andi Kleen <ak@muc.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123044637.GA54433@muc.de>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de> <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about a shell sort?  if the data is mostly sorted shell sort beats 
> qsort lots of times, and since the data sets are often small in-kernel, 
> shell sorts O(n^2) behaviour won't harm it too much, shell sort is also 
> faster if the data is already completely sorted. Shell sort is certainly 
> not the simplest algorithm around, but I think (without having done any 
> tests) that it would probably do pretty well for in-kernel use... Then 
> again, I've known to be wrong :)

I like shell sort for small data sets too. And I agree it would be 
appropiate for the kernel.

-Andi
