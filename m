Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTLBBif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 20:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTLBBif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 20:38:35 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:41901 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264273AbTLBBid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 20:38:33 -0500
Date: Tue, 2 Dec 2003 12:37:16 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pinotj@club-internet.fr, manfred@colorfullife.com,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031202013716.GG621@frodo>
References: <mnet1.1070127696.1558.pinotj@club-internet.fr> <Pine.LNX.4.58.0312011606200.2733@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312011606200.2733@home.osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 04:36:33PM -0800, Linus Torvalds wrote:
> 
> I assume it's not an option to try another filesystem on this setup, but
> it's entirely possible that the 2.6.x buffer-head removal has impacted XFS
> negatively - although I'm a bit surprised at how easily you seem to show
> problems, since XFS actually has active maintenance.
> 
> Nathan - I don't know if you follow linux-kernel, but Jerome Pinot has

Yep, although I try to filter out "noise" and have inadvertently
missed this discussion so far.

> been having bad slab problems for some time now. Do normal XFS users
> compile with slab debugging turned on?

Hmm - I know I do - my nightly QA testing runs with this set.
Let me dig through the archives and catch up a bit on this issue;
I'll get back to you.

thanks.

-- 
Nathan
