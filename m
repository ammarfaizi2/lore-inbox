Return-Path: <linux-kernel-owner+w=401wt.eu-S1161262AbWLPRU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWLPRU1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWLPRU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:20:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57055 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161262AbWLPRU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:20:26 -0500
Date: Sat, 16 Dec 2006 09:20:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <w@1wt.eu>
cc: karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061216164947.GB31013@1wt.eu>
Message-ID: <Pine.LNX.4.64.0612160858100.3557@woody.osdl.org>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org>
 <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
 <20061216064344.GF24090@1wt.eu> <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org>
 <20061216164947.GB31013@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2006, Willy Tarreau wrote:
> 
> I understand your point, but not completely agree with the comparison,
> because I think that you (as the "author") are in the type of authors
> you describe below :
> 
> > Of course, all reasonable true authors tend to agree with fair use.

Sure. Sadly, in this day and age, "copyright owner" and "author" only bear 
a very passing resemblance to each other.

In a lot of areas, the AUTHOR may be a very reasonable person, and realize 
that fair use is a good thing, and perhaps even realize that in some 
places even unfair use can be a good thing (do you really think you should 
pay $20 for a DVD if you make $3 a month in a sweatshop in china? Maybe 
piracy sometimes is simply better..)

But the author may also have his own reasons for wanting to _deny_ fair 
use. Maybe he's just a royal a-hole, and wants to milk his work for 
whatever it's worth. But maybe he's a person with an agenda, and wants to 
ignore fair use because he wants to "improve the world for everybody", 
never mind that he tries to deny people a fundamental right in the 
process. I call those people a-holes too (in all fairness, they return the 
favor, so we're all even ;)

But even more commonly, the author simply doesn't control the copyright at 
all any more. In many areas (and software is one - including even large 
swaths of free software), the copyrights of a work is not really 
controlled by the author of the work, but by companies or foundations that 
have no reason to really try to educate people about "fair use".

So I actually think that the authors that actually UNDERSTAND fair use, 
and realize that people can use portions of their work without permission, 
AND that actually control their work is a very very very small subset of 
authors in general.

This has nothing to do with software per se, btw. Pick up one of the 
Calvin & Hobbes books by Bill Watterson - I think it may have been the "10 
year anniversary" one - where he talks about the disagreements he had with 
the people who actually controlled the copyrights (and I think also some 
of the people who used his artwork without any permission - the line 
between "fair use" and "illegal" really is a murky one, and while we 
should celebrate that murkiness, it's also why people disagree).

> > And I'd rather teach people that fundamental fact, than try to confuse the 
> > issue EVEN MORE by saying that my copyright only extends to derived works 
> > in the license text. That will just make people think that if the license 
> > does NOT say that, they don't have fair use. AND THAT IS WRONG.
> 
> That's a valid point. What is really needed is to tell them that if they
> doubt, they just have to ask the author and not be advised by any GPL zealot.

Well, in open source, there often isn't any one "the author". So you can't 
do that. And when there is, as mentioned, he may not actually even have 
the legal right any more to give you any license advice. And even when he 
does hold the copyrights, he may change his mind later.

So in the end, the thing you can and should depend on is: the license text 
itself (and happily, the GPLv2 very clearly talks about the real line 
being "derived work" - it may be a murky line, and they seem to want to 
change that to something harder in the GPLv3, but it's a good line), a 
separate signed contract, or simply a legal opinion, preferably by a judge 
in a court of law. 

Of course, it very seldom gets to that kind of issue. People tend to just 
walk very gently around it all.

If you want to be safe, you NEVER do any binary modules. The only 
_obviously_ safe thing is to always do only what the license very 
explicitly allows you to, and in the case of the GPLv2, that's to release 
all modifications under the same GPLv2.

Anything else, you have to make some really scary decisions. Can a judge 
decide that a binary module is a derived work even though you didn't 
actually use any code? The real answer is: HELL YES. It's _entirely_ 
possible that a judge would find NVidia and ATI in violation of the GPLv2 
with their modules.

Judges have done stranger things. And it's not my place to say what the 
limit of "derived work" actually is. It all probably depends on a lot of 
circumstances, and there simply isn't an easy answer.

			Linus
