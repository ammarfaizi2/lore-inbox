Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVA0S2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVA0S2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVA0S2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:28:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:26333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262693AbVA0S2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:28:24 -0500
Date: Thu, 27 Jan 2005 10:28:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501271018510.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org>
 <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, Linus Torvalds wrote:
> 
> Real engineering is about doing a good job balancing different issues.

Btw, this is true of real security too. 

Being too strict "because it's the secure way" just means that people will 
disable you altogether, or start doing things that they know is wrong, 
because the right way of doing this may be secure, but they are also very 
inconvenient.

Thus a security person who doesn't take other aspects into account is 
actually HURTING security by insisting on things that may not be practical 
for a general vendor.

I've seen companies that had very strict firewalls in place, and didn't 
allow people to upload any internal data except by going through approved 
sites and having the data approved fist too. Secure? No. I was told people 
just connected modems to their local machines in their offices instead: 
the security measures didn't work for them, so they had to effectively 
disable them entirely. Everybody knew what was going on, but the security 
people were pig-headed idiots.

It's a classic mistake of doing totally the wrong thing, and I bet the
pig-headed idiots felt very good about themselves: they had the perfect
excuse for doing something stupid. Namely "we only implement the _best_
security we can do, and we refuse to do anything inferior". It's also a 
classic example of perfect being the enemy of good.

So John - next time you flame somebody, ask yourself whether maybe they 
had other issues. Maybe a vendor might care about not breaking existing 
programs, for example? Maybe a vendor knows that their users don't just 
use the programs _they_ provide (and test), but also use their own 
programs or programs that they got from the outside, and the vendor cannot 
test. Maybe such a vendor understands that you have to ease into things, 
and you can't just say "this is how it has to be done from now on".

			Linus
