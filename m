Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRAVSB0>; Mon, 22 Jan 2001 13:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRAVSBQ>; Mon, 22 Jan 2001 13:01:16 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:1483
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S132426AbRAVSBD>; Mon, 22 Jan 2001 13:01:03 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCC6@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: RE: [OT?] Coding Style
Date: Mon, 22 Jan 2001 12:53:48 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Larry McVoy [mailto:lm@bitmover.com]
> 
> On Mon, Jan 22, 2001 at 11:04:50AM -0500, Jonathan Earle wrote:
> > > -----Original Message-----
> > > From: profmakx.fmp [mailto:profmakx.fmp@gmx.de]
> > > 
> > > So, every good programmer
> > > should know where to put comments. And it is unnecessary to 
> > > put comments to
> > > explain what code does. One should see this as stated in the 
> > > CodingStyle doc.
> > > Ok, there are points where a comment is good, but for example 
> > > at university
> > > we are to comment on every single line of code ...
> > 
> > WRONG!!!
> > 
> > Not documenting your code is not a sign of good coding, but 
> rather shows
> > arrogance, laziness and contempt for "those who would dare 
> tamper with your
> > code after you've written it".  Document and comment your 
> code thoroughly.
> > Do it as you go along.  I was also taught to comment nearly 
> every line - as
> > part of the coding style used by a large, international 
> company I worked for
> > several years ago.  It brings the logic of the programmer 
> into focus and
> > makes code maintenance a whole lot easier.  It also helps 
> one to remember
> > the logic of your own code when you revisit it a year or more hence.
> 
> Please don't listen to this.  The only place you really want 
> comments is
> 
>     a) at the top of files, describing the point of the file;
>     b) at the top of functions, if the purpose of the 
> function is not obvious;
>     c) in line, when the code is not obvious.
> 
> If you are writing code that requires a comment for every 
> line, you are 
> writing bad, obscure, unobvious code and no amount of 
> commenting will fix
> it.

The point of comments is not to "fix" bad code, it's to provide
understanding.  As the original poster said, _you_ may understand your code,
but that in no way implies that _I_ will, or your co-worker down the hall
will, etc.  I'm not suggesting that a statement like "counter=0;" at the
start of a function be commented, but other operations should be.  "Why do
we want this file written in /proc - wouldn't syslog have worked better?"
"Why is this loop skipping the first seven elements?"  "Why is this
structure used here instead of a simple array?"  "What on earth does
m->n->o->num represent?"

> The real reason to sparing in your comments is that code and 
> comments are
> not semantically bound to each other: the program doesn't 
> stop working when
> the comment becomes incorrect.  It's incredibly frustrating 
> to read a comment,
> believe you understand what is going on, only to find out 
> that the comment
> and the code no longer match.   

Comments should be updated when code is updated.  I believe that
documentation is of far greater value than code itself.  Code can be
changed, however, logic drives the code.  Without a good understanding of
the latter, the former is of little value, IMHO.

Cheers!
Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
