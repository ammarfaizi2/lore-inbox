Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSHPRbN>; Fri, 16 Aug 2002 13:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSHPRbN>; Fri, 16 Aug 2002 13:31:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8171 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318641AbSHPRbM>; Fri, 16 Aug 2002 13:31:12 -0400
Date: Fri, 16 Aug 2002 19:35:02 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jean Delvare <khali@linux-fr.org>
cc: ben@beroul.uklinux.net, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 ATAPI cdrom I/O errors when reading CD-R
In-Reply-To: <20020816191508.5f9589b4.khali@linux-fr.org>
Message-ID: <Pine.NEB.4.44.0208161926380.6334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Jean Delvare wrote:

> > > Could you please try to read the same CD-R with kernel 2.4.18? If
> > > you still can't read the CD, try with kernel 2.4.17, and so on back
> > > to 2.2.20, so we have a chance to find the change causing the
> > > problem. (Be careful to skip problematic kernels, 2.4.15 and 2.4.11
> > > come to mind.)
> >
> > This is a joke, isn't it?
>
> Hm no, wasn't. I couldn't see another solution. Seems a bit hard to
> reproduce on another system, since it must be related to the specific
> hardware (drive, writer and CD-R) used.

The way you suggested to check for the first kernel version that was
broken works if you want to find the exact version when something breaks
e.g. between -pre3 and -pre6. Between two major releases of Linux there
are
1. too many releases and
2. the development kernels might be broken in _many_ different ways which
   would make it hard to find the version where the current breakage
   occured first; and not to forget
3. it costs much time to compile try let's say 40 different kernels (not
   to mention that each of them has its' unique bugs)

> What would you suggest?

Someone with a better knowledge of ATAPI might be able to understand what
the error messages say and to either understand the problem or to tell how
to trace it down.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox







