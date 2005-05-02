Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVEBRds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVEBRds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEBRbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:31:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:47762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVEBRbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:31:05 -0400
Date: Mon, 2 May 2005 10:32:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050502171802.GA28045@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0505021031070.3594@ppc970.osdl.org>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
 <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org> <20050502171802.GA28045@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Daniel Jacobowitz wrote:
> 
> Do you know any vaguely Unix-like system where #!/usr/bin/env does not
> work?  I don't; I've used it on Solaris, HP-UX, OSF/1...

I've used unixes where "#!" didn't work.

Things like bash still have support for such unixes, I think - you can
tell them to parse the #! line themselves, to make it appear to do the 
right thing.

Are these common? Hell no. But they definitely existed.

		Linus
