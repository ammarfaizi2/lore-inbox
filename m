Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbREBKzn>; Wed, 2 May 2001 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbREBKze>; Wed, 2 May 2001 06:55:34 -0400
Received: from chiara.elte.hu ([157.181.150.200]:62473 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132606AbREBKzZ>;
	Wed, 2 May 2001 06:55:25 -0400
Date: Wed, 2 May 2001 12:53:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        Fabio Riccardi <fabio@chromium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010502125243.A518@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0105021252440.5505-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 May 2001, Andi Kleen wrote:

> > Whatever happened to that hack that was discussed a year or two ago?
> > The one where (also on IA32) a magic page was set up by the kernel
> > containing code for fast system calls, and the kernel would write
> > calibation information to that magic page. The code written there
> > would use the TSC in conjunction with that calibration data.
> >
> > There was much discussion about this idea, even Linus was keen on
> > it. But IIRC, nothing ever happened.
>
> It's already implemented in the x86-64 port, thanks to Andrea
> Arcangelli.

well, it was first prototyped in the vsyscall patches :-)

	Ingo

