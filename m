Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSE1CQu>; Mon, 27 May 2002 22:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSE1CQt>; Mon, 27 May 2002 22:16:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61970 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311885AbSE1CQs>; Mon, 27 May 2002 22:16:48 -0400
Date: Mon, 27 May 2002 23:16:47 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020528021647.GE20729@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>, "J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020528012925.GB20729@conectiva.com.br> <3720.1022551554@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2002 at 12:05:54PM +1000, Keith Owens escreveu:
> On Mon, 27 May 2002 22:29:25 -0300, 
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> >	Since you're working on this could I suggest that you use labeled
> >elements, this gccism make the initialization above way more cleaner, safer and
> >easy to read :-) This is being used in the kernel in places like the FSes, the
> >TCP/IP stack and lots of other places.
> >+		vendor:	     X86_VENDOR_INTEL,
> >+		family:	     5,
> 
> Better still, use the C language standard:
> 
> 		.vendor = X86_VENDOR_INTEL,
> 		.family = 5,

oops, gcc accepts that, good to know that this is standard C, but for the
kernel, I think that this doesn't matter as gcc is the only compiler that
understands the GCC Language 8) Or am I wrong? I'd love to be... 8)

- Arnaldo
