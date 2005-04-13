Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVDMSUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDMSUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDMSUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:20:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:52134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261158AbVDMSUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:20:16 -0400
Date: Wed, 13 Apr 2005 11:22:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Daniel Barkalow <barkalow@iabervon.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: git mailing list (Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.3)
In-Reply-To: <20050413180719.GA25716@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504131117590.4501@ppc970.osdl.org>
References: <20050413094226.GP16489@pasky.ji.cz>
 <Pine.LNX.4.21.0504131244410.30848-100000@iabervon.org> <20050413180719.GA25716@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2005, Petr Baudis wrote:
>
> Dear diary, on Wed, Apr 13, 2005 at 07:01:34PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > For future reference, git is unhappy if you actually do this, because your
> > HEAD won't match the (empty) contents of the new directory. The easiest
> > thing is to cp -r your original, replace the shared stuff with links, and
> > go from there.
> 
> How is it unhappy?

I think it's just Daniel being unhappy because he didn't do the read-tree
+ checkout-cache + update-cache steps ;)

Btw, I'm going to stop cc'ing linux-kernel on git issues (after this
email, which also acts as an announcement for people who haven't noticed
already), since anybody who is interested in git can just use the
"git@vger.kernel.org" mailing list:

	echo 'subscribe git' | mail majordomo@vger.kernel.org

to get you subscribed (and you'll get a message back asking you to
authorize it to avoid spam - if you don't get anything back, it failed).

		Linus
