Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUGAEmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUGAEmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUGAEmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:42:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:35034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263881AbUGAEmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:42:46 -0400
Date: Wed, 30 Jun 2004 21:42:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: <20040701040834.GC15086@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0406302140240.11212@ppc970.osdl.org>
References: <je8ye5ct75.fsf@sykes.suse.de> <200407010322.i613MPDr016785@magilla.sf.frob.com>
 <20040701040834.GC15086@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jul 2004, Andrea Arcangeli wrote:
> 
> My patch sounds much simpler to me, can you tell me what's the point of
> leaving ptrace enabled on a task that already executed do_exit?

To let the tracer look at the exit code?

How would you otherwise see what exit code the child exited with?

		Linus
