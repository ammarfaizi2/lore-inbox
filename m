Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSGBVtT>; Tue, 2 Jul 2002 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGBVtS>; Tue, 2 Jul 2002 17:49:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4370 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312681AbSGBVtN>; Tue, 2 Jul 2002 17:49:13 -0400
Date: Tue, 2 Jul 2002 17:56:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       <rth@twiddle.net>
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
In-Reply-To: <20020630024510.A725@localhost.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0207021753100.14729-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Jun 2002, Ivan Kokshaysky wrote:

> On Sat, Jun 29, 2002 at 03:26:18AM +0100, Alan Cox wrote:
> > Please fix the Alpha port. The behaviour fixed is _required_ by SuS.
>
> No objections, but
> a) it wasn't a bugfix (just a compliance crap)
> b) it seriously broke the alpha port right before the new
>    kernel release.
>
> > Make your own alpha syscall that handles this crap.
>
> I'd be happy to see that patch included in 2.4.20-pre1.

Actually I asked Richard Henderson at OLS if he could do the alpha syscall
do the stuff for -rc2.

I really don't like that "#ifdef alpha" stuff in generic code.

Richard? :)

