Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269999AbTGZVVL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269969AbTGZVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:21:11 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:58857 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S269999AbTGZVUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:20:38 -0400
Date: Sat, 26 Jul 2003 23:35:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp updates
Message-ID: <20030726213537.GJ266@elf.ucw.cz>
References: <20030726211310.GG266@elf.ucw.cz> <Pine.LNX.4.44.0307261422080.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307261422080.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, I killed few trivial hunks, will submit them through trivial
> > patch monkey. Are you happy now, patrick?
> 
> Why do you insist on abusing the trivial patch monkey? Why can't you send 
> them directly to the maintainers? For instance, you add/remove printk()s 
> and comments that other people may or may not want in there. 

If killing an noisy printk is not an trivial patch, I do not know what
else is. If you want me to keep some printks, tell me, and we can talk
about that.

> But no, this doesn't make me happy because you insist on munging multiple 
> patches together that have little to do with each other, besides the fact 
> they touch the same file. Like I said in private email, it really helps to 
> track down a problem if each patch and subsequent changeset is as small 
> and localized as possible. 

> And, that's a real problem with swsusp. It's a huge mess right now. I'd 
> like to see it work well and reliably for 2.6, and have the source code be 
> in a state where people can look at it without running away screaming. 
> Convoluted updates are not going to help the situation. 

Yes, and just now you are contributing for swsusp to stay in the messy
state. Thanx a lot.

If you want to become swsusp maintainer, say so, and you'll be fed
nice and split patches *once*. That's okay to do. But I'm not able/do
not have enough time to produce split patch each time Linus decides to
drop the mail into the bitbucket.

I really don't like "Linus dropped patch -> resubmit 2 patches merged"
resulting in you screaming "SPLIT IT UP!" on the lists.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
