Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284073AbRLELPs>; Wed, 5 Dec 2001 06:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284072AbRLELP3>; Wed, 5 Dec 2001 06:15:29 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:22023 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S284068AbRLELPX>; Wed, 5 Dec 2001 06:15:23 -0500
Message-Id: <200112051115.fB5BF4Tt015845@pincoya.inf.utfsm.cl>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Tue, 04 Dec 2001 07:21:22 CDT." <20011204072122.A11746@thyrsus.com> 
Date: Wed, 05 Dec 2001 08:15:04 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > Unfortunately, the syntax of CML1 is rebarbative, and its imperative 
> > > semantics cannot be mechanically translated to CML2's declarative 
> > > semantics by any means I'm aware of.
> > 
> > The dependancy tree from CML1 is not that hard to obtain. It's not quite
> > complete or correct though
> 
> That's right -- and the devil would be in the incomplete/incorrect
> details. Areas of special pain: (1) cross-directory constraints, (2)
> derivations, (3) multiple port tree apexes.  These are all areas where
> CML1 has design flaws that human coders get around by applying
> higher-level knowledge of a kind a mechanical translator couldn't
> have.
> 
> This is, alas, one of those cases where the first 90% of the problem looks 
> easy and the last 10% turns ought to be nigh-impossible -- and the
> first 90% is useless without the last 10%.

And doing the hard work of getting even 60% done automatically for a
one-shot conversion (or very near of that) makes absolutely no sense.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
