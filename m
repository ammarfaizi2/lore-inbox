Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCJDaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCJDaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVCJD17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:27:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:19947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261480AbVCJD0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:26:12 -0500
Date: Wed, 9 Mar 2005 19:28:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bk commits and dates
In-Reply-To: <1110422519.32556.159.camel@gaston>
Message-ID: <Pine.LNX.4.58.0503091924170.2530@ppc970.osdl.org>
References: <1110422519.32556.159.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Mar 2005, Benjamin Herrenschmidt wrote:
> 
> I don't know if I'm the only one to have a problem with that, but it
> would be nice if it was possible, when you pull a bk tree, to have the
> commit messages for the csets in that tree be dated from the day you
> pulled, and not the day when they went in the source tree.

Nope, that's against how BK works. It's really distributed, so "my" tree 
has no special meaning, and as such the fact that I pull has no meaning 
either - it doesn't trigger as anything special.

The only thing that ends up being special is when it hits the public tree
which has the trigger to send out the emails. IOW, the date of the _email_
is special (in that it says when a commit hit the public tree), not not
the commits changesets themselves.

Now, if James trigger scripts set the date of the email by the date of the 
commit, that sounds like a misfeature, but you'd better talk to James, not 
me, since he's the one doing that part..

		Linus
