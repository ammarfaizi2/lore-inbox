Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSEMMKL>; Mon, 13 May 2002 08:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSEMMKK>; Mon, 13 May 2002 08:10:10 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:62981 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313179AbSEMMKJ>; Mon, 13 May 2002 08:10:09 -0400
Date: Mon, 13 May 2002 14:09:53 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: riel@conectiva.com.br, Johnny Mnemonic <johnny@themnemonic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513120953.GD4258@louise.pinerecords.com>
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com> <200205131152.OAA05817@infa.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 16:18)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Marcus Alanen <marcus@infa.abo.fi>, May-13 2002, Mon, 14:52 +0300]
> 
> Combining the efforts, the following almost makes coffee.

Neat!

> - Short mode
> - Full mode
> - Original mode
> 
> The original mode you requested prints the e-mail address, I guess
> it should be the author's real name to look more nice.

Okay.. how about the name db? That seems to be the last feature missing.

>                 s/^\s*(.*)\s*$/$1/;
>                 $_ =~ s/\[PATCH\] //g;
>                 $_ =~ s/\s*PATCH //g;

s/^\s*(.*)\s*$/$1/;
s/^\[?PATCH\]?\s*//;

will be sufficient I believe. Also, the "/g" is not a good idea.


T.
