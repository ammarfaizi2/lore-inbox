Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315462AbSEYXzD>; Sat, 25 May 2002 19:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEYXzC>; Sat, 25 May 2002 19:55:02 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:33474 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315462AbSEYXzA>; Sat, 25 May 2002 19:55:00 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        rtai@rtai.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)] 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Sat, 25 May 2002 16:10:34 PDT."
             <20020525161034.L28795@work.bitmover.com> 
Date: Sun, 26 May 2002 01:54:37 +0200
Message-Id: <20020525235442.CFB3511972@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020525161034.L28795@work.bitmover.com> Larry McVoy wrote:
>
> > > > I'm told, and I've seen, that there substantial parts of RT/Linux in the
> > > > RTAI source base.  Isn't it true that RTAI used to be called "my-rtai"
> > 
> > Can you please quote any such "substantial parts of RT/Linux  in  the
> > RTAI source"?
> 
> Well, since you asked, how about you just go diff the include directories
> of the two source bases.  That's a wonderful place to start.  Anyone who

Larry, you know EXACTLY why I won't do this: I don't want to waste my
time.

> spends 5 minutes in there will see that RTAI is derived from RTL.  Look at

Nobody EVER denied this.

> the definition of the RT task struct, it's identical.  Look at the fifo.h
> file, big chunks of it are identical.  Another fun thing is to just want

Ummm.... that's interface definitions, right? That's no code. This is
probably not "substantial parts of RT/Linux", or is it?

> the directory structure of the two source trees, more clues that it is
> RTL derived.  It's all been pushed around a lot but I'm not sure you can

Stop! Let's keep this straight.

NOBODY ever denied that RT-Linux came first, and RTAI used  it  as  a
starting point.


But you claimed that there are "substantial parts of RT/Linux in  the
RTAI source".

Where ?!?!

> Furthermore, look at this:
> 
>     rtai-24.1.9/COPYING
> 	The intent of RTAI developers is to make the code that we write
> 	to be widely useful and that it can be copied and incorporated
> 	into other works, including libraries.	In addition, we wish
> 	to make it explicitly clear that linking proprietary code with
> 	RTAI is an acceptible use -- for these reasons, we have chosen
> 	the LGPL as the distribution license.
> 
> 	However, at the current time, RTAI contains portions that are
> 	derived from GPL code, so if you are in a situation where the
> 	difference between GPL and LGPL is an issue, please ask.
> 
>     So which is it?  GPL or LGPL?  I thought you guys said you made it 
>     clear that it was GPLed.

If you were really interested, you could read
http://www.linuxdevices.com/articles/AT2899063844.html

The core is under GPL, and additional packages are under  LGPL.  Yes.
Any problem?

Are you worried that any Linux distribution of  your  choice  is  not
completely covered by GPL? That there are LGPLed libraries and things
like that?


> Anyway, you can jump up and down until you are blue in the face, it's
> absolutely obvious to anyone who looks that the RTAI stuff is derived
> from the RTL stuff.  Yeah, sure, it's evolved, but it's the same source
> base and evolving it does not invalidate their license.  The COPYING

Item: it's derived - correct. Nobody ever denied.

Item: it's evolved - correct. In fact, in many aspects it's much more
      advanced; you find many features in RTAI that are not available
      in RT-Linux (at least in the GPLed versions - don't  know  what
      they  are  selling  to thier customers). And you find an active
      community of developers for RTAI, which RT-Linux seems  not  to
      have  any more. And the RTAI mailing list is open for everyone,
      there are no censoring filters installed.

> file in the *current* RTAI release is illegal.  You can't say "Well,

Please explain?

> there is some GPL stuff in here, but we're releasing under the LGPL"

You can release some stuff onder one license,  other  stuff  under  a
second  license,  and  yet other stuff onder a third license. Is that
too difficult for you to understand?

> just because you feel like it.  Didn't you guys repeatedly state that
> it was GPL, not LGPL?  And is it?  Not according to the download.

You don't want to understand. Hell, you must be SCARED that there are
libraries in your GNU/Linux system that are under LGPL...


Just for the record: you claimed  there  was  "substantial  parts  of
RT/Linux  in  the  RTAI source"; when challenged to provide examples,
you tried to evade several times; finally, you fell back to the  "but
it's derived from RTL", which nobody ever denied.

That's the old strategy of FUD.



What a waste of time.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"He was so narrow minded he could see through  a  keyhole  with  both
eyes ..."
