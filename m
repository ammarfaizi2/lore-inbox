Return-Path: <linux-kernel-owner+w=401wt.eu-S965411AbWLPK0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965411AbWLPK0m (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 05:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965412AbWLPK0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 05:26:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:40652 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965411AbWLPK0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 05:26:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Sat, 16 Dec 2006 11:28:27 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, karderio <karderio@gmail.com>,
       linux-kernel@vger.kernel.org
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu>
In-Reply-To: <20061216064344.GF24090@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612161128.27721.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 16 December 2006 07:43, Willy Tarreau wrote:
> On Fri, Dec 15, 2006 at 06:55:17PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Sat, 16 Dec 2006, karderio wrote:
> > > 
> > > As it stands, I believe the licence of the Linux kernel does impose
> > > certain restrictions and come with certain obligations
> > 
> > Absolutely. And they boil down to something very simple:
> > 
> > 	"Derived works have to be under the same license"
> > 
> > where the rest is just really fluff.
> > 
> > But the point is, "derived work" is not what _you_ or _I_ define. It's 
> > what copyright law defines.
> > 
> > And trying to push that definition too far is a total disaster. If you 
> > push the definition of derived work to "anything that touches our work", 
> > you're going to end up in a very dark and unhappy place. One where the 
> > RIAA is your best buddy.
> > 
> > And the proposed "we make some technical measure whereby we draw our _own_ 
> > lines" is exactly that total disaster.
> > 
> > We don't draw our own lines. We accept that the lines are drawn for us by 
> > copyright law, and we actually _hope_ that the lines aren't too sharp and 
> > too clearcut. Because sharp edges on copyright is the worst possible 
> > situation we could ever be in.
> > 
> > The reason fair use is so important is exactly that it blunts/dulls the 
> > sharp knife that overly strong copyright protection could be.
> 
> All this is about "fair use", and "fair use" comes from compatibility
> between the author's intent and the user's intent. For this exact reason,
> I have added a "LICENSE" file [1] in my software (haproxy) stating that I
> explicitly permit linking with binary code if the user has no other choice
> (eg: protocols specs obtained under NDA), provided that "derived work"
> does not steal any GPL code (include files are under LGPL). On the other
> hand, all "common protocols" are developped under GPL so that normal users
> are the winners, and everyone is strongly encouraged to use the GPL for
> their new code to benefit from everyone else's eyes on the code.
> 
> This clarifies my intent and let developers decide whether *they* are
> doing legal things or not.
> 
> Don't you think it would be a good idea to add such a precision in the
> sources ? It could put an end to all those repeated lessons you have to
> teach to a lot of people about fair use. Or perhaps you like to put
> your teacher hat once a month ? :-)

I think the most important problem with the binary-only drivers is that we
can't support their users _at_ _all_, but some of them expect us to support
them somehow.

So, why don't we make an official statement, like something that will appear
on the front page of www.kernel.org, that the users of binary-only drivers
will never get any support from us?  That would make things crystal clear.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
