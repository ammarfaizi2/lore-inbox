Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbRFUIoa>; Thu, 21 Jun 2001 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264906AbRFUIoU>; Thu, 21 Jun 2001 04:44:20 -0400
Received: from Expansa.sns.it ([192.167.206.189]:54281 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264857AbRFUIoJ>;
	Thu, 21 Jun 2001 04:44:09 -0400
Date: Thu, 21 Jun 2001 10:43:56 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Eric Lammerts <eric@lammerts.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.20-pre4
In-Reply-To: <Pine.LNX.4.33.0106202259290.21784-100000@ally.lammerts.org>
Message-ID: <Pine.LNX.4.33.0106211041260.15011-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried this too, but i have the feeling the kernel compiled with this gcc
3.0 is somehow slower. context switch is slower....
no benchs (no time to make them) to sustain my feeling, just a feeling...

On Wed, 20 Jun 2001, Eric Lammerts wrote:

>
> On Tue, 19 Jun 2001, Alan Cox wrote:
> > > Is it mean now kernel 2.2 with prepatch is (or will be) gcc 3.0 ready ?
> > > If not what must be fixed/chenged to be ready ?
> >
> > It wont build with gcc 3.0 yet. To start with gcc 3.0 will assume it can
> > insert calls to 'memcpy'
>
> I tried it, but didn't run into problems (apart from the volatile
> xtime thing)
>
> Linux version 2.2.18 (eric@andredvb) (gcc version 3.0 (Debian))
> #1 Wed Jun 20 23:15:46 CEST 2001
>
> (Tons of warnings, though)
>
> Eric
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

