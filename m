Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSE2KyM>; Wed, 29 May 2002 06:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSE2KyL>; Wed, 29 May 2002 06:54:11 -0400
Received: from [200.203.199.90] ([200.203.199.90]:52241 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S314829AbSE2KyL>; Wed, 29 May 2002 06:54:11 -0400
Date: Wed, 29 May 2002 01:27:53 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: miles@gnu.org, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020529042753.GC28492@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@transmeta.com>, miles@gnu.org,
	kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <3937.1022552654@kao2.melbourne.sgi.com> <buo3cwdf0b0.fsf@mcspd15.ucom.lsi.nec.co.jp> <20020528030200.GL20729@conectiva.com.br> <20020529142350.7cc6cc59.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 29, 2002 at 02:23:50PM +1000, Rusty Russell escreveu:
> On Tue, 28 May 2002 00:02:00 -0300
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> 
> > Em Tue, May 28, 2002 at 11:55:47AM +0900, Miles Bader escreveu:
> > > Keith Owens <kaos@ocs.com.au> writes:
> > > > The kernel can only be compiled with gcc, but some bits of the build
> > > > are compiled and run on the host, using the host compiler.  Avoid using
> > > > gccisms where there is a standard way of doing it.
> > > 
> > > That particular gccism completely infests the kernel, so there seems
> > > little point in avoiding it in favor of the uglier standard syntax.
> > 
> > Agreed.
> > 
> > What I'll do: continue using the simpler way that only gcc understands but
> > take care to not use gccisms when and if I patch build bits.
> 
> WARNING: The older form is deprecated.  From the info pages:
> 
> 	Another syntax which has the same meaning, obsolete since GCC 2.5, is
> `FIELDNAME:', as shown here:
> 
> Janitors wanted,

Ouch, Rusty, I'll reread the info pages and go over all the tree and start
submitting patches, starting tomorrow. Expect that sound, multiple times.

Powers that be: holler now or...

- Arnaldo
