Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWIWMkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWIWMkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWIWMkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:40:24 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751095AbWIWMkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:40:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbWIVVZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:25:31 -0400
Date: Fri, 22 Sep 2006 14:25:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: The GPL: No shelter for the Linux kernel?
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
Message-ID: <Pine.LNX.4.64.0609221357210.4388@g5.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Sep 2006, David Schwartz wrote:
> 
> This is probably going to be controversial, but Linus should seriously
> consider adding a clause that those who contribute to the kernel from now on
> consent to allow him to modify the license on their current contributions
> and all past contributions, amending the Linux kernel license as
> appropriate. This would at least begin to reduce this problem over the next
> few years, leaving fewer and fewer people with claim to less and less code
> who would have legal standing to object.

It's the last thing I'd ever want to do, for all the same reasons the 
kernel doesn't have the "or later versions" language wrt licenses.

I don't actually want people to need to trust anybody - and that 
very much includes me - implicitly.

I think people can generally trust me, but they can trust me exactly 
because they know they don't _have_ to.

The reason the poll and the whitepaper got started was that I've obviously 
not been all that happy with the GPLv3, and while I was pretty sure I was 
not alone in that opinion, I also realize that _everybody_ thinks that 
they are right, and that they are supported by all other right-thinking 
people. That's just how people work. We all think we're better than 
average.

So while I personally thought it was pretty clear that the GPLv2 was the 
better license for the kernel, I didn't want to just depend on my own 
personal opinion, but I wanted to feel that I had actually made my best to 
ask people.

Now, I could have done it all directly on the Linux-kernel mailing list, 
but let's face it, that would just have caused a long discussion and we'd 
not have really been any better off anyway. So instead, I did

	git log | grep -i signed-off-by: |
		cut -d: -f2- | sort | uniq -c | sort -nr | less -S

which anybody else can do on their copy of their git repository, and I 
just picked the first screenful of people (and Alan. And later we added 
three more people after somebody pointed out that some top people use 
multiple email addresses so my initial filtering hadn't counted for them 
properly).

[ I also double-checked by just checking the same numbers for authorship.
  I'll very openly admit to thinking that the maintainership that goes 
  with forwarding other peoples patches to me counts as almost as 
  important as the authorship itself, which is why I started out with the 
  signed-off-by count, but I also wanted to verify that the list of people 
  makes sense either way. It did. ]

In other words, maybe some people thought that the 29 names were somehow 
"selected" to get that particular answer.  Nope. The only selection was 
just an arbitrary cut-off-point (and the fact that I think two people 
didn't actually vote).

It wasn't meant to be really "definitive" - the poll was literally meant 
to get _some_ kind of view into how the top developers feel. I think the 
end result ended up being more definitive (just thanks to the very clear 
voting pattern) than we migth have expected.

So, to anybody not on the list - don't feel bad. This was about getting a 
good _feeling_ for how the top kernel maintainers - judging purely by an 
admittedly fairly arbitrary, but also very neutral, measure - felt about 
the license.

If the result had turned out very differently, I would probably have had 
to seriously re-think my stance on the license. I don't guarantee that I 
always change my mind, but I _can_ guarantee that if most of the people I 
trust tell me I'm a dick-head, I'll at least give it a passing thought.

[ Chorus: "You're a dick-head, Linus" ]

Anyway, nobody got voted off the island. This was a poll, to get a view 
into what people thought. Take it as such, and I think people will happily
discuss issues.

Different people had different issues with the GPLv3, so the separate 
white-paper that was written was done by a different group, and is meant 
for a different reason - it talks about some of the issues those 
particular people wanted to point out. 

My personal opinion is that a lot of the public discussion has been driven 
by people who are motivated by the politics of the discussion. So you have 
a lot of very vocal GPLv3 supporters. But I think that the people who 
actually end up doing a lot of the development are usually not as vocal, 
and haev actually not been heard very much at all.

In some sense, the poll is a way for the people who actually do a lot of 
the work to show that the FSF doesn't speak for necessarily even a very 
big portion of actual developers.

				Linus
