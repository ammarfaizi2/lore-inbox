Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbTGZVMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269711AbTGZVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:12:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:27017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269919AbTGZVMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:12:24 -0400
Date: Sat, 26 Jul 2003 14:31:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp updates
In-Reply-To: <20030726211310.GG266@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307261422080.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, I killed few trivial hunks, will submit them through trivial
> patch monkey. Are you happy now, patrick?

Why do you insist on abusing the trivial patch monkey? Why can't you send 
them directly to the maintainers? For instance, you add/remove printk()s 
and comments that other people may or may not want in there. 

But no, this doesn't make me happy because you insist on munging multiple 
patches together that have little to do with each other, besides the fact 
they touch the same file. Like I said in private email, it really helps to 
track down a problem if each patch and subsequent changeset is as small 
and localized as possible. 

And, that's a real problem with swsusp. It's a huge mess right now. I'd 
like to see it work well and reliably for 2.6, and have the source code be 
in a state where people can look at it without running away screaming. 
Convoluted updates are not going to help the situation. 


	-pat

