Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSE2EZL>; Wed, 29 May 2002 00:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314221AbSE2EZK>; Wed, 29 May 2002 00:25:10 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:63939 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S314149AbSE2EZJ>; Wed, 29 May 2002 00:25:09 -0400
Date: Wed, 29 May 2002 14:23:50 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: miles@gnu.org, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-Id: <20020529142350.7cc6cc59.rusty@rustcorp.com.au>
In-Reply-To: <20020528030200.GL20729@conectiva.com.br>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2002 00:02:00 -0300
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> Em Tue, May 28, 2002 at 11:55:47AM +0900, Miles Bader escreveu:
> > Keith Owens <kaos@ocs.com.au> writes:
> > > The kernel can only be compiled with gcc, but some bits of the build
> > > are compiled and run on the host, using the host compiler.  Avoid using
> > > gccisms where there is a standard way of doing it.
> > 
> > That particular gccism completely infests the kernel, so there seems
> > little point in avoiding it in favor of the uglier standard syntax.
> 
> Agreed.
> 
> What I'll do: continue using the simpler way that only gcc understands but
> take care to not use gccisms when and if I patch build bits.

WARNING: The older form is deprecated.  From the info pages:

	Another syntax which has the same meaning, obsolete since GCC 2.5, is
`FIELDNAME:', as shown here:

Janitors wanted,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
