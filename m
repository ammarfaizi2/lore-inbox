Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317407AbSFCQC4>; Mon, 3 Jun 2002 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317408AbSFCQCz>; Mon, 3 Jun 2002 12:02:55 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:11795 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S317407AbSFCQCy>; Mon, 3 Jun 2002 12:02:54 -0400
Date: Mon, 3 Jun 2002 18:02:45 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Andre Hedrick <andre@serialata.org>
Subject: Re: Another -pre
In-Reply-To: <Pine.LNX.4.44.0206031155200.4146-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0206031757030.3741-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Marcelo Tosatti wrote:

> On Mon, 3 Jun 2002, Pawel Kot wrote:
>
> > On Mon, 3 Jun 2002, Marcelo Tosatti wrote:
> >
> > > Due to some missing network fixes and -ac merge, I'll release another -pre
> > > later today.
> > >
> > > -rc should be out by the end of the week.
> >
> > Would you please consider merging some IDE updates before releasing
> > 2.4.19? Current version remains unusable for me.
> > See http://marc.theaimsgroup.com/?l=linux-kernel&m=102277249800423&w=2
> > and followers for more detailes.
>
> Andre,
>
> Have you looked into this problem ?

Yes, Andre looked into this problem. His answer was to use -ac kernels, as
this series has the most complete IDE code. I patched the kernel with
ide-2.4.19-p7.all.convert.10.patch from linuxdiskcert.org (with required
changes to apply the patch) and DMA problem seems to disappear.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

