Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274161AbRI3Ufs>; Sun, 30 Sep 2001 16:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274146AbRI3Ufj>; Sun, 30 Sep 2001 16:35:39 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:51719 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S274134AbRI3UfY>; Sun, 30 Sep 2001 16:35:24 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Luigi Genoni" <kernel@Expansa.sns.it>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: GCC 2.95, 2.96 and 3.0 on linear algebra (was RE: 2 GB file limitation)
Date: Sun, 30 Sep 2001 13:35:48 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBOENMDNAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0109302009120.9073-100000@Expansa.sns.it>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Atlas main page is on SourceForge at

http://math-atlas.sourceforge.net/

The Atlas performance list archive is at

http://www.geocrawler.com/lists/3/SourceForge/15666/0/

and the main Atlas developer list archive is at

http://www.geocrawler.com/lists/3/SourceForge/15667/0/

I haven't seen any Sparc data; I have an Athlon at home and Pentia and
Alphas at work, so if Sparc results went by me I ignored them.

--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

> -----Original Message-----
> From: Luigi Genoni [mailto:kernel@Expansa.sns.it]
> Sent: Sunday, September 30, 2001 11:12 AM
> To: M. Edward Borasky
> Cc: Linux Kernel
> Subject: Re: GCC 2.95, 2.96 and 3.0 on linear algebra (was RE: 2 GB file
> limitation)
>
>
> yes, thanx,
> I am very interested in those details.
>
> For the tests i made on sparc64 gcc 3.0.1 is really faster than previous
> versions (2.95.3 and egcs 1.1.2), but on AMD Athlon is a different story.
> I think I can infer that gcc speed depends a lot from CPUs, but
> usually and storically gcc was heavilly x86 optimized...
>
> Luigi
>
> On Sun, 30 Sep 2001, M. Edward Borasky wrote:
>
> > I have heard from the Atlas linear algebra folks the following:
> >
> > 1. For compiling Atlas, both on Athlons and Pentia, GCC 2.95.x produces
> > *significantly* faster operation than either 3.0.x or 2.96.x
> > 2. For IA64, the reverse is true: GCC 3.0.x produces
> significantly faster
> > code.
> >
> > I can dig up the URL for the mailing list if anyone cares for
> the details.
> >
> > --
> > M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
> > http://www.borasky-research.net  http://www.aracnet.com/~znmeb
> > mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com
> >
> > Q: How do you tell when a pineapple is ready to eat?
> > A: It picks up its knife and fork.
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org
> > > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Gábor Lénárt
> > > Sent: Sunday, September 30, 2001 1:24 AM
> > > To: Luigi Genoni
> > > Cc: Linux Kernel
> > > Subject: Re: 2 GB file limitation
> >
> > [snip]
> >
> > > > > I think you can get >2GB support if you've Gcc 3.0. Even with
> > > the latest
> > > > >
> > > > ???
> > > > I am using it and I am using gcc 2.95.3 for normal things,
> > > > and to compiled my kernel and my libc, because gcc
> > > > 3.0.1 produces slower binaries on my Athlons (yes, with athlon
> > > > optimizzations turned on), at less for my programs, and it
> is better to
> > > > avoid it for glibc compilation because of back compatibility issues.
> > >
> > > Yes, gcc3 is (well at least NOW) a piece of shit. It produces
> BIGGER and
> > > SLOWER binaries ... Checked on: Athlon, AMD K6-2.
> > > With the same gcc command line ...
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>

