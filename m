Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUEKPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUEKPOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEKPOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:14:41 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262380AbUEKPOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:14:39 -0400
Date: Tue, 11 May 2004 04:51:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp documentation updates
Message-ID: <20040511025157.GA3752@elf.ucw.cz>
References: <20040505094719.GA4259@elf.ucw.cz> <1083750907.17294.27.camel@laptop-linux.wpcb.org.au> <20040505101158.GC1361@elf.ucw.cz> <1083798626.17294.79.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083798626.17294.79.camel@laptop-linux.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And perhaps you want to write "What is swsusp2?" question/answer?
> 
> How does this sound?...
> 
> What is 'swsusp2'?
> 
> swsusp2 is Software Suspend 2, forked implementation of suspend-to-disk
> which is available as separate patches for 2.4 and 2.6 kernels from
> swsusp.sourceforge.net. It includes support for SMP, 4GB Highmem and
> preemption. It also has a extensible architecture that allows for
> arbitrary transformations on the image (compression, encryption) and
> arbitrary backends for writing the image (eg to swap or an NFS
> share[Work In Progress]). Questions regarding suspend2 should be sent to
> the mailing list available through the Suspend2 website, and not to the
> Linux Kernel Mailing List. We are working toward merging Suspend2 into
> the mainline kernel.

You are using swsusp2, suspend2 and Suspend2. I figured out you mean
suspend2 and applied this: (it will eventually propagate).
								Pavel

Q: What is 'suspend2'?

A: suspend2 is 'Software Suspend 2', forked implementation of
suspend-to-disk which is available as separate patches for 2.4 and 2.6
kernels from swsusp.sourceforge.net. It includes support for SMP, 4GB
highmem and preemption. It also has a extensible architecture that
allows for arbitrary transformations on the image (compression,
encryption) and arbitrary backends for writing the image (eg to swap
or an NFS share[Work In Progress]). Questions regarding suspend2
should be sent to the mailing list available through the suspend2
website, and not to the Linux Kernel Mailing List. We are working
toward merging suspend2 into the mainline kernel.


-- 
When do you have heart between your knees?
