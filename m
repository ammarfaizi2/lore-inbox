Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261658AbREOW1s>; Tue, 15 May 2001 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbREOW1i>; Tue, 15 May 2001 18:27:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29709 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261658AbREOW1a>; Tue, 15 May 2001 18:27:30 -0400
Message-ID: <3B01AD4A.D074FE85@transmeta.com>
Date: Tue, 15 May 2001 15:27:22 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.GSO.4.21.0105151747060.22958-100000@weyl.math.psu.edu> <200105152224.f4FMOjj02219@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Alexander Viro writes:
> >
> >
> > On Tue, 15 May 2001, Richard Gooch wrote:
> >
> > > Alan Cox writes:
> > > > >         len = readlink ("/proc/self/3", buffer, buflen);
> > > > >         if (strcmp (buffer + len - 2, "cd") != 0) {
> > > > >                 fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > > >                 exit (1);
> > > >
> > > > And on my box cd is the cabbage dicer whoops
> > >
> > > Actually, no, because it's guaranteed that a trailing "/cd" is a
> > > CD-ROM. That's the standard.
> >
> > Set by...?
> 
> Me&Linus. The device name authority (Peter). Whoever. If you want
> Peter to bless it, then fine. But the standard is there. Violators
> will be persecuted.
> 

No, bad designers will be persecuted.  This is bad design.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
