Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTJaL2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTJaL2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:28:21 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:45988 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S263229AbTJaL2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:28:20 -0500
Date: Fri, 31 Oct 2003 12:26:15 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Vine <chris@cvine.freeserve.co.uk>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031031112615.GA10530@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
References: <200310292230.12304.chris@cvine.freeserve.co.uk> <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test9 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 22:57:23 -0500, Rik van Riel wrote:
> On Wed, 29 Oct 2003, Chris Vine wrote:
> 
> > However, on a low end machine (200MHz Pentium MMX uniprocessor with only 32MB 
> > of RAM and 70MB of swap) I get poor performance once extensive use is made of 
> > the swap space.
> 
> Could you try the patch Con Kolivas posted on the 25th ?
> 
> Subject: [PATCH] Autoregulate vm swappiness cleanup

I suppose it will show some improvement but fail to get performance
anywhere near 2.4 -- at least that's what my own tests found. I've been
working on a break-down of where we're losing it.
Bottom line: It's not simply a price we pay for feature X or Y. It's
all over the map, and thus no single patch can possibly fix it.

Roger
