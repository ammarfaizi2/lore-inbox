Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270814AbRHXAVJ>; Thu, 23 Aug 2001 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270817AbRHXAU7>; Thu, 23 Aug 2001 20:20:59 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:55740 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S270814AbRHXAUr>; Thu, 23 Aug 2001 20:20:47 -0400
Message-Id: <200108240021.f7O0L1Y18577@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Fred <fred@arkansaswebs.com>
Subject: Re: File System Limitations
Date: Thu, 23 Aug 2001 20:20:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01082316383301.12104@bits.linuxball> <3B858F58.1000606@nothing-on.tv> <01082318405901.12319@bits.linuxball>
In-Reply-To: <01082318405901.12319@bits.linuxball>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have a file size limit set in ulimit?
The last RedHat I installed had most of the limits set.

	-- Brian

On Thursday 23 August 2001 07:40 pm, Fred wrote:
> glibc-2.2.2-10
>
> dd if=/dev/zero of=./tgb count=4000 bs=1M
>
> created file of 2147483647 bytes
>
> [root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
> File size limit exceeded (core dumped)
> [root@bits /a5]#
>
> is glibc part of gcc? where do i find glibc?
> (I've recently compiled gcc-3.00, but won't install cause it breaks
> kernel compilations).
>
>
>
> TIA
>
> Fred
>
>  _________________________________________________
>
> On Thursday 23 August 2001 06:18 pm, Tony Hoyle wrote:
> > Fred wrote:
> > > so why dos my filesystem have a 2 GB limit?
> > > Must I specify a large block size or some such when i format?
> > >
> > > i run 2.4.9 on redhat7.1 out of the box
> >
> > Does it?  Unless RH are using a seriously old glibc (which I doubt)
> > there's no 2GB limit any more.
> >
> > Some older applications don't work with it AFAIK... anything bundled
> > with a modern distro shouldn't have any problems.
> >
> > Tony
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
