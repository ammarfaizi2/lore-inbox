Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSFYRYB>; Tue, 25 Jun 2002 13:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSFYRYB>; Tue, 25 Jun 2002 13:24:01 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:3994 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S315718AbSFYRX7>; Tue, 25 Jun 2002 13:23:59 -0400
Date: Tue, 25 Jun 2002 19:24:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: James Mayer <james@cobaltmountain.com>, linux-kernel@vger.kernel.org
Subject: Re: Typo in arch/mips/dec/wbflush.c 
In-Reply-To: <E17MtUK-0002mL-00@wagner.rustcorp.com.au>
Message-ID: <Pine.GSO.3.96.1020625185743.29623P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2002, Rusty Russell wrote:

> In message <20020624215505.GA7864@galileo> you write:
> > --- linux.orig-2.4.19-rc1/arch/mips/dec/wbflush.c	Fri Oct  5 13:06:51 200
> 1
> > +++ linux/arch/mips/dec/wbflush.c	Mon Jun 24 15:49:53 2002
> > @@ -97,7 +97,7 @@
> >  }
> >  
> >  /*
> > - * The DS500/2x0 doesnt need to write back the WB.
> > + * The DS500/2x0 doesn't need to write back the WB.
> >   */
> >  static void wbflush_kn03(void)
> >  {
> 
> Hmm...
> 
> 	I've only applied the one that was an actually a definite
> spellfix.  While I prefer to use apostrophes, it's a common
> abbreviation to skip it: 1/10 according to google.  Compare with
> another common misspelling (recieve) which is 1/50.
> 
> Given there is a non-zero cost (patch conflict with developers) even
> with trivial patches, I've decided not to apply your 41
> "doesnt"->"doesn't" patches, unless someone convinces me otherwise.

 There is a formal error in the sentence as well, actually, but I wouldn't
care as the file is to be majorly rewritten (changes are ready and
awaiting an approval of related stuff) and the comment will be removed
anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

