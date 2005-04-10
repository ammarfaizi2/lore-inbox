Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVDJWLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDJWLX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDJWLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:11:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55774 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261617AbVDJWLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:11:19 -0400
Date: Mon, 11 Apr 2005 00:11:18 +0200
From: Petr Baudis <pasky@ucw.cz>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RE: more git updates..
Message-ID: <20050410221118.GB18661@pasky.ji.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB629@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F033DB629@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 12:07:37AM CEST, I got a letter
where "Luck, Tony" <tony.luck@intel.com> told me that...
..snip..
> >Hey, I may end up being wrong, and yes, maybe I should have done a 
> >two-level one. The good news is that we can trivially fix it later (even 
> >dynamically - we can make the "sha1 object tree layout" be a per-tree 
> >config option, and there would be no real issue, so you could make small 
> >projects use a flat version and big projects use a very deep structure 
> >etc). You'd just have to script some renames to move the files around.
> 
> It depends on how many eco-system shell scripts get built that need to
> know about the layout ... if some shell/perl "libraries" encode this
> filename layout (and people use them) ... then switching later would
> indeed be painless.

FWIW, my short-term plans include support for monotone-like hash ID
shortening - it's enough to use the shortest leading unique part of the
ID to identify the revision. I will poke to the object repository for
that. I also already have Randy Dunlap's git lsobj, which will list all
objects of a specified type (very useful especially when looking for
orphaned commits and such rather lowlevel work).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
