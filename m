Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVDJXiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVDJXiy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDJXix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:38:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:40394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261638AbVDJXgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:36:10 -0400
Date: Sun, 10 Apr 2005 16:38:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@engr.sgi.com>
cc: junkio@cox.net, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
In-Reply-To: <20050410161457.2a30099a.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0504101634250.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
 <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
 <20050410161457.2a30099a.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Paul Jackson wrote:
>
> Useful explanation - thanks, Linus.

Hey. You're welcome. Especially when you create good documentation for 
this thing.

Because:

> Is this picture and description accurate:

[ deleted, but I'll probably try to put it in an explanation file 
  somewhere ]

Yes. Excellent.

> Minor question:
> 
>   I must have an old version - I got 'git-0.03', but
>   it doesn't have 'checkout-cache', and its 'read-tree'
>   directly writes my working files.

Yes. Crappy old tree, but it can still read my git.git directory, so you 
can use it to update to my current source base.

However, from a usability angle, my source-base really has been 
concentrating _entirely_ on just the plumbing, and if you actually want a 
faucet or a toilet _conntected_ to the plumbing, you're better off with 
Pasky's tree, methinks:

>   How do I get a current version?  Well, one way I see,
>   and that's to pick up Pasky's:
>     
>     http://pasky.or.cz/~pasky/dev/git/git-pasky-base.tar.bz2
>  
>   Perhaps that's the best way?

Indeed. He's got a number of shell scripts etc to automate the boring 
parts.

		Linus
