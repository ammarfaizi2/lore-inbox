Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRKFOAy>; Tue, 6 Nov 2001 09:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279378AbRKFOAt>; Tue, 6 Nov 2001 09:00:49 -0500
Received: from unthought.net ([212.97.129.24]:3036 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S279326AbRKFOAi>;
	Tue, 6 Nov 2001 09:00:38 -0500
Date: Tue, 6 Nov 2001 15:00:37 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106150037.C3058@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111041453230.21449-100000@weyl.math.psu.edu> <viro@math.psu.edu> <20011104205030.P14001@unthought.net> <Pine.GSO.4.21.0111041453230.21449-100000@weyl.math.psu.edu> <20011104210936.T14001@unthought.net> <8CKC8L1Hw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <8CKC8L1Hw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Tue, Nov 06, 2001 at 09:23:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 09:23:00AM +0200, Kai Henningsen wrote:
> jakob@unthought.net (Jakob ¥stergaard)  wrote on 04.11.01 in <20011104210936.T14001@unthought.net>:
> 
...
> >
> > Shell programming is great for small programs. You don't need type
> > information in the language when you can fit it all in your head.
> >
> > Now, go write 100K lines of shell, something that does something that is not
> > just shoveling lines from one app into a grep and into another app.  Let's
> > say, a database.  Go implement the next Oracle replacement in bash, and tell
> > me you don't care about types in your language.
> 
> And now look at how large typical /proc-using code parts are. Do they  
> match better with your first or your second paragraph?

If you write in C, you need type information.  No matter if it's 5 lines or 50K.

How many of your shell languages use arbitrary precision arithmetic *always* ?
If they only do "sometimes" (for some operations) you'll be up shit creek without
a paddle once some value you thought was 32 bits turns out to be 64, and your
scripts, lacking type informaiton, handle this error "gracefully" (accounting
scripts for example where you don't check the output every day, but discover at
the end of the quarter that you're fucked because you only have the lower 32
bits of the user's network usage).

My argument with the 100K of shell was more to emphasize that type information
is necessary in complex systems.

Even if you just have 5 lines of Perl, you have a kernel too - it is a complex
system already.

> 
> The first?
> 
> I thought so.

Well, working for a company that makes a living of reading in /proc (and being
fairly good at it), it would be more like the second   ;)

But I have also coded for HP-UX, Solaris, NT and others.   I have seen how
others attack the problems of getting information out of systems, and I can see
that /proc as it is today is *not* a good answer to that problem.

There are worse systems out there than Linux, but there are better ones as
well.   I see no reason why Linux shouldn't excel in this area too.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
