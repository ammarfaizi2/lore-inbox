Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316248AbSEKSJy>; Sat, 11 May 2002 14:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316251AbSEKSJx>; Sat, 11 May 2002 14:09:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316248AbSEKSJu>; Sat, 11 May 2002 14:09:50 -0400
Date: Sat, 11 May 2002 11:09:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gerrit Huizenga <gh@us.ibm.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
In-Reply-To: <E176bZD-0008QD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205111108470.2355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 May 2002, Alan Cox wrote:
> >
> > The thing that has always disturbed me about O_DIRECT is that the whole
> > interface is just stupid, and was probably designed by a deranged monkey
> > on some serious mind-controlling substances [*].
>
> Used with aio its extremely nice. Without the aio patches its a bit lacking
> whenever readahead is useful

But the point is that AIO is needed just to cover up the fundamental
idiocy in the interface. If the interface had been properly designed, it
would have been useful _without_ AIO.

		Linus

