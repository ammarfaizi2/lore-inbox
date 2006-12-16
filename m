Return-Path: <linux-kernel-owner+w=401wt.eu-S1161147AbWLPQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWLPQ2e (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWLPQ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:28:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53432 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161148AbWLPQ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:28:30 -0500
Date: Sat, 16 Dec 2006 08:28:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <w@1wt.eu>
cc: karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061216064344.GF24090@1wt.eu>
Message-ID: <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org>
 <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
 <20061216064344.GF24090@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2006, Willy Tarreau wrote:
> 
> All this is about "fair use", and "fair use" comes from compatibility
> between the author's intent and the user's intent.

No. "fair use" comes from an INcompatibility between the author's intent 
and the users intent. 

In other words, "fair use" kicks in EXACTLY when an author says "you can't 
copy this except when you [payme, stand on your head for two hours, give 
your modifications back]", and the user _disagrees_.

Users still have rights under copyright law even when the author tries to 
deny them those rights.

Of course, all reasonable true authors tend to agree with fair use. People 
who actually do "original work" tend to all realize that everybody really 
feeds off of each others works, and that we're all inspired by authors etc 
that went before us. So I doubt a lot of real authors, musicians or 
computer programmers will actually disagree with the notion of fair use, 
but it's important to realize that fair use is exactly for when the users 
and the authors rights clash, and the user DOES have rights. Even rights 
that weren't explicitly given to them by the author.

> For this exact reason, I have added a "LICENSE" file [1] in my software 
> (haproxy) stating that I explicitly permit linking with binary code if 
> the user has no other choice (eg: protocols specs obtained under NDA), 
> provided that "derived work" does not steal any GPL code (include files 
> are under LGPL). On the other hand, all "common protocols" are 
> developped under GPL so that normal users are the winners, and everyone 
> is strongly encouraged to use the GPL for their new code to benefit from 
> everyone else's eyes on the code.
> 
> This clarifies my intent and let developers decide whether *they* are
> doing legal things or not.

I think that's fine, and I think it may make some of your users happier, 
and breathe more easily. I don't disagree with that kind of clarification.

But:

> Don't you think it would be a good idea to add such a precision in the
> sources ?

I think it would be a hell of a lot better idea if people just realized 
that they have "fair use" rights whether the authors give them or not, and 
that the authors copyrights NEVER extend to anything but a "derived work".

I find the RIAA's position and the DMCA distasteful, and in that I 
probably have a lot of things in common with a lot of people on this list. 
But by _exactly_ the same token, I also find the FSF's position and a lot 
of GPL zealots' position on this matter very distasteful.

Because "fair use" is NOT somethng that should be specified in the 
license. It's very much something that people have DESPITE any license 
claiming otherwise.

And I'd rather teach people that fundamental fact, than try to confuse the 
issue EVEN MORE by saying that my copyright only extends to derived works 
in the license text. That will just make people think that if the license 
does NOT say that, they don't have fair use. AND THAT IS WRONG.

			Linus
