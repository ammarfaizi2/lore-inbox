Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUHVDyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUHVDyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 23:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUHVDyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 23:54:16 -0400
Received: from ozlabs.org ([203.10.76.45]:20143 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265943AbUHVDyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 23:54:14 -0400
Date: Sun, 22 Aug 2004 13:50:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: John Levon <levon@movementarian.org>, oprofile-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040822035034.GA8702@krispykreme>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org> <20040821232206.GC20175@compsoc.man.ac.uk> <20040821163628.10cfa049.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821163628.10cfa049.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Anyway.  My question was mainly a prod in the antonward direction ;)

And Im prepared this time :) An excerpt from my test results a few
months ago:

> I ran a fork/exit intensive benchmark (sdet) on a big machine.
> 
> No patch:
> Enabling oprofile resulted in over a 10 times slow down in performance.
> 
> oprofile1.patch:
> About 2% slowdown when oprofile enabled
> 
> oprofile2.patch:
> About 5% slowdown when oprofile enabled

The final version was actually oprofile3.patch but it had a similar (10
times) gain in sdet performance.

So the patch is good stuff. Ive been running it locally for the last few 
months without a problem.

Anton
