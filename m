Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132677AbRDKRSw>; Wed, 11 Apr 2001 13:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRDKRSm>; Wed, 11 Apr 2001 13:18:42 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:40976 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S132677AbRDKRSX>; Wed, 11 Apr 2001 13:18:23 -0400
Message-ID: <3AD491C9.6424D932@zk3.dec.com>
Date: Wed, 11 Apr 2001 13:18:01 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha "process table hang"
In-Reply-To: <20010411104040.A8773@draal.physics.wisc.edu> <3AD489D1.D5FCCB4B@zk3.dec.com> <20010411120044.A6472@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmpf.  Haven't seen this at all on any of the Alphas that I'm running.  What
exact system are you seeing this on, and what are you running when it happens?

 - Pete

Bob McElrath wrote:

> Peter Rival [frival@zk3.dec.com] wrote:
> > You wouldn't happen to have khttpd loaded as a module, would you?  I've seen
> > this type of problem caused by that before...
>
> Nope...
>
> >
> >  - Pete
> >
> > Bob McElrath wrote:
> >
> > > I've been experiencing a particular kind of hang for many versions
> > > (since 2.3.99 days, recently seen with 2.4.1, 2.4.2, and 2.4.2-ac4) on
> > > the alpha architecture.  The symptom is that any program that tries to
> > > access the process table will hang. (ps, w, top) The hang will go away
> > > by itself after ~10minutes - 1 hour or so.  When it hangs I run ps and
> > > see that it gets halfway through the process list and hangs.  The
> > > process that comes next in the list (after hang goes away) almost always
> > > has nonsensical memory numbers, like multi-gigabyte SIZE.
> > >
> > > Linux draal.physics.wisc.edu 2.3.99-pre5 #8 Sun Apr 23 16:21:48 CDT 2000
> > > alpha unknown
> > >
> > > Gnu C                  2.96
> > > Gnu make               3.78.1
> > > binutils               2.10.0.18
> > > util-linux             2.11a
> > > modutils               2.4.5
> > > e2fsprogs              1.18
> > > PPP                    2.3.11
> > > Linux C Library        2.2.1
> > > Dynamic linker (ldd)   2.2.1
> > > Procps                 2.0.7
> > > Net-tools              1.54
> > > Kbd                    0.94
> > > Sh-utils               2.0
> > > Modules Loaded         nfsd lockd sunrpc af_packet msdos fat pas2 sound
> > > soundcore
> > >
> > > Has anyone else seen this?  Is there a fix?
> > >
> > > -- Bob
> > >
> > > Bob McElrath (rsmcelrath@students.wisc.edu)
> > > Univ. of Wisconsin at Madison, Department of Physics
> > >
> > >   ------------------------------------------------------------------------
> > >    Part 1.2Type: application/pgp-signature
> -- Bob
>
> Bob McElrath (rsmcelrath@students.wisc.edu)
> Univ. of Wisconsin at Madison, Department of Physics
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

