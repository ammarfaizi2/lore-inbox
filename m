Return-Path: <linux-kernel-owner+w=401wt.eu-S1030655AbWLPGoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030655AbWLPGoA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 01:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbWLPGoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 01:44:00 -0500
Received: from 1wt.eu ([62.212.114.60]:1535 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030655AbWLPGn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 01:43:59 -0500
Date: Sat, 16 Dec 2006 07:43:44 +0100
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061216064344.GF24090@1wt.eu>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 06:55:17PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 16 Dec 2006, karderio wrote:
> > 
> > As it stands, I believe the licence of the Linux kernel does impose
> > certain restrictions and come with certain obligations
> 
> Absolutely. And they boil down to something very simple:
> 
> 	"Derived works have to be under the same license"
> 
> where the rest is just really fluff.
> 
> But the point is, "derived work" is not what _you_ or _I_ define. It's 
> what copyright law defines.
> 
> And trying to push that definition too far is a total disaster. If you 
> push the definition of derived work to "anything that touches our work", 
> you're going to end up in a very dark and unhappy place. One where the 
> RIAA is your best buddy.
> 
> And the proposed "we make some technical measure whereby we draw our _own_ 
> lines" is exactly that total disaster.
> 
> We don't draw our own lines. We accept that the lines are drawn for us by 
> copyright law, and we actually _hope_ that the lines aren't too sharp and 
> too clearcut. Because sharp edges on copyright is the worst possible 
> situation we could ever be in.
> 
> The reason fair use is so important is exactly that it blunts/dulls the 
> sharp knife that overly strong copyright protection could be.

All this is about "fair use", and "fair use" comes from compatibility
between the author's intent and the user's intent. For this exact reason,
I have added a "LICENSE" file [1] in my software (haproxy) stating that I
explicitly permit linking with binary code if the user has no other choice
(eg: protocols specs obtained under NDA), provided that "derived work"
does not steal any GPL code (include files are under LGPL). On the other
hand, all "common protocols" are developped under GPL so that normal users
are the winners, and everyone is strongly encouraged to use the GPL for
their new code to benefit from everyone else's eyes on the code.

This clarifies my intent and let developers decide whether *they* are
doing legal things or not.

Don't you think it would be a good idea to add such a precision in the
sources ? It could put an end to all those repeated lessons you have to
teach to a lot of people about fair use. Or perhaps you like to put
your teacher hat once a month ? :-)

Regards,
Willy

[1] http://haproxy.1wt.eu/download/1.3/src/LICENSE

