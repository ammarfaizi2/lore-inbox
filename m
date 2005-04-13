Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVDMANu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVDMANu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVDMANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:13:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41327
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262966AbVDMANN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:13:13 -0400
Date: Wed, 13 Apr 2005 02:14:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050413001408.GL1521@opteron.random>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random> <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 04:45:07PM -0700, Linus Torvalds wrote:
> Yes. CVS is much denser.
>
> CVS is also total crap. So your point is?

I wasn't suggesting to use CVS. I meant that for a newly developed SCM,
the CVS/SCCS format as storage may be more appealing than the current
git format. I guess I should have said RCS instead of CVS, sorry if that
created any confusion. The arch/darcs approach of pratically storing
patches would also be much denser but it has no efficient way of doing
"rcs up -p 1.x" on a file, that doesn't involve potentially unpacking
tons of unrelated changesets.
