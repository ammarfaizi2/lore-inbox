Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbRETCT0>; Sat, 19 May 2001 22:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbRETCTH>; Sat, 19 May 2001 22:19:07 -0400
Received: from mail.ntplx.net ([204.213.176.10]:25026 "EHLO mail.ntplx.net")
	by vger.kernel.org with ESMTP id <S261356AbRETCTF>;
	Sat, 19 May 2001 22:19:05 -0400
Message-ID: <3B072889.1DC9E69A@ntplx.net>
Date: Sat, 19 May 2001 22:14:33 -0400
From: Ben Bridgwater <bennyb@ntplx.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Brown-paper-bag bug in m68k, sparc, and sparc64 config files
In-Reply-To: <3B0718AB.7E2FF3A2@ntplx.net> <990323493.13903.0.camel@agate>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> On 19 May 2001 21:06:51 -0400, Benedict Bridgwater wrote:
> > > This bug unconditionally disables a configuration question -- and it's
> > > so old that it has propagated across three port files, without either
> > > of the people who did the cut and paste for the latter two noticing it.
> > >
> > > This sort of thing would never ship in CML2, because the compiler
> > > would throw an undefined-symbol warning on BLK_DEV_ST.  The temptation
> > > to engage in sarcastic commentary at the expense of people who still
> > > think CML2 is an unnecessary pain in the butt is great.  But I will
> > > restrain myself.  This time.
> >
> > So a shortcoming of the CML1 tools justifies the CML2 language?
> >
> > I guess the next bug found in the Python2 interpreter will justify
> > writing CML3 in FORTRAN.
> 
> IIRC, Eric floated the CML2 idea over a year ago, provided some
> rudimentary code and requested feedback.  There has seemed, for a long
> time, to be agreement amoungst most kernel developers that there were
> serious problems with CML1 and that it needed to be junked. There are
> many things that CML1 was not going to allow us to do that will be
> possible with CML2 (subsetting of the code tree, etc). I don't think
> Eric's statement about this particular brown-paper-bag bug means that he
> thinks that this alone justifies migrating to CML2. There are a lot of
> good reasons for the migration. It isn't, perhaps, a perfect solution,
> but it is one that Eric has implemented with a year's worth of effort,
> with full knowledge of the kernel development community and with an open
> invitation for contributions and feedback. To rag on it now seems
> belated and unhelpful. It would be more useful if you helped Eric
> improve CML2, since there appears to be agreement that it will be used
> in 2.5.

Well if Eric is so concerned about his target audience then he certainly
doesn't show it through his arrogant comments. CML2 itself may be well
justified (although not on grounds of a diagnostic that CML1 tools could
be changed to generate!), but there's no reason the tools utilizing the
CML2 based rules shouldn't present a *superset* of the existing
functionality. To present a dumbed down UI targeted for "Aunt Millie" or
whoever against the protests of the mainstream kernel tool audience
makes zero sense to me, as don't Eric's repeated antagonistic comments.

Ben
