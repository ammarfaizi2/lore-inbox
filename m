Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSEYXdT>; Sat, 25 May 2002 19:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEYXdS>; Sat, 25 May 2002 19:33:18 -0400
Received: from Expansa.sns.it ([192.167.206.189]:40710 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S315445AbSEYXdR>;
	Sat, 25 May 2002 19:33:17 -0400
Date: Sun, 26 May 2002 01:29:34 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Dave Jones <davej@suse.de>
cc: "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
 -march=pentium{-mmx,3,4}
In-Reply-To: <20020526005359.E16102@suse.de>
Message-ID: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 May 2002, Dave Jones wrote:

> On Sun, May 26, 2002 at 01:37:39AM +0200, J.A. Magallon wrote:
>  > Could you also split
>  > 	Pentium-Pro/Celeron/Pentium-II     CONFIG_M686
>  > into
>  >
>  > 	Pentium-Pro            CONFIG_M686
>  > 	Pentium-II/Celeron     CONFIG_MPENTIUMII
>  >
>  > Gcc-3.1 has also a -march=pentium2 specific target, that is not a synomym
>  > for any other.
>
> There are also a few extra Athlon targets iirc. athlon-xp and the like,
> which I'm not sure the purpose of. Some gcc know-all want to clue me in
> to what these offer over -march=athlon ?
>
I do not know about the gcc options, but Athlon XP/MP has sse instruction,
while tbird has not, so it could be relate to this.

>  > BTW, I think an option to enable -mmmx would also be useful. Nothing more,
>  > because afaik sse is only floating point.
>
> Another interesting recently-added option which may be worth
> benchmarking on modern CPUs is the prefetch-loops option.
> In a lot of cases, the kernel 'knows better' and is adding the
> prefetches itself, but it may be interesting to see what difference
> gcc can make here. (More interesting would be examining the output to
> see *where* gcc is putting the prefetches)
>
> Given the immaturity of all these options, I'd doubt they're that good
> an idea for 2.4. Getting them tested during 2.5 may prove to get any
> bugs shaken out in time for $compiler_of_the_choice for 2.6 though.
>
>     Dave
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

