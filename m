Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291658AbSBNNxM>; Thu, 14 Feb 2002 08:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291659AbSBNNww>; Thu, 14 Feb 2002 08:52:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:55764 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291658AbSBNNwl>; Thu, 14 Feb 2002 08:52:41 -0500
Date: Thu, 14 Feb 2002 14:49:02 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc1
In-Reply-To: <E16bM7s-0008TY-00@the-village.bc.nu>
Message-ID: <Pine.NEB.4.44.0202141446130.25879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Alan Cox wrote:

> >   tridentfb.c:524: #error "Floating point maths. This needs fixing before
> >   the driver is safe"
> >
> > which makes it pretty useless. Since this is a stable kernel series I want
> > to suggest that if there's no fix for this before 2.4.18-final to remove
> > the trident support from 2.4.18 and to re-add it in 2.4.19-pre1 (with
> > the hope that it will be fixed before 2.4.19-final).
>
> Or just comment out the Config.in line for it ?

Yes, this seems to be the best solution.

cu
Adrian


