Return-Path: <linux-kernel-owner+w=401wt.eu-S1030941AbWLPVER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030941AbWLPVER (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 16:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030942AbWLPVEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 16:04:16 -0500
Received: from 1wt.eu ([62.212.114.60]:1551 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030941AbWLPVEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 16:04:16 -0500
Date: Sat, 16 Dec 2006 22:04:06 +0100
From: Willy Tarreau <w@1wt.eu>
To: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061216210406.GH24090@1wt.eu>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu> <20061216144236.GB1003@thunk.org> <20061216163031.GA31013@1wt.eu> <20061216202312.GC1003@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216202312.GC1003@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 03:23:12PM -0500, Theodore Tso wrote:
> On Sat, Dec 16, 2006 at 05:30:31PM +0100, Willy Tarreau wrote:
> > I don't think this is the same case. The film _author_'s primary goal is
> > to have a lot of families buy his DVD to watch it. Whatever the MPAA says,
> > I can consider it "fair use" if a family of 4..8 persons watch the DVD at
> > the same time. 
> 
> "You can consider it"?  But you're not the author.  This is the
> hypocrisy that Linus was talking about.  At the same time that you're
> trying to dictate to other other people can use their copy of the
> Linux kernel, when it comes to others people's copyrighted work, you
> feel to dictate what is and isn't "fair use".

No, I don't want to dictate, it's the opposite, I say what _I_ consider
fair use. Other people will consider it other ways. It's exactly the
gray area Linus was talking about. As long as all parties agree on one
given fair use, there's no problem. Discussion and sometimes litigation
is needed when some parties disagree.

> That's the big thing about dynamic linking.  The GPL has always said
> it is about distribution, not about use.  The dynamic linking of a
> kernel module happens in the privacy of someone's home.  When we try
> to dictate what people are doing in the privacy in their home, we're
> no better than the MPAA or the RIAA.  

100% agreed with you on this !

> As far as whether or not someone is allowed to distribute a binary
> module that can be linked into the Linux kernel, that's a question of
> whether the binary module is a derived work or not.  And that's not up
> to us, that's up to the local laws.  But before you decide that you
> want the most extreme form of anything that wanders close to one
> person's code or header files is a derived work, and to start going to
> work lobbying your local legislature, recall that there have been
> those who have claimed that Linux is a derived work of Unix because we
> used things like #define's for errno codes and structure definitions
> of ELF binaries.  You really sure you want to go there?

Ted, I think you get me wrong. I don't want to dictate anyone what's
derived work and what is not. Instead, it's the opposite. I just want
to indicate them what's explicitly permitted by the author and copyright
owner (at least by me as the author/copyright owner when I can) so that
people can decide by themselves what level of risk they take by doing
whatever they want. What I consider the most important is to encourage
fair use even in areas I never anticipated, and when possible, try to
protect fair users from the GPL zealots who want to bite whenever one
gives them an opportunity to abuse the gray area to feel stronger.

I have opened even more my software and tried to clarify the reasons
why I chose the dual license exactly for this reason.

What I was suggesting is to add a clarification with the kernel to
avoid those overly long threads on LKML such as this one. It would
basically be structured like this :

"Use in the following order" :
  1) fully respect the license and you're OK.
  2) play in the gray area if you need and if you consider it fair use,
     but seek legal advice from a lawyer (and not LKML) before !
  3) explicitly violate the license, and prepare to get sued sooner or later.
  For GPL zealots : please do not report what _you_ consider abuse to LKML,
  contact the abuser, then a lawyer or specialized sites for this.

But Linus is right, he's not the only copyright owner, and that makes it
harder to touch anything related to license and use.

> 						- Ted

Willy

