Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281271AbRKERsF>; Mon, 5 Nov 2001 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281270AbRKERry>; Mon, 5 Nov 2001 12:47:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48399 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281257AbRKERri>; Mon, 5 Nov 2001 12:47:38 -0500
Message-ID: <3BE6DCCD.8A7CE033@evision-ventures.com>
Date: Mon, 05 Nov 2001 19:39:09 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Satchell <satch@concentric.net>
CC: dalecki@evision.ag, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Jakob =?iso-8859-1?Q?=D8stergaard?=" <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <200111042213.fA4MDoI229389@saturn.cs.uml.edu> <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:
> 
> At 12:23 PM 11/5/01 +0100, Martin Dalecki wrote:
> >Every BASTARD out there telling the world, that parsing ASCII formatted
> >files
> >is easy should be punished to providing a BNF definition of it's syntax.
> >Otherwise I won't trust him. Having a struct {} with a version field,
> >indicating
> >possible semantical changes wil always be easier faster more immune
> >to errors to use in user level programs.
> 
> I would love for the people who write the code that generates the /proc
> info to be required to document the layout of the information.  The best
> place for that documentation is the source, and in English or other
> accepted human language, in a comment block.  Not in "header lines" or
> other such nonsense.  I don't need no stinkin' BNF, just a reasonable

I don't agree. BNF is basically the only proper and efficient way for a 
nice formal descrition of a LR parsable language. No accident most
programming
languages out there are defined in some sort of BNF.

> description of what each field is would suffice.  I would go so far as to
> say there needs to be a standard established in how /proc data is formatted
> so that we can create templates for the standard tools.
> 
> (I have to ask, have you ever used flex?  I used to hand-code scanners, but
> I find that flex is so much easier and generates smaller faster code than I
> can do by hand.  Changes are easy, too)

Short answer: yes I know them, yacc bison pure flex and lex whatever,
and 
I used to use them for job projects not just toys. Trust me they are
the only proper practical way to define the syntax of something parsable
and beeing complete about it. Unless you wan't to reach the stability of
the usual perl-web hackkery.
