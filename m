Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVDMSH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDMSH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDMSH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:07:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31923 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261178AbVDMSHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:07:22 -0400
Date: Wed, 13 Apr 2005 20:07:19 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413180719.GA25716@pasky.ji.cz>
References: <20050413094226.GP16489@pasky.ji.cz> <Pine.LNX.4.21.0504131244410.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504131244410.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 07:01:34PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> For future reference, git is unhappy if you actually do this, because your
> HEAD won't match the (empty) contents of the new directory. The easiest
> thing is to cp -r your original, replace the shared stuff with links, and
> go from there.

How is it unhappy? That would likely be a bug, unless you do something
which really *needs* the tree populated and doesn't make sense otherwise
(show-diff aka git diff w/o arguments, for example).

Given that what would you copy with cp -r and wipe shortly after
(objects db) is likely to be significantly larger than the working tree
itself, checkout-cache would be wiser anyway.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
