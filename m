Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRETBqu>; Sat, 19 May 2001 21:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbRETBqk>; Sat, 19 May 2001 21:46:40 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:52753 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S261289AbRETBqe>;
	Sat, 19 May 2001 21:46:34 -0400
Subject: Re: Brown-paper-bag bug in m68k, sparc, and sparc64 config files
From: Miles Lane <miles@megapathdsl.net>
To: Benedict Bridgwater <bennyb@ntplx.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B0718AB.7E2FF3A2@ntplx.net>
In-Reply-To: <3B0718AB.7E2FF3A2@ntplx.net>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 19 May 2001 18:51:42 -0700
Message-Id: <990323503.13907.1.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2001 21:06:51 -0400, Benedict Bridgwater wrote:
> > This bug unconditionally disables a configuration question -- and it's
> > so old that it has propagated across three port files, without either
> > of the people who did the cut and paste for the latter two noticing it.
> >
> > This sort of thing would never ship in CML2, because the compiler
> > would throw an undefined-symbol warning on BLK_DEV_ST.  The temptation
> > to engage in sarcastic commentary at the expense of people who still
> > think CML2 is an unnecessary pain in the butt is great.  But I will
> > restrain myself.  This time.
> 
> So a shortcoming of the CML1 tools justifies the CML2 language?
> 
> I guess the next bug found in the Python2 interpreter will justify
> writing CML3 in FORTRAN.

IIRC, Eric floated the CML2 idea over a year ago, provided some
rudimentary code and requested feedback.  There has seemed, for a long
time, to be agreement amoungst most kernel developers that there were
serious problems with CML1 and that it needed to be junked. There are
many things that CML1 was not going to allow us to do that will be
possible with CML2 (subsetting of the code tree, etc). I don't think
Eric's statement about this particular brown-paper-bag bug means that he
thinks that this alone justifies migrating to CML2. There are a lot of
good reasons for the migration. It isn't, perhaps, a perfect solution,
but it is one that Eric has implemented with a year's worth of effort,
with full knowledge of the kernel development community and with an open
invitation for contributions and feedback. To rag on it now seems
belated and unhelpful. It would be more useful if you helped Eric
improve CML2, since there appears to be agreement that it will be used
in 2.5.

	Miles

