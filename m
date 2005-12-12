Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVLLUkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVLLUkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVLLUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:40:52 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:32588 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751141AbVLLUkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:40:51 -0500
Date: Mon, 12 Dec 2005 21:40:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] Link lxdialog with mconf directly
Message-ID: <20051212204049.GA7656@mars.ravnborg.org>
References: <20051212004159.31263.89669.stgit@machine.or.cz> <20051212191422.GB7694@mars.ravnborg.org> <20051212200817.GM10680@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212200817.GM10680@pasky.or.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 09:08:17PM +0100, Petr Baudis wrote:
> > It is only 8 files and prefixing them with lx* would make them
> > stand out compared to the rest. It is not like there is any user planned
> > for the lxdialog functionality in the kernel, and kconfig users outside
> > the kernel I beleive copy lxdialog with rest of kconfig files.
> 
> Ok. I didn't want to pollute scripts/kconfig/ too much, but if it's ok
> by you, I can do it that way. I will submit another series later in the
> evening.
In the end this is Roman's call, not mine.
Keeping the lxdialog functionality close to the users though makes
total sense. We do not have to take special care of dependencies etc.
> 
> > Btw. the work you are doing are clashing with a general cleanup effort
> > of lxdialog I have in -mm at the moment.
> > I received only very limited feedback = looks ok.
> > Integrating principles from your old patch was on my TODO list.
> 
> Do you mean the series you posted at Nov 21? Should I just rebase my
> patches on top of that?
Please do so. I did not post the biggest one where I Lindented all of
lxdialog, but they are all in
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

> FWIW, the changes there look fine to me. I actually wanted to change the
> indentation of the menus as well; it looks horrible especially in the
> singlemenu mode.
> 
> > I have something in the works that uses linked list instead of a
> > preallocated array, to keep the dynamic behaviour. I will probarly make
> > a version with the linked list approach but otherwise use your changes
> > to mconf.c. But it will take a few days until I get to it.
> 
> I can do it and include it in the updated series.
Would be perfect!

I will then do a proper review of next round of patches.

	Sam
