Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262063AbREPUG3>; Wed, 16 May 2001 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262069AbREPUGT>; Wed, 16 May 2001 16:06:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262063AbREPUGK>; Wed, 16 May 2001 16:06:10 -0400
Message-ID: <3B02DD79.7B840A5B@transmeta.com>
Date: Wed, 16 May 2001 13:05:13 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
		<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<3B02D6AB.E381D317@transmeta.com> <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> H. Peter Anvin writes:
> > Richard Gooch wrote:
> > > Argh! What I wrote in text is what I meant to say. The code didn't
> > > match. No wonder people seemed to be missing the point. So the line of
> > > code I actually meant was:
> > >         if (strcmp (buffer + len - 3, "/cd") != 0) {
> >
> > This is still a really bad idea.  You don't want to tie this kind of
> > things to the name.
> 
> Why do you think it's a bad idea?
> 

Because you are now, once again, tying two things that are completely and
utterly unrelated: device classification and device name.  It breaks
every time someone comes out with a new device which is "kind of like an
old device, but not really," like CD-writers (which was kind-of-like
WORM, kind-of-like CD-ROM) and DVD (kind-of-like CD)... 

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
