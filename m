Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVDZEYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVDZEYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVDZEXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:23:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:45510 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261324AbVDZEXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:23:09 -0400
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pasky@ucw.cz, git@vger.kernel.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
References: <20050426032422.GQ13467@pasky.ji.cz>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 14:22:45 +1000
Message-Id: <1114489365.7111.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 05:24 +0200, Petr Baudis wrote:
>   Hello,
> 
>   here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
> history tracker. This package was formerly called git-pasky, however
> this release brings big changes. The usage is significantly different,
> as well as some basic concepts; the history changed again (hopefully the
> last time?) because of fixing dates of some old commits. The .git/
> directory layout changed too.
>
> .../...

Unless you already did this in the latest release, it would be nice to
have something like havign all the low level tools be by default in some
~/lib/git or whatever, and only the cg-* scripts in ~/bin on install,
unless maybe you pass some kind of I_AM_A_REAL_GIT=1 on the make
line ...

I don't really plan to use the low level tools, and I don't like the way
they clobber my bin namespace :)

Ben.


