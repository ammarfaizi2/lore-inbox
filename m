Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVDUVih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDUVih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 17:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDUVih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 17:38:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10120 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261177AbVDUVia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 17:38:30 -0400
Date: Thu, 21 Apr 2005 23:38:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421213811.GA31207@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421190009.GC475@openzaurus.ucw.cz> <20050421190956.GA7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421190956.GA7443@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems that someone should write "Kernel hacker's guide to
git"... Documentation/git.txt seems like good place. I guess I'll do
it.

> > just plain vanilla" without rm -rf?
> 
> git cancel will give you "plain last commit". If you need plain vanilla,
> the "hard way" now is to just do
> 
> 	commit-id >.git/HEAD
> 
> but your current HEAD will be lost forever. Or do
> 
> 	git fork vanilla ~/vanilla linus
> 
> and you will have the vanilla tree tracking linus in ~/vanilla.

Ok, thanks.

> I'm not yet sure if we should have some Cogito interface for doing this
> and what its semantics should be.

What is Cogito, BTW?

> > I see quite a lot of problems with fsck-tree. Is that normal?
> > (I ran out of disk space few times during different operations...)
> 
> Actually, in case your tree is older than about two days, I hope you did
> the convert-cache magic or fetched a fresh tree?

No, I did not anything like that. I guess it is rm -rf time, then...

									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
