Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRAVQXU>; Mon, 22 Jan 2001 11:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132598AbRAVQXK>; Mon, 22 Jan 2001 11:23:10 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:29216
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S132057AbRAVQW4>; Mon, 22 Jan 2001 11:22:56 -0500
Date: Mon, 22 Jan 2001 08:22:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jonathan Earle <jearle@nortelnetworks.com>
Cc: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
Message-ID: <20010122082254.D9530@work.bitmover.com>
Mail-Followup-To: Jonathan Earle <jearle@nortelnetworks.com>,
	'Linux Kernel List' <linux-kernel@vger.kernel.org>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2001 at 11:04:50AM -0500, Jonathan Earle wrote:
> > -----Original Message-----
> > From: profmakx.fmp [mailto:profmakx.fmp@gmx.de]
> > 
> > So, every good programmer
> > should know where to put comments. And it is unnecessary to 
> > put comments to
> > explain what code does. One should see this as stated in the 
> > CodingStyle doc.
> > Ok, there are points where a comment is good, but for example 
> > at university
> > we are to comment on every single line of code ...
> 
> WRONG!!!
> 
> Not documenting your code is not a sign of good coding, but rather shows
> arrogance, laziness and contempt for "those who would dare tamper with your
> code after you've written it".  Document and comment your code thoroughly.
> Do it as you go along.  I was also taught to comment nearly every line - as
> part of the coding style used by a large, international company I worked for
> several years ago.  It brings the logic of the programmer into focus and
> makes code maintenance a whole lot easier.  It also helps one to remember
> the logic of your own code when you revisit it a year or more hence.

Please don't listen to this.  The only place you really want comments is

    a) at the top of files, describing the point of the file;
    b) at the top of functions, if the purpose of the function is not obvious;
    c) in line, when the code is not obvious.

If you are writing code that requires a comment for every line, you are 
writing bad, obscure, unobvious code and no amount of commenting will fix
it.

The real reason to sparing in your comments is that code and comments are
not semantically bound to each other: the program doesn't stop working when
the comment becomes incorrect.  It's incredibly frustrating to read a comment,
believe you understand what is going on, only to find out that the comment
and the code no longer match.   
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
