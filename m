Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSGVJhr>; Mon, 22 Jul 2002 05:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGVJhr>; Mon, 22 Jul 2002 05:37:47 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:2821 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S316609AbSGVJhq>; Mon, 22 Jul 2002 05:37:46 -0400
Date: Mon, 22 Jul 2002 10:08:14 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Adrian Bunk <bunk@fs.tum.de>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <1027278108.17234.109.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0207220937570.614-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21 Jul 2002, Alan Cox wrote:
> On Sun, 2002-07-21 at 16:23, Szakacsits Szabolcs wrote:
> > What about the many hundred counter-examples (e.g. umount gives EBUSY,
>
> umount -f.

The wasn't the question. *Why* umount (without -f) knows better then
admin? You answered *how* unconditionally umount.

> > kill can't kill processes in uninterruptible sleep, etc, etc)? Why the
> In these cases the kernel infrastructure doesn't support the ability to
> recover from such a state,

You again anwered else but ironically you just rebute yourself that
there are cases when the system knows better then the admin.

> very different from stopping a user doing something it can handle
> perfectly well.

What the patch claims is no OOM. In the swapoff case potentially there
are OOM's. This is called bug (the feature not follows the behavior
what it specified when admin turned it on). Why do you call this bug
perfectly handled case? What differentiate this case from all other
when the system knows better not to destroy your data without at least
a "force" operation for example?

	Szaka

