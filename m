Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVDJRnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVDJRnB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVDJRnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:43:01 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45320 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261535AbVDJRmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:42:39 -0400
Date: Sun, 10 Apr 2005 19:42:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410174221.GD7858@alpha.home.local>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410173349.GA17549@elte.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 07:33:49PM +0200, Ingo Molnar wrote:
> 
> * Petr Baudis <pasky@ucw.cz> wrote:
> 
> >   I will also need to do more testing on the linux kernel tree.
> > Committing patch-2.6.7 on 2.6.6 kernel and then diffing results in
> > 
> > 	$ time gitdiff.sh `parent-id` `tree-id` >p
> > 	real    5m37.434s
> > 	user    1m27.113s
> > 	sys     2m41.036s
> > 
> > which is pretty horrible, it seems to me. Any benchmarking help is of
> > course welcomed, as well as any other feedback.
> 
> it seems from the numbers that your system doesnt have enough RAM for 
> this and is getting IO-bound?

Not the only problem, without I/O, he will go down to 4m8s (u+s) which
is still in the same order of magnitude.

willy

