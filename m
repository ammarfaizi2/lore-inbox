Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSA1NIN>; Mon, 28 Jan 2002 08:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSA1NIK>; Mon, 28 Jan 2002 08:08:10 -0500
Received: from mustard.heime.net ([194.234.65.222]:33227 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288174AbSA1NHF>; Mon, 28 Jan 2002 08:07:05 -0500
Date: Mon, 28 Jan 2002 14:06:54 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Diego Calleja <grundig@teleline.es>, lkml <linux-kernel@vger.kernel.org>,
        <guido.leenders@invantive.com>
Subject: Re: PROBLEM: 2.4.17 crashes (VM bug?) after heavy system load
In-Reply-To: <E16UxfD-0002uK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0201281405540.27898-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002, Alan Cox wrote:

> > On 27 ene 2002, 22:49:17, Guido Leenders wrote:
> > >
> > > [1.] One line summary of the problem:
> > >
> > > Especially during times of heavy I/O, swapping and CPU processing, the
> > > OS crashes with an Oops.
> > I think andrea's patches should be applied into stable mainline NOW.
>
> Its up to Andrea to break up his patches and feed them to Marcelo as he
> has been asked. It also won't make any odds to this trace I suspect.
>
> Trying 2.4.18pre7 or applying the LRU patch to 2.4.17 that Ben LaHaise did
> should sort most of the 2.4.17 crashes out
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

What makes Andrea's patches better than Rik's?

My recent problem with the vm was easily solved with rmap.

See http://karlsbakk.net/dev/kernel/vm-fsckup.txt for more info

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

