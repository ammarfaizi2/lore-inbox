Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSL3T1q>; Mon, 30 Dec 2002 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSL3T1q>; Mon, 30 Dec 2002 14:27:46 -0500
Received: from chopper.slackworks.com ([64.244.30.42]:1802 "EHLO
	chopper.slackworks.com") by vger.kernel.org with ESMTP
	id <S265578AbSL3T1p>; Mon, 30 Dec 2002 14:27:45 -0500
Date: Mon, 30 Dec 2002 04:42:41 -0500 (EST)
From: Zac Hansen <xaxxon@chopper.slackworks.com>
To: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Indention - why spaces?
In-Reply-To: <3E109EF1.5040901@WirelessNetworksInc.com>
Message-ID: <Pine.LNX.4.44.0212300441190.20144-100000@chopper.slackworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (chopper.slackworks.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think the previously proposed solution solves the issues you raised.

> This problem is as old as the typewriter itself.  The trouble is that a 
> Tab character doesn't have a fixed size - some set it to 3 characters 
> wide, some to 4 some to 8, or whatever.

With the proposed solution, that doesn't matter.

> 
> The 'indent' program was written a couple of decades ago, to pretty 
> print C code.  It has a 'GNU' standard, but I'm not aware of a 'Linux' 
> standard.  Anyhoo, the only way to prevent indentation wars is to use 
> spaces, not tabs and to set 'diff' to ignore white space when comparing 
> files...

Why not use tabs and spaces like proposed and let everyone see the file 
the way they want to?

--Zac

> 
> Arnaldo Carvalho de Melo wrote:
> > Em Mon, Dec 30, 2002 at 07:53:22PM +0100, Emiliano Gabrielli escreveu:
> > 
> >><quote who="Dave Jones">
> >>
> >>>On Mon, Dec 30, 2002 at 12:49:33PM +0000, John Bradford wrote:
> >>> > > Well, I disagree: http://www.wiggy.net/rants/tabsvsspaces.xhtml
> >>> > In my opinion, indentation in any form is irritating.
> >>>
> >>>The devfs source code is --> that way.
> >>>
> >>
> >>IMHO and in my personal projects I use the following indenting rules:
> >>
> >>1) use TABs for _indentation_
> >>2) use SPACEs for aligning
> >>
> >>here is an exaple:
> >>
> >><tab><tab>if (cond) {
> >><tab><tab><tab>dosometing;
> >><tab><tab><tab>printf("This is foo: '%s', and this bar: '%d'",
> >><tab><tab><tab>       foo, bar);
> >>
> >>where tabs are explicitated, while spaces not.
> >>
> >>
> >>I think this way combines both tab and spaces advantages, allowing each coder
> >>to have its own indentation width, but NEVER destroing the aspect of the code.
> >>
> >>This is only my opinion :-P
> > 
> > 
> > I second that.
> > 
> > - Arnaldo
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 

