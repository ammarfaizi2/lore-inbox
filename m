Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVBHBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVBHBEr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVBHBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 20:04:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:6590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbVBHBEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 20:04:44 -0500
Date: Mon, 7 Feb 2005 17:09:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: prezeroing V6 [2/3]: ScrubD
Message-Id: <20050207170947.239f8696.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502071646170.29971@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	<1106828124.19262.45.camel@hades.cambridge.redhat.com>
	<20050202153256.GA19615@logos.cnet>
	<Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
	<20050207163035.7596e4dd.akpm@osdl.org>
	<Pine.LNX.4.58.0502071646170.29971@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> > What were the benchmarking results for this work?  I think you had some,
> > but this is pretty vital info, so it should be retained in the changelogs.
> 
> Look at the early posts. I plan to put that up on the web. I have some
> stats attached to the end of this message from an earlier post.

But that's a patch-specific microbenchmark, isn't it?  Has this work been
benchmarked against real-world stuff?

> > Should we be managing the kernel threads with the kthread() API?
> 
> What would you like to manage?

Startup, perhaps binding the threads to their cpus too.
