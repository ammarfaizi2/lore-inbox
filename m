Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130372AbRAWM2v>; Tue, 23 Jan 2001 07:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbRAWM2l>; Tue, 23 Jan 2001 07:28:41 -0500
Received: from [203.169.151.222] ([203.169.151.222]:35846 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S130372AbRAWM2a>;
	Tue, 23 Jan 2001 07:28:30 -0500
Message-ID: <3A6D78EA.5B09C379@coppice.org>
Date: Tue, 23 Jan 2001 20:28:26 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com> <20010122082254.D9530@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
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
> > Not documenting your code is not a sign of good coding, but rather shows
> > arrogance, laziness and contempt for "those who would dare tamper with your
> > code after you've written it".  Document and comment your code thoroughly.
> > Do it as you go along.  I was also taught to comment nearly every line - as
> > part of the coding style used by a large, international company I worked for
> > several years ago.  It brings the logic of the programmer into focus and
> > makes code maintenance a whole lot easier.  It also helps one to remember
> > the logic of your own code when you revisit it a year or more hence.
> 
> Please don't listen to this.  The only place you really want comments is
> 
>     a) at the top of files, describing the point of the file;
>     b) at the top of functions, if the purpose of the function is not obvious;
>     c) in line, when the code is not obvious.
> 
> If you are writing code that requires a comment for every line, you are
> writing bad, obscure, unobvious code and no amount of commenting will fix
> it.
> 
> The real reason to sparing in your comments is that code and comments are
> not semantically bound to each other: the program doesn't stop working when
> the comment becomes incorrect.  It's incredibly frustrating to read a comment,
> believe you understand what is going on, only to find out that the comment
> and the code no longer match.
> --
> ---
> Larry McVoy              lm at bitmover.com           http://www.bitmover.com/lm

It seems the great majority of heavily commented programs I have seen
never commented anything useful. The ooooh so useful the little
snippets, like:

    /* Beware: The next two lines might seem weird, but they work around 
       a bug in some revisions of XYZZY. */

were seldom there, but:

    a = b + c; /* add a to b, and store it as c */

were there in bundles. During a period of making a liveing out of
sorting out severly screwed up projects I made a little comment
stripper. I found comments so unreliable, and so seldom useful, I was
better off reading the code without the confusion they might cause. I
do, however, try to document the non-obvious through comments in what I
write.

Some people still seem to be living in the age of K&R C, with 6 or 7
character variable names that demand some explanation. Maybe some day
they will awake to the expressive power of long (and well chosen) names.

Regards,
Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
