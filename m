Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVEBU4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVEBU4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVEBUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:55:41 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:7448 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261745AbVEBUxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:53:06 -0400
Date: Mon, 2 May 2005 22:54:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Andrea Arcangeli <andrea@suse.de>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050502205418.GA12409@mars.ravnborg.org>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org> <20050502171802.GA28045@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502171802.GA28045@nevyn.them.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 01:18:02PM -0400, Daniel Jacobowitz wrote:
> > 	#!/bin/sh
> > 	exec perl perlscript.pl "$@"
> > 
> > instead.
> 
> Do you know any vaguely Unix-like system where #!/usr/bin/env does not
> work?  I don't; I've used it on Solaris, HP-UX, OSF/1...

I had to pull out a call to env from kbuild due to strange errors in
some mandrake? based system.
I never tracked it down fully at that time, I just realised that two
different programs named env was present, and the less common one made
the linux kernel build fail. env was not called with any path in that
example so that may have cured it.

	Sam
