Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVDLIQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVDLIQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVDLIQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:16:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40082 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262053AbVDLIQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:16:14 -0400
Date: Tue, 12 Apr 2005 10:16:13 +0200
From: Petr Baudis <pasky@ucw.cz>
To: David Eger <eger@havoc.gtf.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050412081613.GA18545@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412040519.GA17917@havoc.gtf.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Apr 12, 2005 at 06:05:19AM CEST, I got a letter
where David Eger <eger@havoc.gtf.org> told me that...
> So with git, *every* changeset is an entire (compressed) copy of the
> kernel.  Really?  Every patch you accept adds 37 MB to your hard disk?
> 
> Am I missing something here?

Yes. Only changes files re-appear. The unchanged files keep the same
SHA1 hash, therefore they don't re-appear in the repository.

So, if Linus gets a patch which sanitizes drivers/char/selection.c,
only these new objects appear in the repository:

	drivers/char/selection.c
	drivers/char
	drivers
	. (project root)
	commit message

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
