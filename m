Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWFTV0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWFTV0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWFTV0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:26:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751164AbWFTV0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:26:40 -0400
Date: Tue, 20 Jun 2006 14:25:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Al Viro <viro@ftp.linux.org.uk>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
In-Reply-To: <20060620175321.GA7463@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606201416140.5498@g5.osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
 <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
 <20060620175321.GA7463@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, Russell King wrote:
> 
> Given that you've complained about me sending daily pull requests
> already, how do you intend folk to handle the situation where they've
> sent you a pull request, it's apparantly been ignored

It's not ignored, btw, I'm staggering the merging so that I don't merge 
everything the first day - I want nightly snapshots to have a chance of 
making a difference to people who aren't git users but test patches.

(In other words, I want "2.6.17-git1" and "2.6.17-git2" etc to actually 
b esomewhat spread out - rather than merge everything when people send it 
to me the first day after a release. I also tend to want a release to be 
"left alone" for a day or so, so that even people who track the 
development tree religiously will actually end up testing it).

> Given your complaint and your comments above, I can only assume that
> I must not touch a tree which I've asked you to pull for 48 hours
> just in case you do decide to honour the pull request.

Actually, from a technical standpoint, the easy way to do this with git is 
to simply have different branches (or even tags).

That said, people who I merge up with often (and you're one of them), and 
I don't actually tend to have any issues with (and again, you're one of 
them), I don't mind it I pull and notice that there's been an added commit 
or two since you asked me to pull.

Again - the "please pull" message is because I want to work with the 
_person_, and I want to be comfortable that what I pull is what they 
intended to pull.

And as you can guess, trees that I constantly update from end up having 
much less of that issue - there's less risk of there being 
miscommunication or just plain mistakes in those kinds of setups _anyway_.

So in many ways, if it's an archive that doesn't sync up very often, I 
want such people to be _extra_ careful. When I get a pull request for 
ieee1394, _especially_ as the maintainer kind of seems to keep on 
changing, I want to be a lot more careful than with something like yours 
or Davids trees, that I've worked with for years beforehand, and have 
already been using git pretty much since day one etc etc.

In other words: rules are rules, and in the end, they matter a hell of a 
lot less than just common sense. But they matter _more_ for the repo 
maintainers I haven't gotten used to.

			Linus
