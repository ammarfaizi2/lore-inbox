Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSIUTCW>; Sat, 21 Sep 2002 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSIUTCW>; Sat, 21 Sep 2002 15:02:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16888 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262525AbSIUTCW>; Sat, 21 Sep 2002 15:02:22 -0400
Date: Sat, 21 Sep 2002 21:07:24 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems building bzImage with 2.5.*
In-Reply-To: <20020921185013.GA1320@middle.of.nowhere>
Message-ID: <Pine.NEB.4.44.0209212057440.10334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Jurriaan wrote:

> > I'm quite new to the list and I'm not sure if this has been posted
> > already but I thought I would give it a shot. I've been trying to
> > build the 2.5.* kernels (2.5.37 at the moment but this has happened
> > with previous version as well) and when doing a make bzImage i keep
> > getting the following error during the final linkage:
> >
> > drivers/built-in.o(.data+0xac34): undefined reference to `local
> > symbols in discarded section .text.exit'
> > make: *** [vmlinux] Error 1
> >
> I think this means you need to update your binutils.

You are wrong. One workaround would be to _downgrade_ binutils.

> Kind regards,
> Jurriaan

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


