Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273630AbRI3SL3>; Sun, 30 Sep 2001 14:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRI3SLT>; Sun, 30 Sep 2001 14:11:19 -0400
Received: from Expansa.sns.it ([192.167.206.189]:18193 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S273515AbRI3SLI>;
	Sun, 30 Sep 2001 14:11:08 -0400
Date: Sun, 30 Sep 2001 20:11:32 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "M. Edward Borasky" <znmeb@aracnet.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GCC 2.95, 2.96 and 3.0 on linear algebra (was RE: 2 GB file
 limitation)
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBMENEDNAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.33.0109302009120.9073-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, thanx,
I am very interested in those details.

For the tests i made on sparc64 gcc 3.0.1 is really faster than previous
versions (2.95.3 and egcs 1.1.2), but on AMD Athlon is a different story.
I think I can infer that gcc speed depends a lot from CPUs, but
usually and storically gcc was heavilly x86 optimized...

Luigi

On Sun, 30 Sep 2001, M. Edward Borasky wrote:

> I have heard from the Atlas linear algebra folks the following:
>
> 1. For compiling Atlas, both on Athlons and Pentia, GCC 2.95.x produces
> *significantly* faster operation than either 3.0.x or 2.96.x
> 2. For IA64, the reverse is true: GCC 3.0.x produces significantly faster
> code.
>
> I can dig up the URL for the mailing list if anyone cares for the details.
>
> --
> M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
> http://www.borasky-research.net  http://www.aracnet.com/~znmeb
> mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com
>
> Q: How do you tell when a pineapple is ready to eat?
> A: It picks up its knife and fork.
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Gábor Lénárt
> > Sent: Sunday, September 30, 2001 1:24 AM
> > To: Luigi Genoni
> > Cc: Linux Kernel
> > Subject: Re: 2 GB file limitation
>
> [snip]
>
> > > > I think you can get >2GB support if you've Gcc 3.0. Even with
> > the latest
> > > >
> > > ???
> > > I am using it and I am using gcc 2.95.3 for normal things,
> > > and to compiled my kernel and my libc, because gcc
> > > 3.0.1 produces slower binaries on my Athlons (yes, with athlon
> > > optimizzations turned on), at less for my programs, and it is better to
> > > avoid it for glibc compilation because of back compatibility issues.
> >
> > Yes, gcc3 is (well at least NOW) a piece of shit. It produces BIGGER and
> > SLOWER binaries ... Checked on: Athlon, AMD K6-2.
> > With the same gcc command line ...
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

