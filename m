Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSEaRKw>; Fri, 31 May 2002 13:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSEaRKv>; Fri, 31 May 2002 13:10:51 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:21005 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S316289AbSEaRKv>; Fri, 31 May 2002 13:10:51 -0400
Date: Fri, 31 May 2002 19:10:40 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Kjartan Maraas <kmaraas@online.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.19-pre9] DMA not available
In-Reply-To: <1022855932.11533.41.camel@sevilla.gnome.no>
Message-ID: <Pine.LNX.4.33.0205311909140.10960-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2002, Kjartan Maraas wrote:

> tor, 2002-05-30 kl. 17:24 skrev Pawel Kot:
> > Hi,
> >
> > I can't enable DMA with 2.4.19-pre9 with my Dell laptop:
> > root@bzzzt:~# hdparm -d 1 /dev/hda
> >
> > /dev/hda:
> >  setting using_dma to 1 (on)
> >  HDIO_SET_DMA failed: Operation not permitted
> >  using_dma    =  0 (off)
>
> This looks like the same problems I had a while back with my Compaq Evo
> N600. It was fixed for me by using the patches from
> http://linuxdiskcert.org/

Indeed. I applied the patch (with a few modifications to apply against
pre9) and it seems to work correctly so far (at least DMA works). Thanks
for the hint.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

