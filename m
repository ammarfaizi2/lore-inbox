Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSE1CfW>; Mon, 27 May 2002 22:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSE1CfV>; Mon, 27 May 2002 22:35:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4869 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311752AbSE1CfU>; Mon, 27 May 2002 22:35:20 -0400
Date: Mon, 27 May 2002 23:35:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020528023519.GG20729@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020528021647.GE20729@conectiva.com.br> <3937.1022552654@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2002 at 12:24:14PM +1000, Keith Owens escreveu:
> On Mon, 27 May 2002 23:16:47 -0300, 
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> >Em Tue, May 28, 2002 at 12:05:54PM +1000, Keith Owens escreveu:
> >> Better still, use the C language standard:
> >> 
> >> 		.vendor = X86_VENDOR_INTEL,
> >
> >oops, gcc accepts that, good to know that this is standard C, but for the
> >kernel, I think that this doesn't matter as gcc is the only compiler that
> >understands the GCC Language 8) Or am I wrong? I'd love to be... 8)
> 
> The kernel can only be compiled with gcc, but some bits of the build
> are compiled and run on the host, using the host compiler.  Avoid using
> gccisms where there is a standard way of doing it.

I see, I was not thinking about those bits of the build, only kernel code, where
there are plenty of other gccisms.

/me will take a look at the latest C standard... :-)

- Arnaldo
